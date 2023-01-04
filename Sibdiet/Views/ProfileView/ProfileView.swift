//
//  ProfileView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/12/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
protocol ProfileViewDelegate{
    func setDietScene()
    func setIncomingScene()
    func setFormsScene(_ fromView: String)
    func background(_ color: UIColor)
    func setDietTableView()
    func setFamilyView()
}

class ProfileView: UIView, ProfileViewDelegate, ProfileFormDelegate, LunchDietDelegate{
    
    var fromView = String()
    func fromView(_ from: String){
        self.fromView = from
    }
    
    var delegateProfileView: ProfileViewDelegate?
    
    var isClose = true
    func isClose(_ bool: Bool){
        self.isClose = bool
    }
    
    var inQuestion = false
    func inQuestion(_ bool: Bool){
        self.inQuestion = bool
    }
    
    let values = ProfileViewValues()
    let duration: CFTimeInterval = 0.5
    
    //MARK: INIT VIEW
    func initView(_ fromView: String, _ delegate: ProfileViewDelegate){
        delegateProfileView = delegate
        dietConnection.delegateLunchDiet = self
        dietConnection.closeLoading()
        self.fromView = fromView
        background(gray01)
        setTopBar()
        setBottomBar()
        setMiddleView()
        if fromView == DIET_VIEW{ stopQuestion() }
        startView()
        observerKeyboard()
    }
    func background(_ color: UIColor){
        delegateProfileView?.background(color)
    }
    
