//
//  SpecialInfoView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 2/24/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import WebKit

protocol SpecialInfoViewDelegate{
    func setGeneralView(_ fromView: String)
    func closeSpecialView()
}

class SpecialView: UIView, SpecialInfoViewDelegate, SpecialFormDelegate, WKNavigationDelegate, PaymentDelegate, PayViewDelegate, OutSidePeymentDelegate{
    
    var delegateSpecialInfoView: SpecialInfoViewDelegate?
    func delegate(_ delegate: SpecialInfoViewDelegate){
        self.delegateSpecialInfoView = delegate
    }
    
    var fromView = String()
    
    let values = SpecialInfoViewValues()
    let duration: CFTimeInterval = 0.7
    var canGetDiet: Bool { specialInformation.canGetDiet }   //    آماده ارسال

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var redirectPay = false

    //MARK: INIT VIEW
    func initView(_ fromView: String){
        self.fromView = fromView
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(sceneDidBecomeActive),
                                                   name: UIScene.didActivateNotification,
                                                   object: nil) }
        else { appDelegate.delegatePayed = self }
        paymentConnection.delegate(self)
        setTopFrame()
        setBottomFrame()
        setSpecialInfoForm()
        setWebContainer()
        startView()
        enablePay()
    }
    
    //MARK: TOP BAR
    var topBar = UIView()
    func setTopFrame(){
        topBar.frame(topFrame)
        topBar.shadow(CGSize(0, 1), gray09, 0.5, 0.5)
//        topBar.blurBack(2, 1)
        topBar.backgroundColor(barBackgroundColor.opacity(0.8))
        setName()
        setSubTitle()
        setBackButton()
        setClearButton()
        addSubview(topBar)
    }
    
    //MARK: NAME
    var name = UILabel()
    func setName(){
        name.frame(70,
                   topBar.height - (hasSafeArea ? 60 : 57),
                   width-140,
                   35)
        name.text(profile.fullName)
        name.font(Sahel_Bold, 24)
        name.textColor(specialInfoColor)
        name.textAlignment(.center)
        name.adjustsFontSizeToFitWidth(true)
        topBar.addSubview(name)
    }
    
    //MARK: SUBTITLE
    var subTitle = SubTitle()
    func setSubTitle(){
        let string = values.subTitle
        let font = values.subTitleFont
        let width = string.width(height: 19, font: font) + 10
        subTitle.frame(topBar.width/2 - width/2,
                       topBar.height - 22,
                       width,
                       20)
        subTitle.string(string)
        subTitle.backColor(specialInfoColor)
        subTitle.font(font)
        subTitle.initView()
        topBar.addSubview(subTitle)
    }
    
    //MARK: BACK
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(isRTL ? width - 63 : 3,
                         topBar.height - (hasSafeArea ? 58 :  54),
                         60,
                         52)
        backButton.image01(BACK_IMG)
        backButton.text(values.backButtonTitle)
        backButton.onTap(self, #selector(close), 1)
        backButton.initView()
        topBar.addSubview(backButton)
    }
    
    var isClose = false
    @objc func close(){
        if !isClose{
            isClose = true
            closeView()
            setGeneralView(fromView)
        }
    }
    
    func setGeneralView(_ fromView: String) {
        delegateSpecialInfoView?.setGeneralView(fromView)
    }
    
    //MARK: NEW
    var newSpecial = BarButton()
    func setClearButton(){
        newSpecial.frame(isRTL ? 3 : topBar.width - 63,
                         topBar.height - (hasSafeArea ? 58 :  54),
                         60,
                         52)
        newSpecial.image01(CLEAN_IMG)
        newSpecial.text(values.newButtonTitle)
        newSpecial.opacity(0)
        newSpecial.onTap(self, #selector(newForm), 1)
        newSpecial.initView()
        topBar.addSubview(newSpecial)
    }
    
    @objc func newForm(){
        specialInfoForm.closeView()
        specialInfoForm.stopSound()
        newSpecial.animate(opacity: 0, 0.5, curve)
        var _:Timer = Timer.schedule(1) { _ in self.new() }
    }
    
    //MARK: RE INITIALIZE FORM
    @objc func new(){
        specialInfoForm.remove()
        specialInformation.reset()
        specialInfoForm = SpecialForm()
        setSpecialInfoForm()
        specialInfoForm.transformY(height)
        specialInfoForm.animate(transform: .identity, 1, curve)
    }
    
    //MARK: SEPECIAL FORM
    var specialInfoForm = SpecialForm()
    func setSpecialInfoForm(){
        specialInfoForm.frame(midFrame)
        specialInfoForm.initView()
        specialInfoForm.delegate(self)
        addSubview(specialInfoForm, below: topBar)
    }
    
    //MARK: OPEN
    func open() {
        newSpecial.animate(opacity: specialInfoForm.formHeight > 900 ? 1 : 0, duration, curve)
        enablePay()
    }
        
    func focus(){
        enablePay()
    }

    func enablePay(){
        bottomBar.animate(backgroundColor: canGetDiet ? green01.opacity(0.8) : barBackgroundColor.opacity(0.8), 1, curve)
        bottomTitle.textColor(canGetDiet ? gray0 : gray04)
    }
    
    //MARK: BOTTOM BAR
    var bottomBar = UIView()
    func setBottomFrame(){
        bottomBar.frame(btmFrame)
        bottomBar.shadow(CGSize(0, -1), gray09, 0.5, 0.5)
//        bottomBar.blurBack(2, 1)
        bottomBar.backgroundColor(barBackgroundColor)
        setBottomTitle()
        bottomBar.onTap(self, #selector(pay))
        addSubview(bottomBar , above: specialInfoForm)
    }
    
    //MARK: BOTTOM TITLE
    var bottomTitle = UILabel()
    func setBottomTitle(){
        bottomTitle.frame(0, 0, width, 55)
        bottomTitle.text(values.bottomTitle)
        bottomTitle.font(Shabnam, 18)
        bottomTitle.textColor(gray05)
        bottomTitle.numberOfLines(0)
        bottomTitle.shadow(CGSize(0, 1), gray09, 1, 0)
        bottomTitle.textAlignment(.center)
        bottomBar.addSubview(bottomTitle)
    }
    
    //MARK: - PAY
    var canPay = true
    @objc func pay(){
        if canPay && canGetDiet{
            if isConnected{ showWebView() }
            else{ dietConnection.connectionError() }
        }
    }
    
    func showWebView(){
        if appVersion.outOfAppPayement{
            redirectPay = true
            guard let url = URL(string: paymentConnection.payUrlString) else { return }
            UIApplication.shared.open(url)
        }else{
            webContainer.showWebView()
            webContainer.animate(transform: .identity, 1, curve)
        }
    }
    
    func payed() {
        redirectPay = false
        paymentConnection.paymentResult()
    }
    
    func cancelPayment() {
        redirectPay = false
        closeWebView()
    }
    
    func didBecome(){
        if redirectPay { paymentConnection.paymentResult() }
        redirectPay = false
    }
    
    @objc func sceneDidBecomeActive(){
        if redirectPay { paymentConnection.paymentResult() }
        redirectPay = false
    }
    
    //MARK: WEB CONTAINER
    var webContainer = PayView()
    func setWebContainer(){
        webContainer.frame(bounds)
        webContainer.transformY(height)
        webContainer.delegate(self)
        webContainer.initView()
        addSubview(webContainer)
    }
   
    func exitPayment() {
        closeWebView()
    }
    
    //MARK: CLOSE WEB
    @objc func closeWebView(){
        canPay = false
        bottomBar.animate(backgroundColor: red01 , 1, curve)
        webContainer.animate(transformY: height, 0.8, curve)
        bottomTitle.text(values.cancelPayment)
        bottomTitle.textColor(gray0)
        bottomTitle.animate(opacity: 0, 0.5, curveEaseOut05, 3)
        var _:Timer = Timer.schedule(3.5) { _ in
            self.canPay = true
            self.bottomTitle.text(self.values.bottomTitle)
            self.bottomTitle.animate(opacity: 1, 1, curve)
            self.bottomBar.animate(backgroundColor: green01.opacity(0.8) , 1, curve)
        }
    }
    
    //MARK: PURCHASED
    func purchased() {
    }
    
    func paymentError(){
        var _ = Timer.schedule(0.5) { _ in  paymentConnection.getDiet() }
    }
    
    func postDiet(){
        webContainer.animate(y: height + webContainer.height/2 + 30, 1, curve)
        topBar.animate(transformY:  -topBar.height, duration, curve)
        bottomBar.animate(transformY: bottomBar.height, duration, curve)
        specialInfoForm.closeView()
        setTrackingCode()
        specialInformation.reset()
        setSibDietView()
        setBack()
    }
    
    //MARK: SIBDIET
    var sibDietView = SibDietView()
    func setSibDietView(){
        sibDietView.frame(0, topFrame.height*2, width, 35)
        sibDietView.initView()
        sibDietView.startView()
        addSubview(sibDietView)
    }
    
    //MARK: TRACKING CODE
    var trackingCode = UILabel()
    func setTrackingCode(){
        trackingCode.frame(20, height/2 + 80, WIDTH - 40, 160)
        trackingCode.opacity(0)
        trackingCode.attributedText(values.trackingCode)
        trackingCode.backgroundColor(gray02)
        trackingCode.cornerRadius(10)
        trackingCode.clipsToBounds(true)
        trackingCode.border(gray03, 2)
        trackingCode.textAlignment(.center)
        trackingCode.lineBreakMode(.byCharWrapping)
        trackingCode.numberOfLines(0)
        trackingCode.animate(opacity: 1, 1, curve, 1)
        trackingCode.animate(y: trackingCode.y - 100, 0.7, curve, 1)
        addSubview(trackingCode)
    }
    
    //MARK: BACK
    var back = BarButton()
    func setBack(){
        back.frame(10, topFrame.height, 60, 52)
        back.image01(BACK_IMG)
        back.text(values.backButtonTitle)
        back.onTap(self, #selector(closeSpecialView))
        back.opacity(0)
        back.animate(opacity: 1, 1, curve, 1)
        back.initView()
        addSubview(back)
    }
    
    //MARK: CLOSE FORM
    @objc func closeSpecialView(){
        trackingCode.animate(opacity: 0, duration, curve)
        trackingCode.animate(y: trackingCode.y - 100, duration, curve)
        back.animate(opacity: 0, duration, curve)
        sibDietView.closeView()
        delegateSpecialInfoView?.closeSpecialView()
        var _ = Timer.schedule(0.7) { _ in self.specialInfoForm.remove() }
    }
    
    //MARK: START VIEW
    func startView(){
        topBar.transformY(-topBar.height)
        topBar.animate(transform: .identity, 0.7, curve, 0.4)
        bottomBar.transformY(bottomBar.height)
        bottomBar.animate(transform: .identity, duration, curve, 0.4)
        specialInfoForm.transformY(height)
        specialInfoForm.animate(transform: .identity, 1.2, curve)
        newSpecial.opacity(specialInfoForm.formHeight > 900 ? 1 : 0)
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        topBar.animate(transformY: -topBar.height, duration, curve, 0.2)
        bottomBar.animate(transformY: bottomBar.height, duration, curve, 0.2)
        specialInfoForm.closeView()
        specialInfoForm.stopSound()
        var _ = Timer.schedule(1.9) { _ in self.remove() }
    }
}
