//
//  BodyViewV2.swift
//  Sibdiet

//  Created by Me on 7/15/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol BodyViewDelegate {
    func backBody(toView : String)
    func setGeneralView(_ fromView: String)
}

class BodyView: UIView, BodyViewDelegate, BodyFormDelegate{
   
    let values = BodyViewValues()
    var enable = false
    var hasWrist: Bool { updateBody.wrist.hasResult }
    
    var seeHelp: Bool{
        get{ standard.bool(forKey: "SdrHpr") }
        set{ standard.set(newValue, forKey: "SdrHpr") }
    }
    
    var delegateBodyView : BodyViewDelegate?
    func delegate(_ delegate: BodyViewDelegate){
        delegateBodyView = delegate
    }
    
    var fromView = String()
    
    //MARK: INIT VIEW
    func initView(_ fromView: String){
        self.fromView = fromView
        isClose = false
        setTopBar()
        setBottomBar()
        setBodyForm()
        startView()
        if !seeHelp { setHelpView() }
    }
    
    //MARK: HELP VIEW
    var helpView = BodySliderHelpView()
    func setHelpView(){
        helpView.frame(bounds)
        helpView.setTitle(values.help)
        helpView.initView()
        var _ = Timer.schedule(3) {_ in
            self.helpView.onTap(self, #selector(self.tapHelp(tap:)))
        }
        addSubview(helpView)
    }
    
    @objc func tapHelp(tap: UITapGestureRecognizer){
        seeHelp = true
        helpView.closeView()
    }
    
    //MARK: TOPBAR
    var topBar = UIView()
    func setTopBar(){
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
    var name = CATextLayer()
    func setName(){
        let font = UIFont(Sahel_Bold, 25)!
        var width = profile.fullName.width(height: 35, font: font)
        width = width > self.width-130 ? self.width-160 : width
        name.frame(self.width/2 - width/2,
                   topBar.height - (hasSafeArea ? 62 : 59),
                   width,
                   35)
        name.string(profile.fullName)
        name.font(Sahel_Bold, 25)
        name.foregroundColor(UIColor(0x00ACC1))
        name.shadow(.zero, white, 1.5, 1)
        name.alignmentMode(.center)
        name.contentsScale()
        topBar.addSublayer(name)
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
        subTitle.backColor(UIColor(0x00ACC1))
        subTitle.font(font)
        subTitle.initView()
        topBar.addSubview(subTitle)
    }
    
    //MARK: BACK BUTTON
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(isRTL ? width - 63 : 3,
                         topBar.height - (hasSafeArea ? 58 :  54),
                         60,
                         52)
        backButton.image01(BACK_IMG)
        backButton.text(values.backButtonTitle)
        backButton.initView()
        backButton.onTap(self, #selector(back))
        topBar.addSubview(backButton)
    }
    
    var isClose = false
    @objc func back(){
        if !isClose{
            isClose = true
            closeView()
            var _ = Timer.schedule(0.5) { _ in self.backBody(toView: self.fromView) }
        }
    }
    
    @objc func backBody(toView : String){
        delegateBodyView?.backBody(toView: fromView)
    }
    
    //MARK: NEW BUTTON
    var newBody = BarButton()
    func setClearButton(){
        newBody.frame(isRTL ? 3 : topBar.width - 63,
                      topBar.height - (hasSafeArea ? 58 :  54),
                      60,
                      52)
        newBody.image01(CLEAN_IMG)
        newBody.text(values.newButtonTitle)
        newBody.onTap(self, #selector(newBodyView), 1)
        newBody.opacity(0)
        newBody.initView()
        topBar.addSubview(newBody)
    }
    
    @objc func newBodyView(){
        bodyForm.closeView()
        newBody.opacity(0)
        var _:Timer = Timer.schedule(1.0) { _ in
            updateBody.reset()
            self.bodyForm = BodyForm()
            self.setBodyForm()
            self.bottomFrameColor()
        }
    }
    
    //MARK: BODY FORM
    lazy var bodyForm = BodyForm()
    func setBodyForm(){
        bodyForm.frame(midFrame)
        bodyForm.delegate(self)
        bodyForm.initView()
        addSubview(bodyForm, below: topBar)
    }
    
    func open(color: UIColor){
        var j = 0
        for s in bodyForm.bodyForm{ j = s.enable ? j + 1 : j }
        if j > 2 { newBody.animate(opacity: 1, 0.5, curve) }
        name.animate(foregroundColor: color, 0.7, easeInOut05)
        subTitle.selected(color: color)
    }
    
    //MARK: BOTTOM BAR
    var bottomBar = UIView()
    func setBottomBar(){
        bottomBar.frame(btmFrame)
        bottomBar.shadow(CGSize(0, -1), gray09, 0.5, 0.5)
//        bottomBar.blurBack(2, 1)
        bottomBar.backgroundColor(barBackgroundColor.opacity(0.8))
        setBottomTitle()
        bottomBar.onTap(self, #selector(specialInfo))
        addSubview(bottomBar, above: topBar)
    }
    
    func enableSpecial(){
        bottomFrameColor()
    }
    
    @objc func specialInfo(){
        if !isClose && hasWrist{
            isClose = true
            closeView()
            setGeneralView(fromView)
        }
    }
    
    func setGeneralView(_ fromView: String) {
        delegateBodyView?.setGeneralView(fromView)
    }
    
    //MARK: BOTTOM TITLE
    var bottomTitle = UILabel()
    func setBottomTitle(){
        bottomTitle.frame(0, 0, width, 55)
        bottomTitle.text(values.bottomTitle)
        bottomTitle.font(Shabnam, 18)
        bottomTitle.textColor(gray05)
        bottomTitle.shadow(CGSize(0, 1), gray09, 1, 0)
        bottomTitle.textAlignment(.center)
        bottomBar.addSubview(bottomTitle)
    }
    
    func bottomFrameColor(){
        if hasWrist{
            bottomBar.animate(backgroundColor: skyBlue01.opacity(0.7), 1, curve)
            bottomTitle.textColor(gray0)
            bottomTitle.shadowOpacity = 0.7
        }else{
            bottomBar.animate(backgroundColor: barBackgroundColor.opacity(0.9), 1, curve)
            bottomTitle.textColor(gray05)
            bottomTitle.shadowOpacity = 0
        }
    }
    
    //MARK: START VIEW
    func startView(){
        if !enable{
            enable = true
            var j = 0
            for s in bodyForm.bodyForm{ j = s.enable ? j + 1 : j }
            newBody.animate(opacity: j > 2 ? 1 : 0, 0.5, curve)
            topBar.transformY(-topBar.height)
            topBar.animate(transform: .identity, 0.7, curve, 0.5)
            bottomBar.transformY(bottomBar.height)
            bottomBar.animate(transform: .identity, 0.7, curve, 0.5)
            bottomFrameColor()
        }
    }
    
    func closeForm(){
        back()
    }
    
    //MARK: CLOSEVIEW
    func closeView(){
        if enable {
            enable = false
            topBar.animate(transformY: -topBar.height, 0.7, curve)
            bottomBar.animate(transformY: bottomBar.height, 0.7, curve)
            bodyForm.closeView()
            var _ = Timer.schedule(3) { _ in self.remove() }
        }
    }    
}