    //MARK: OBSERVER KEYBOARD
    func observerKeyboard(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboard(notification:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    //MARK: TOP BAR
    let topBar = UIView()
    func setTopBar(){
        topBar.frame(topFrame)
        topBar.shadow(CGSize(0, 1), gray09, 1, 0.7)
        topBar.backgroundColor(barBackgroundColor)
        setName()
        setFileNumberText()
        setBackButton()
        setSupportButton()
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
        name.adjustsFontSizeToFitWidth(true)
        name.textColor(profileColor)
        name.textAlignment(.center)
        topBar.addSubview(name)
    }
    
    //MARK: SUBTITLE
    var fileNumberText = SubTitle()
    func setFileNumberText(){
        let fileNumber = values.subTitle
        let font = values.subTitleFont
        let width = fileNumber.width(height: 20, font: font) + 10
        fileNumberText.frame(topBar.width/2 - width/2,
                             topBar.height - 22,
                             width,
                             20)
        fileNumberText.string(fileNumber)
        fileNumberText.font(font)
        fileNumberText.backColor(profileColor)
        fileNumberText.initView()
        topBar.addSubview(fileNumberText)
    }
    
    //MARK: SUPPORT
    var supportButton = BarButton()
    func setSupportButton(){
        let supportURL = URL("tg://resolve?domain=maminyoo")!
        let image = UIApplication.shared.canOpenURL(supportURL) ?
            SUPPORT_IMG : CALL_IMG
        supportButton.frame(isRTL ? 3 : width - 63,
                            topBar.height - (hasSafeArea ? 58 :  54),
                            60,
                            52)
        supportButton.image01(image)
        supportButton.text(values.supportButtonTitle)
        supportButton.onTap(self, #selector(onSupport))
        supportButton.initView()
        topBar.addSubview(supportButton)
    }
    
    @objc func onSupport(){
        let supportURL = URL("tg://resolve?domain=SibDietSupport")!
        let supportPhone = inOtherBlud ? URL("tel://+442070783956")! : URL("tel://02144254747")!
        if UIApplication.shared.canOpenURL(supportURL) {
            UIApplication.shared.open(supportURL)
        } else {
            UIApplication.shared.open(supportPhone)
        }
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
        backButton.onTap(self, #selector(backView))
        backButton.initView()
        topBar.addSubview(backButton)
    }
    
    @objc func backView(){
        if isClose{
            isClose(false)
            closeView()
            switch fromView {
            case DIET_VIEW: var _ = Timer.schedule(0.8) { _ in self.setDietScene() }
            case LOGIN_VIEW: var _ = Timer.schedule(1.0) { _ in
                    if hasFamily{ self.setFamilyView() }
                    else{ self.setIncomingScene() }
                }
            default:  break
            }
        }
    }
    
    func setFamilyView() {
        delegateProfileView?.setFamilyView()
    }
    
    @objc func setDietScene() {
        delegateProfileView?.setDietScene()
    }
    
    @objc func setIncomingScene() {
        delegateProfileView?.setIncomingScene()
    }
    
    @objc func setFormsScene(_ fromView: String) {
        delegateProfileView?.setFormsScene(fromView)
    }
    
    //MARK: BOTTOM BAR
    var bottomBar = UIView()
    func setBottomBar(){
        bottomBar.frame(btmFrame)
        bottomBar.shadow(CGSize(0, -1), gray09, 1, 0.7)
        bottomBar.backgroundColor(barBackgroundColor)
        switch fromView {
        case DIET_VIEW:
            setLogoutButton()
            setDoYouWantToLogout()
            setYes()
            setNo()
            setVersion()
        case LOGIN_VIEW:
            if !isWaiting{
                setGradient()
                bottomBar.onTap(self, #selector(tapBottomFrame))
            }else{
                bottomTitle.textColor(lime02)
            }
            setBottomTitle()
        default: break
        }
        addSubview(bottomBar)
    }
    
    //MARK: VERSION
    var version = UILabel()
    func setVersion(){
        version.frame(3, 3, 85, 20)
        version.attributedText(values.versionTitle)
        version.backgroundColor(gray01)
        version.cornerRadius(5)
        version.clipsToBounds(true)
        version.textAlignment(.center)
        bottomBar.addSubview(version)
    }
    
    //MARK: GRADIENT
    var gradient = CAGradientLayer()
    func setGradient(){
        gradient.frame(bottomBar.bounds)
        gradient.colors([skyBlue02, skyBlue01])
        gradient.startPoint(0, 1)
        gradient.endPoint(0, 0)
        bottomBar.addSublayer(gradient)
    }
    
    @objc func tapBottomFrame(){
        if isClose{
            isClose(false)
            gradient.animate(colors: [skyBlue01, skyBlue02], 0.4, easeOut)
            gradient.animate(colors: [skyBlue02, skyBlue01], 0.4, easeIn02, 0.4)
            var _ = Timer.schedule(0.5) { _ in self.close() }
        }
    }
    
    var canClose = true
    @objc func close(){
        if canClose{
            canClose = false
            closeView()
            setFormsScene(fromView)
        }
    }
    
    //MARK: BOTTOM TITLE
    var bottomTitle = UILabel()
    func setBottomTitle(){
        bottomTitle.frame(0, 0, self.width, 55)
        bottomTitle.text(values.bottomTitle)
        bottomTitle.shadow(CGSize(0, 1), gray09, 1, 0.7)
        bottomTitle.font(UIFont(Shabnam, 18)!)
        bottomTitle.numberOfLines(2)
        bottomTitle.textAlignment(.center)
        bottomTitle.adjustsFontSizeToFitWidth(true)
        if isWaiting{
            setCircles()
            bottomTitle.textColor(mint02)
            bottomTitle.shadowOpacity = 0
            bottomTitle.font(UIFont(Shabnam, 17)!)
        }else{
            bottomTitle.textColor(gray0)
        }
        bottomBar.addSubview(bottomTitle)
    }
    
    //MARK: CIRCLES
    var circles = Circles()
    func setCircles(){
        circles.frame(10, 13, 25, 25)
        circles.colors([mint02, mint01, mint02, mint01])
        circles.duration(2)
        circles.opacity(0.7)
        circles.initView()
        bottomBar.addSubview(circles)
    }
    
    //MARK: LOGOUT DESCRIPTION
    var doYouWantToLogOut = UILabel()
    func setDoYouWantToLogout(){
        doYouWantToLogOut.frame(10,
                                10,
                                width-20,
                                22)
        doYouWantToLogOut.textColor(ironGrayColor)
        doYouWantToLogOut.textAlignment(.center)
        doYouWantToLogOut.text(values.doYouWantToLogOutTitle)
        doYouWantToLogOut.font(UIFont(Sahel, 17)!)
        bottomBar.addSubview(doYouWantToLogOut)
    }
    
    //MARK: YES
    var yes = UILabel()
    func setYes(){
        let w: CGFloat = 50
        yes.frame(isRTL ? (width/4 * 3) - 25 : (width/4) - w/2,
                  w,
                  w,
                  w/2)
        yes.textColor(gray0)
        yes.backgroundColor(red01)
        yes.cornerRadius(5)
        yes.textAlignment(.center)
        yes.clipsToBounds(true)
        yes.text(values.yesTitle)
        yes.font(Sahel_Bold, 19)
        yes.onTap(self, #selector(logoutOk))
        bottomBar.addSubview(yes)
    }
    
    //MARK: NO
    var no = UILabel()
    var noOrigin: CATransform3D!
    func setNo(){
        let w: CGFloat = 50
        no.frame(isRTL ? (width/4) - 25 : (width/4 * 3) - w/2,
                 w,
                 w,
                 w/2)
        no.textColor(gray0)
        no.backgroundColor(green01)
        no.cornerRadius(5)
        no.textAlignment(.center)
        no.clipsToBounds(true)
        no.text(values.noTitle)
        no.font(UIFont(Sahel_Bold, 19)!)
        no.onTap(self, #selector(hideQuestion), 1)
        bottomBar.addSubview(no)
    }
    
    //MARK: LOGOUT
    var logoutButton = BarButton()
    func setLogoutButton(){
        logoutButton.frame(self.width/4 - 30, hasSafeArea ? 4 : 2, 60, 52)
        logoutButton.image01(LOGOUT_IMG)
        logoutButton.text(values.logoutButtonTitle)
        logoutButton.initView()
        logoutButton.onTap(self, #selector(showQuestion))
        bottomBar.addSubview(logoutButton)
    }
    
    func stopQuestion(){
        let height = bottomBar.height
        doYouWantToLogOut.transformY(height)
        yes.transformY(height)
        no.transformY(height)
    }

    //MARK: SHOW LOGOUT QUESTION
    @objc func showQuestion(){
        var _ = Timer.schedule(0.3){ _ in self.feedback() }
        var _ = Timer.schedule(0.4){ _ in self.feedback() }
        inQuestion(true)
        logoutButton.animate(opacity: 0, 0.4, curve)
        doYouWantToLogOut.animate(transform: .identity, duration, curve)
        yes.animate(transform: .identity, duration, curve, 0.2)
        no.animate(transform: .identity, duration, curve, 0.1)
        bottomBar.animate(backgroundColor: white02, duration, curve, 0.1)
        version.animate(opacity: 0, duration, curve, 0.1)
        let bottomBarHeight = bottomBar.height
        bottomBar.animate(height: bottomBarHeight+100, duration-0.1, curve)
    }

    //MARK: HIDE LOGOUT QUESTION
    @objc func hideQuestion(){
        if inQuestion{
            feedback()
            var _ = Timer.schedule(0.1){ _ in self.feedback() }
            inQuestion(false)
            let transform = CGAffineTransform(y: bottomBar.height)
            doYouWantToLogOut.animate(transform: transform, duration, curve, 0.2)
            yes.animate(transform: transform, duration, curve,  0.1)
            no.animate(transform: transform, duration, curve)
            logoutButton.animate(opacity: 1, 0.4, curve, 0.3)
            bottomBar.animate(backgroundColor: barBackgroundColor, duration, curve)
            version.animate(opacity: 1, duration, curve, 0.2)
            let height = bottomBar.height
            bottomBar.animate(height: height-100, duration, curve, 0.1)
        }
    }
    
    @objc func feedback(){
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    @objc func logoutOk(){
        if isClose{
            isClose(false)
            users.remove(profile.fileNumber)
            profile.fileNumber = ""
            closeView()
            var _ = Timer.schedule(1.3) { _ in self.logout() }
        }
    }
    
    @objc func logout(){
        if hasUser { users.loadLastUser() }else{ setIncomingScene() }
    }
    
    //MARK: MIDDLE VIEW
    var middleView = UIView()
    func setMiddleView(){
        middleView.frame(midFrame)
        setProfileForm()
        addSubview(middleView, 0)
    }
    
    //MARK: PROFILE FORM
    var profileForm = ProfileForm()
    func setProfileForm(){
        let editorsHeight: CGFloat = 55
        profileForm.frame(0,
                          10,
                          width,
                          editorsHeight*10)
        profileForm.delegate(self)
        profileForm.editorsHeight(editorsHeight)
        profileForm.initView()
        profileForm.onPan(self, #selector(pan(pan:)))
        middleView.addSubview(profileForm)
    }
    
    var isScrollableForm: Bool{ profileForm.formHeight>middleView.height }
    
    //MARK: PAN
    var formY: CGFloat!
    @objc func pan(pan: UIPanGestureRecognizer){
        profileForm.closeKeyboard()
        let formHeight = profileForm.formHeight
        let topForm = formHeight/2+10
        let bottomForm = -formHeight/2+middleView.height-8
        let translation = pan.translation(in: self)
        
        switch pan.state {
        case .began:
            formY = profileForm.y
            hideQuestion()
            profileForm.saveToEghtedar()
        case .changed:
            profileForm.y(isScrollableForm && formY<topForm && formY>bottomForm ?
                    formY + translation.y :
                    formY + translation.y/5)
        case .ended:
            let velocity = pan.velocity(in: self)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 300
            let slideFactor = 0.1 * slideMultiplier
            let y = profileForm.y + (velocity.y * slideFactor)
            let time = CFTimeInterval(slideFactor * 2)
            if isScrollableForm{
                if y > topForm { profileForm.animate(y: topForm, 0.5, 0.8) }
                else if y < bottomForm{ profileForm.animate(y: bottomForm, 0.5, 0.8) }
                else{ profileForm.animate(y: y, time,  curveEaseOut03) }
            }else{ profileForm.animate(y: middleView.height/2, 0.5, 0.8) }
        default: break
        }
    }
    
    //MARK: SELECTED FORM
    var cell = String()
    func profileFormSelected(cell: String) {
        self.cell = cell
        profileForm.animate(height: profileForm.formHeight, duration, curve)
        let v = ProfileFormValues()
        switch cell {
        case v.mobileTitle, v.emailTitle:
            profileForm.animate(y: profileForm.formHeight/2+10+profileForm.editorsHeight, duration, curve)
        case "day", "year":
            profileForm.animate(y: profileForm.formHeight/2+10, duration, curve)
        case "month":
            profileForm.animate(y: !isScrollableForm ? middleView.height/2 : profileForm.formHeight/2+10, duration, curve)
        case v.cityTitle, v.homePhoneTitle, v.addressTitle:
            let formHeight = profileForm.formHeight
            let bottomForm = -formHeight/2+middleView.height-5
            let y = bottomForm-keyHeight+bottomBar.height
            profileForm.animate(y: y, duration, curve)
        default:
            profileForm.animate(y: middleView.height/2, duration, curve)
        }
    }
    
    var keyHeight = CGFloat()
    @objc func keyboard(notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height
        if keyHeight != height{
            keyHeight = height
            profileFormSelected(cell: cell)
        }
    }
    
    //MARK: DESELECTED FORM
    func profileFormDeSelected() {
        profileForm.animate(y: middleView.height/2, duration, curve)
        profileForm.animate(height: profileForm.formHeight, duration, curve)
    }
    
    func lunchNewDiet() {
        closeView()
        setDietTableView()
    }
    
    func setDietTableView(){
        delegateProfileView?.setDietTableView()
    }
    
    //MARK: START VIEW
    var enable = false
    func startView(){
        if !enable{
            enable = true
            logoutButton.animate(x: bottomBar.width/2, duration, curve)
            topBar.transformY(-topBar.height)
            profileForm.animate(y: middleView.height/2, duration, curve)
            topBar.animate(transform: .identity, 0.7, curve, 0.5)
            bottomBar.transformY(bottomBar.height)
            bottomBar.animate(transform: .identity, 0.7, curve, 0.5)
        }
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        if enable{
            let delay: CFTimeInterval = fromView == LOGIN_VIEW ? 0.2 : 0.8
            enable = false
            profileForm.closeView()
            topBar.animate(transformY:  -topBar.height, 0.7, curve, delay)
            bottomBar.animate(transformY:  bottomBar.height, 0.7, curve, delay)
            var _ = Timer.schedule(1.5) { _ in self.remove() }
        }
    }
}
