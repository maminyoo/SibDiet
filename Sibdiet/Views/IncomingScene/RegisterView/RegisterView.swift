//
//  RegisterView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/28/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol RegisterViewDelegate {
    func setFirstView()
    func connectionError()
}

class RegisterView: UIView, RegisterViewDelegate, RegisterFormDelegate, TextEditorDelegate, RegisterDelegate{
    
    var delegateRegisterView: RegisterViewDelegate?
    func delegate(_ delegate: RegisterViewDelegate){
        self.delegateRegisterView = delegate
    }
    
    //MARK: EDITOR HEIGHT
    var editorsHeight: CGFloat{
        let height: CGFloat = self.height - topBar.height
        return isiPad ? height/12 :
            hasSafeArea || isPlus ? height/10 :
            is5 ? height/8 : height/9
    }
    
    let values = RegisterViewValues()
    let duration:CFTimeInterval = 0.5
    
    //MARK: INIT VIEW
    func initView(){
        registerConnection.delegate(self)
        setTopBar()
        setBottomBar()
        setMiddleView()
        startView()
        setFileNumberEditor()
        showHideNewForm()
        observerKeyboard()
    }
    
    //MARK: OBSERVER KEYBOARD
    func observerKeyboard(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboard(notification:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    //MARK: TOPBAR
    let topBar = UIView()
    func setTopBar(){
        topBar.frame(topFrame)
        topBar.shadow(CGSize(0, 1), gray09, 1, 0.7)
        topBar.backgroundColor(barBackgroundColor)
        setBackButton()
        setName()
        setSubTitle()
        setClearButton()
        addSubview(topBar, 2)
    }
    
    //MARK: NAME
    let name = UILabel()
    func setName(){
        let font = UIFont(JosefinSans, (hasSafeArea ? 32 : 30))!
        let width = values.nameTitle.width(height: 32, font: font)
        name.frame(topBar.width/2 - width/2,
                   topBar.height - (hasSafeArea ? 57 : 52),
                   width,
                   35)
        name.text(values.nameTitle)
        name.font(font)
        name.textColor(green01)
        name.shadow(CGSize(0, 1), gray06, 0.7, 0.6)
        name.textAlignment(.center)
        topBar.addSubview(name)
    }
    
    //MARK: SUBTITLE
    let subTitle = SubTitle()
    func setSubTitle(){
        let string = values.subTitle
        let font = values.subTitleFont
        let width = string.width(height: 20, font: font) + 10
        subTitle.frame(topBar.width/2 - width/2,
                       topBar.height - 22,
                       width,
                       20)
        subTitle.string(string)
        subTitle.font(values.subTitleFont)
        subTitle.backColor(green01)
        subTitle.initView()
        topBar.addSubview(subTitle)
    }
    
    //MARK: BACK BUTTON
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(isRTL ? topBar.width - 63 : 3,
                         topBar.height - (hasSafeArea ? 58 :  54),
                         60,
                         52)
        backButton.image01(BACK_IMG)
        backButton.text(values.backButtonTitle)
        backButton.onTap(self, #selector(setFirstView))
        backButton.initView()
        topBar.addSubview(backButton)
    }
    
    @objc func setFirstView(){
        closeView()
        let delay =
            registerForm.bloodEditor.enable ? 0.8 :
                registerForm.maritalEditor.enable ? 0.7 :
                registerForm.genderEditor.enable ? 0.7 :
                registerForm.birthdayEditor.enable ? 0.6 :
                registerForm.mobileEditor.enable ? 0.5 :
                registerForm.lnameEditor.enable ? 0.4 : 0.4
        var _ = Timer.schedule(delay) { _ in
            self.delegateRegisterView?.setFirstView()
        }
    }
    
    //MARK: NEW BUTTON
    var newRegisterButton = BarButton()
    func setClearButton(){
        newRegisterButton.frame(isRTL ? 3 : topBar.width - 63,
                                topBar.height - (hasSafeArea ? 58 :  54),
                                60,
                                52)
        newRegisterButton.image01(CLEAN_IMG)
        newRegisterButton.text(values.newButtonTitle)
        newRegisterButton.onTap(self, #selector(newRegisterView), 1)
        newRegisterButton.initView()
        topBar.addSubview(newRegisterButton)
    }
    
    @objc func newRegisterView() {
        registerForm.closeView()
        newRegisterButton.opacity(0)
        var _ = Timer.schedule(0.9) { _ in
            self.newRegisterForm()
        }
    }
    
    @objc func newRegisterForm(){
        register.reset()
        registerForm = RegisterForm()
        setRegisterForm()
    }
    
    //MARK: BOTTOM BAR
    var bottomBar = UIView()
    func setBottomBar(){
        bottomBar.frame(btmFrame)
        bottomBar.shadow(CGSize(0, -1), gray09, 1, 0.7)
        bottomBar.backgroundColor(barBackgroundColor)
        bottomBar.onTap(self, #selector(registerUser), 1)
        setRegisterTitle()
        setCircles()
        addSubview(bottomBar, 2)
    }
    
    var registerTitle = UILabel()
    func setRegisterTitle(){
        registerTitle.frame(0, 0, width, 55)
        registerTitle.text(values.subTitle)
        registerTitle.font(UIFont(Shabnam, 19)!)
        registerTitle.textColor(gray02)
        registerTitle.textAlignment(.center)
        bottomBar.addSubview(registerTitle)
    }
    
    @objc func registerUser(){
        if registerForm.enableRegister{
            if isConnected{
                registerConnection.registerUser()
                registerTitle.animate(opacity: 0, 1, curveEaseInOut)
                circles.animate(opacity: 1, 1, curveEaseInOut)
            }else{
                connectionError()
            }
        }
    }
    
    //MARK: CIRCLES
    let circles = Circles()
    func setCircles(){
        let width: CGFloat = 120
        let container = UIView()
        container.frame(bottomBar.bounds)
        container.clipsToBounds(true)
        circles.frame(self.width/2 - width/2, -30, width, width)
        circles.colors([green02, gray01, green02, gray01])
        circles.duration(1)
        circles.opacity(0)
        circles.initView()
        container.addSubview(circles)
        bottomBar.addSubview(container)
    }
    
    func registerBack(){
        registerTitle.animate(opacity: 1, 1, curveEaseInOut)
        circles.animate(opacity: 0, 1, curveEaseInOut)
    }
    
    //MARK: MIDDLE VIEW
    var middleView = UIView()
    func setMiddleView(){
        middleView.frame(midFrame)
        setRegisterForm()
        addSubview(middleView, 0)
    }
    
    //MARK: REGISTER FORM
    var registerForm = RegisterForm()
    func setRegisterForm(){
        registerForm.frame(0,
                           middleView.height/2 - editorsHeight/2 ,
                           width,
                           editorsHeight)
        registerForm.editorsHeight(editorsHeight)
        registerForm.delegate(self)
        registerForm.onPan(self, #selector(panRegisterForm(pan:)))
        registerForm.initView()
        registerForm.height(registerForm.formHeight)
        middleView.addSubview(registerForm)
    }
    
    //MARK: PAN FORM
    var formY = CGFloat()
    @objc func panRegisterForm(pan: UIPanGestureRecognizer){
        registerForm.closeKeyboard()
        let formHeight = registerForm.formHeight
        let topForm = formHeight/2+5
        let bottomForm = -formHeight/2+middleView.height-5
        let translation = pan.translation(in: self)
        
        switch pan.state {
        case .began:
            formY = registerForm.y
        case .changed:
            registerForm.y(isScrollableForm &&
                formY<topForm &&
                formY>bottomForm ?
                    formY + translation.y :
                formY + translation.y/5)
        case .ended:
            let velocity = pan.velocity(in: self)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 300
            let slideFactor = 0.1 * slideMultiplier
            let y = registerForm.y + (velocity.y * slideFactor)
            let time = CFTimeInterval(slideFactor * 2)
            if isScrollableForm{
                if y > topForm { registerForm.animate(y: topForm, 0.5, 0.8) }
                else if y < bottomForm{ registerForm.animate(y: bottomForm, 0.5, 0.8) }
                else{ registerForm.animate(y: y, time,  curveEaseOut03) }
            }else{ registerForm.animate(y: middleView.height/2, 0.5, 0.8) }
        default: break
        }
    }
    
    var isScrollableForm: Bool{
        return registerForm.formHeight>middleView.height ? true : false
    }
    
    //MARK: FILENUMBER
    var fileNumberEditor = TextEditor()
    func setFileNumberEditor(){
        fileNumberEditor.frame(10, -50, width - 20, editorsHeight)
        fileNumberEditor.title(values.fileNumberTitle)
        fileNumberEditor.keyboardType(.numberPad)
        fileNumberEditor.enableCharacters(NUMBER_CHARS)
        fileNumberEditor.shadow(.zero, gray08, 0.6, 0.7)
        fileNumberEditor.delegate(self)
        fileNumberEditor.initView()
        addSubview(fileNumberEditor)
    }
    func textEditorSelected(cell: String) {
    }
    func onReturn() {
    }
    func endEditing() {
    }
    
    func sendFileNumebr() {
        setSendSMS()
    }
    
    //MARK: SMS
    var sendSMS = UILabel()
    func setSendSMS(){
        sendSMS.frame(width/2 - 150,
                      topBar.y + topBar.height - 15,
                      300,
                      80)
        sendSMS.attributedText(values.sendSmsText)
        sendSMS.backgroundColor(gray02)
        sendSMS.cornerRadius(10)
        sendSMS.clipsToBounds(true)
        sendSMS.border(gray03, 2)
        sendSMS.textAlignment(.center)
        sendSMS.lineBreakMode(.byCharWrapping)
        sendSMS.numberOfLines(3)
        sendSMS.transformY(-sendSMS.height*3)
        sendSMS.animate(transform: .identity, 1, curve, 1)
        addSubview(sendSMS, below: topBar)
    }
    
    //MARK: DUPLICATE MOBILE
    func duplicateMobile() {
        forgetConnection.forget(mobile: register.mobileResult.enNumber)
        registerForm.closeView()
        bottomBar.animate(transformY: bottomBar.height, 0.7, curve)
        fileNumberEditor.startView(delay: 1.0)
        fileNumberEditor.animate(y: self.height/2, 0.7, curveEaseOut05, 1.0)
        var _ = Timer.schedule(1.0) { _ in
            self.focusFileNumber()
        }
    }
    
    func connectionError(){
        delegateRegisterView?.connectionError()
    }
    
    //MARK: FOCOS
    @objc func focusFileNumber(){
        fileNumberEditor.focusKeyboard()
        newRegisterButton.animate(opacity: 0, 0.5, curveEaseOut05)
        backButton.animate(opacity: 0, 0.5, curve)
    }
    
    func onFocus() {
        let fileNumber = fileNumberEditor.text
        let originFileNumber = register.fileNumber
        let newFileNumber = fileNumber.substring(to: 6)
        let transform = CGAffineTransform(y: -sendSMS.height*3)
        fileNumberEditor.text = isRTL ? newFileNumber.faNumber : newFileNumber.enNumber
        let count = newFileNumber.count
        
        if !register.isDuplicateMobile{
            if fileNumber.faNumber == originFileNumber.faNumber{
                registerComplated()
                sendSMS.animate(transform: transform, 1, curve)
            }
        }else{
            if count > 5 && register.oldFileNumber == ""{
                registerConnection.getOldFileNumber(fileNumber: newFileNumber.enNumber)
                sendSMS.animate(transform: transform, 1, curve)
            }
        }
    }
    
    func registerComplated() {
        fileNumberEditor.closeKeyboard()
        loginDuplicate()
    }
    
    func canRegisterNew(){
        fileNumberEditor.closeKeyboard()
        fileNumberEditor.closeView()
        registerConnection.registerUser()
    }
    
    func loginDuplicate() {
        dietConnection.getData(register.mobileResult.enNumber, register.fileNumber)
        closeView()
    }
    
    func loginAgain() {
        dietConnection.getData(register.mobileResult, register.oldFileNumber)
        closeView()
    }
    
    func registered() {
        loginDuplicate()
    }
    
    func inCorrectMobile() {
        registerForm.inCorrectMobile()
        registerBack()
    }
    
    //MARK: FORM SELECTED
    var cell = String()
    func registerFormSelected(cell: String) {
        self.cell = cell
        let height: CGFloat = registerForm.formHeight
        registerForm.animate(height: height, duration, curve)
        let keyHeight =  keyHeightG - bottomBar.height
        let keyY = middleView.height - keyHeight - editorsHeight/2-10
        
        switch cell {
        case  RegisterFormValues().fnameTitle:
            let y = registerForm.genderEditor.enable ?
                keyY - editorsHeight :
                registerForm.birthdayEditor.enable ?
                    keyY - editorsHeight*1.5 :
                registerForm.mobileEditor.enable ?
                    keyY - editorsHeight :
                registerForm.lnameEditor.enable ?
                    keyY - editorsHeight/2 :  keyY
            registerForm.animate(y: y , duration, curve)
            
        case RegisterFormValues().lnameTitle:
            let y = registerForm.genderEditor.enable ?
                keyY - editorsHeight :
                registerForm.birthdayEditor.enable ?
                    keyY - editorsHeight*1.5 :
                registerForm.mobileEditor.enable ?
                    keyY - editorsHeight :
                keyY - editorsHeight/2
            registerForm.animate(y: y , duration, curve)
            
        case RegisterFormValues().mobileTitle:
            let y = registerForm.genderEditor.enable ?
                keyY - editorsHeight*2 :
                registerForm.birthdayEditor.enable ?
                    keyY - editorsHeight*1.5 :
                keyY - editorsHeight
            registerForm.animate(y: y , duration, curve)
            
        case RegisterFormValues().yearTitle:
            let y = registerForm.genderEditor.enable ?
                keyY - editorsHeight*2 :
                keyY - editorsHeight*1.5
            registerForm.animate(y: y , duration, curve)
            
        case RegisterFormValues().dayTitle:
            let y = is5 && !registerForm.genderEditor.enable ?
                -height/2+middleView.height-5 :
                middleView.height/2
            registerForm.animate(y: y, duration, curve)
            
        case RegisterFormValues().bloodTitle:
            let y = isScrollableForm ?
                -height/2+middleView.height-5 :
                middleView.height/2
            registerForm.animate(y: y, duration, curve)
            
        default:
            registerForm.animate(y: middleView.height/2, duration, curve)
        }
        showHideNewForm()
    }
    
    var keyHeightG = CGFloat()
    @objc func keyboard(notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height
        if keyHeightG != height{
            keyHeightG = height
            registerFormSelected(cell: cell)
        }
    }
    
    //MARK: DESELECT FORM
    func registerFormDeselected() {
        let height: CGFloat = registerForm.formHeight
        registerForm.animate(height: height, duration, curve)
        registerForm.animate(y: middleView.height/2, duration, curve)
        showHideNewForm()
    }
    
    //MARK: SHOW HIDE NEW
    func showHideNewForm(){
        if registerForm.formHeight < registerForm.editorsHeight*4{
            newRegisterButton.animate(opacity: 0, 0.5, curve)
        }else{ newRegisterButton.animate(opacity: 1, 0.5, curve) }
        if registerForm.enableRegister{
            bottomBar.animate(backgroundColor: green01, 1, curve)
            registerTitle.textColor(gray0)
        }else{
            bottomBar.animate(backgroundColor: barBackgroundColor, 1, curve)
            registerTitle.textColor(gray02)
            registerBack()
        }
    }
    
    //MARK: START VIEW
    func startView(){
        topBar.transformY(-topBar.height)
        topBar.animate(transform: .identity, 0.7, curve)
        bottomBar.transformY(bottomBar.height)
        bottomBar.animate(transform: .identity, 0.7, curve)
        middleView.transformY(middleView.height)
        middleView.animate(transform: .identity, 0.7, curve)
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        topBar.animate(transformY: -topBar.height, 0.7, curve, 0.2)
        bottomBar.animate(transformY: bottomBar.height, 0.7, curve, 0.2)
        registerFormDeselected()
        registerForm.closeView()
        fileNumberEditor.closeView()
        var _ = Timer.schedule(1.1) { _ in self.remove() }
    }
}
