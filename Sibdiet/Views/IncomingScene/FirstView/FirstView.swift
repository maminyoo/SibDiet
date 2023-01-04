//
//  FirstView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 9/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol FirstViewDelegate {
    func onAbout()
    func closeFirstView()
    func onRegister()
    func resetLoading()
    func connectionError()
}

class FirstView: UIView, LoginViewDelegate, FirstViewDelegate, SwitchLangsDelegate, LoadProfileDelegate, InLoadingDelegate{
    
    var delegateFirstView: FirstViewDelegate?
    func delegate(_ delegate: FirstViewDelegate){
        self.delegateFirstView  = delegate
    }
    
    var enable = false
    var enableBack = false
    var hide = false
    
    let values = FirstViewValues()

    //MARK: INIT VIEW
    func initView(){
        dietConnection.delegateLoadProfile = self
        dietConnection.delegateInLoading = self
        setDr()
        setCover()
        setSibDietView()
        setBottomView()
        setLoginView()
        setBackButton()
        if inOtherBlud || language != FA && !appVersion.outOfAppPayement { setLangView() }
        if users.hasUser{ setBackButton() }
        startView()
    }
    
    var inLoading = false
    func inLoading(_ bool: Bool){
        inLoading = bool
    }
    
    //MARK: COVER VIEW
    let coverView = UIView()
    func setCover(){
        coverView.frame(0, 0, width, hasSafeArea ? 30 : 0)
        coverView.backgroundColor(gray01)
        coverView.opacity(0)
        coverView.animate(opacity: 1, 1, curve, 1)
        addSubview(coverView)
    }
    
    //MARK: DR VIEW
    var drView = UIView()
    func setDr(){
        drView.frame(width/2 - 80, -130+(hasSafeArea ? 44 : 20), 160, 300)
        drView.backgroundColor(gray02)
        drView.cornerRadius(30)
        drView.border(gray0, 7)
        drView.clipsToBounds(true)
        setDrImage()
        addSubview(drView)
    }
    
    var drImage = CALayer()
    func setDrImage(){
        drImage.frame(-20, 110, 200, 200)
        drImage.contents(UIImage(DR_IMG)!)
        drImage.contentsGravity(.resizeAspect)
        drView.addSublayer(drImage)
    }
    
    //MARK: BACK BUTTON
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(width-((width/2-drView.width/2)/2)-65/2,
                         (sibDietView.y-sibDietView.height/2)/2 - 25,
                         65,
                         52)
        backButton.image01(BACK_IMG)
        backButton.opacity(0)
        backButton.text(values.backButtonTitle)
        backButton.font(values.backButtonFont)
        backButton.onTap(self, #selector(closeFirstView))
        backButton.initView()
        addSubview(backButton)
    }
    
    @objc func close(){
        delegateFirstView?.closeFirstView()
    }
    
    @objc func closeFirstView(){
        if enableBack && isClose && !inLoading{
            isClose = false
            closeView()
            var _ = Timer.schedule(1) { _ in self.close() }
        }
    }
    
    //MARK: SWITCH LANGUAGE
    var switchLangs = SwitchLangs()
    func setLangView(){
        switchLangs.frame(10,
                          (sibDietView.y-sibDietView.height/2)/2-switchLangs.backgroundWidth/2,
                          width/2-drView.width/2-20,
                          switchLangs.backgroundWidth)
        switchLangs.initView()
        switchLangs.delegate(self)
        switchLangs.opacity(0)
        switchLangs.shadow(.zero, gray07, 0.7, 0.9)
        addSubview(switchLangs)
    }
    
    func changeLang() {
        loginView.closeView()
        hideBottom(0.1)
        backButton.animate(opacity: 0, 1, curve)
        switchLangs.animate(opacity: 0, 1, curve)
        var _:Timer = Timer.schedule(1.2) { _ in
            self.setNewLang()
        }
    }
    
    func setNewLang(){
        setBottomView()
        loginView = LoginView()
        setLoginView()
        setBackButton()
        showBottom(1)
        switchLangs.animate(opacity: 1, 1, curveEaseOut05)
        backButton.animate(opacity: hasUser ? 1 : 0, 1, curveEaseOut05)
    }
    
    func openSwitchLangs() {
        switchLangs.animate(height: switchLangs.openHeight, 0.4, curve)
    }
    
    func closeSwitchLangs() {
        switchLangs.animate(height: switchLangs.backgroundWidth, 0.4, curve)
    }
    
    func connectionError(){
        delegateFirstView?.connectionError()
    }
    
    //MARK: SIBDIET
    var sibDietView = SibDietView()
    func setSibDietView(){
        sibDietView.frame(0, drView.height/2 + drView.y+3, width, 35)
        sibDietView.initView()
        addSubview(sibDietView)
    }
    
    //MARK: LOGIN VIEW
    var loginView = LoginView()
    func setLoginView(){
        let y: CGFloat = sibDietView.y + sibDietView.height/2
        loginView.frame(0, y, width, height-y-bottomView.height)
        loginView.remainingHeight(loginView.height - (keyboardHeight+5 - bottomView.height))
        loginView.initView()
        loginView.delegate(self)
        addSubview(loginView)
    }
    
    let keyboardHeight: CGFloat = is6 ? 216 : is5 ? 213 : isPlus ? 226 : isMax || is12Max || is14Max ? 301 : isX || is12 || is14 ? 291 : 350

    func endEditing(){
        if !hide{ showBottom(0.33) }
    }
    
    func onFocus(){
        if !hide{ hideBottom() }
    }
    
    func resetLoading() {
        delegateFirstView?.resetLoading()
    }
    
    //MARK: BOTTOM VIEW
    let bottomView = UIView()
    func setBottomView(){
        bottomView.frame(0, height - (hasSafeArea ? 120 : 110),  width, 115)
        by = bottomView.y
        setAbout()
        setCopyright()
        addSubview(bottomView)
    }
    
    //MARK: ABOUT
    let about = UILabel()
    func setAbout(){
        about.frame(width/2 - 50, bottomView.height - 60, 100, 30)
        about.text(values.aboutTitle)
        about.textColor(green01)
        about.backgroundColor(gray02)
        about.font(isEN ? Sahel : Sahel_Bold, 16)
        about.textAlignment(.center)
        about.cornerRadius(5)
        about.clipsToBounds(true)
        about.onTap(self, #selector(tapAbout))
        setAboutMask()
        about.mask(aboutMask)
        bottomView.addSubview(about)
    }
    
    let aboutMask = UIView()
    var aboutMaskX: CGFloat!
    func setAboutMask(){
        aboutMask.frame(about.bounds)
        aboutMask.backgroundColor(red02)
        aboutMaskX = aboutMask.x
        aboutMask.cornerRadius(5)
    }
    
    //MARK: COPYRIGHT
    var copyright = UILabel()
    func setCopyright(){
        copyright.frame(10, bottomView.height-120, width-20, 55)
        copyright.attributedText(values.copyRightTitle)
        copyright.textAlignment(.center)
        copyright.shadow(.zero, gray06, 1, 0.5)
        copyright.adjustsFontSizeToFitWidth(true)
        bottomView.addSubview(copyright)
    }
    
    //MARK: SHOW BOTTOM
    let duration: CFTimeInterval = 0.7
    var by = CGFloat()
    func showBottom(_ delay: CFTimeInterval = 0){
        loginView.backRegister()
        let curve = curveEaseOut05
        bottomView.y(by+bottomView.height)
        bottomView.animate(y: by,  duration, curve, delay)
    }
    
    //MARK: HIDE BOTTOM
    func hideBottom(_ delay: CFTimeInterval = 0){
        bottomView.animate(y: by+bottomView.height, duration, curve, delay)
    }
    
    //MARK: ON LOAD
    func loadProfile(){
        if enable{
            loginView.endEditing()
            showBottom()
            loginView.mobileGeter.closeKeyboard()
            loginView.fileNumberGeter.closeKeyboard()
        }
    }
    
    var isClose = true
    @objc func tapRegister(){
        if isClose && !inLoading{
            isClose = false
            closeView()
            var _ = Timer.schedule(0.6) { _ in self.onRegister() }
        }
    }
    @objc func onRegister(){
        delegateFirstView?.onRegister()
    }
    
    @objc func tapAbout(){
        if isClose && !inLoading{
            isClose = false
            closeView()
            var _ = Timer.schedule(0.6) { _ in self.onAbout() }
        }
    }
    @objc func onAbout(){
        delegateFirstView?.onAbout()
    }
    
    //MARK: START VIEW
    func startView(){
        enable = true
        showBottom(1)
        drView.transformY(-250)
        drView.animate(transform: .identity, 0.8, curve, 0.1)
        switchLangs.animate(opacity: 1, 1, curveEaseOut05, 1.5)
        backButton.animate(opacity:(hasUser ? 1 : 0), 1.4, curveEaseOut05, 1.5)
        var _ = Timer.schedule(3) { _ in self.enableBack = true }
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        if enable{
            enable = false
            hide = true
            backButton.animate(opacity: 0, 1, curveEaseOut05, 0.4)
            switchLangs.animate(opacity: 0, 1, curveEaseOut05, 0.4)
            coverView.opacity(0)
            sibDietView.closeView()
            loginView.closeView()
            hideBottom()
            drView.animate(transformY: -250, 1.2, curve, 0.1)
            var _ = Timer.schedule(1.5) { _ in self.remove() }
        }
    }
}
