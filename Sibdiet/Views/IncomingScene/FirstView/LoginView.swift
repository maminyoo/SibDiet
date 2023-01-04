//
//  LoginView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/14/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol LoginViewDelegate {
    func resetLoading()
    func onFocus()
    func endEditing()
    func tapRegister()
}

class LoginView: UIView, TextEditorDelegate, ForgetDelegate, LoginViewDelegate{
    
    let values = LoginViewValues()
    
    var delegateLoginView: LoginViewDelegate?
    func delegate(_ delegate: LoginViewDelegate){
        self.delegateLoginView = delegate
    }
    
    var remainingHeight = CGFloat()
    func remainingHeight(_ height: CGFloat){
        self.remainingHeight = height
    }
    
    var enableLogin = false
    var canShowFileNumber = true
    var editorsHeight = CGFloat()
    
    //MARK: INIT VIEW
    func initView(){
        forgetConnection.delegateForget = self
        editorsHeight = height/5
        if isX || is12 || is14 { editorsHeight = height/7 }
        else if isPlus{ editorsHeight = height/6 }
        else if is5{ editorsHeight = height/4.5 }
        else if isiPad{ editorsHeight = height/9 }
        else if isMax || is12Max || is14Max { editorsHeight = height/8 }
        setMobileGeter()
        setFileNumberGeter()
        setRegister()
        setForget()
        startView()
    }
    
    //MARK: MOBILE
    var mobileGeter = TextEditor()
    func setMobileGeter(){
        mobileGeter.frame(10, height/2, width-20, editorsHeight)
        mobileGeter.title(values.mobileGeterTitle)
        mobileGeter.placeholder(values.mobileGeterHolder)
        mobileGeter.font(Sahel, 18)
        mobileGeter.keyboardType(.numberPad)
        mobileGeter.shadow(.zero, gray08, 0.6, 0.7)
        mobileGeter.corner(15)
        mobileGeter.delegate(self)
        mobileGeter.enableCharacters(NUMBER_CHARS)
        mobileGeter.initView()
        mobileGeter.setStopView()
        addSubview(mobileGeter)
    }
    
    //MARK: FILENUMBER
    var fileNumberGeter = TextEditor()
    func setFileNumberGeter(){
        fileNumberGeter.frame(10, height + 30, width-20, editorsHeight)
        fileNumberGeter.title(values.fileNumberTitle)
        fileNumberGeter.placeholder(values.fileNumberHolder)
        fileNumberGeter.font(Sahel, 18)
        fileNumberGeter.keyboardType(.numberPad)
        fileNumberGeter.shadow(.zero, gray08, 0.6, 0.7)
        fileNumberGeter.corner(15)
        fileNumberGeter.delegate(self)
        fileNumberGeter.enableCharacters(NUMBER_CHARS)
        fileNumberGeter.initView()
        fileNumberGeter.setStopView()
        addSubview(fileNumberGeter)
    }
    
    //MARK: FORGET
    var forget = Forget()
    func setForget(){
        forget.frame(10, height*2 + 100, 220, 20)
        forget.shadow(.zero, gray08, 0.6, 0.7)
        forget.forgetTitle = values.forgetTitle
        forget.mobileError = values.mobileError
        forget.fileNumberError = values.fileNumberError
        forget.internetError = values.internetError
        forget.sendFileNumber = values.sendFileNumber
        forget.forgetFont = values.forgetFont
        forget.initView()
        forget.onTap(self, #selector(onForget))
        addSubview(forget)
    }
    
    @objc func onForget(){
        let count = mobileGeter.text.count
        if forget.enable && count > 0{
            forget.close()
            forgetConnection.forget(mobile: mobileResult)
        }
    }
    
    func onReturn() {
    }
    func textEditorSelected(cell: String) {
        onFocus()
    }
    
    //MARK: REGISTER
    var register = UILabel()
    func setRegister(){
        register.frame(width/2 - 50, height-40, 100, 30)
        register.text(values.registerTitle)
        register.textColor(gray0)
        register.backgroundColor(green01)
        register.font(isEN ? Sahel : Sahel_Bold, 16)
        register.textAlignment(.center)
        register.cornerRadius(5)
        register.clipsToBounds(true)
        register.onTap(self, #selector(tapRegister))
        addSubview(register)
    }
    
    @objc func tapRegister(){
        delegateLoginView?.tapRegister()
    }
    
    //MARK: START VIEW
    func startView(){
        mobileGeter.y = height/3 * 2
        let mobileY = height/2 - mobileGeter.height/2
        mobileGeter.animate(y: mobileY, 1, curve, 0.2)
        mobileGeter.startView(delay: 0.3)
        register.y(height+170)
        register.animate(y: height-20, 0.7, curve, 0.7)

        fileNumberGeter.y = height/3 * 2 + fileNumberGeter.height
        let fileNumberGeterY = height/2 + fileNumberGeter.height/2+3
        fileNumberGeter.animate(y: fileNumberGeterY, 1, curve, 0.4)
        fileNumberGeter.startView(delay: 0.5)
    }
    
    func resetLoading() {
        delegateLoginView?.resetLoading()
    }
    
    func notFountPhone() {
        forget.notFoundPhone()
        resetLoading()
    }
    
    func notFound() {
        forget.close()
        forget.notFound()
        resetLoading()
    }
    
    func connectionError() {
        forget.close()
        forget.connectionError()
        resetLoading()
    }
    
    func found() {
        forget.found()
    }
    
    //MARK: ON FOCUS
    func onFocus(){
        delegateLoginView?.onFocus()
        let mobile = mobileGeter.text.substring(to: numberPattern.count)
        applyMobileFormat(mobile)
        let fileNumber = fileNumberGeter.text
        let fileNumberCount = fileNumber.count
        let newFileNumber = fileNumber.substring(to: 6)
        fileNumberGeter.text = language == FA ? newFileNumber.faNumber : newFileNumber.enNumber
        if !fileNumberGeter.enable{
            let phoneGeter01Y = remainingHeight - mobileGeter.height/2 - register.height - 10
            mobileGeter.animate(y: phoneGeter01Y, 0.6, curve)
        }
        if mobile.count > numberPattern.count-1 {
            if canShowFileNumber{
                showFileNumber()
            }
        }
        if mobile.count<numberPattern.count && fileNumberGeter.enable{
            hideFileNumber()
            if fileNumberGeter.inputText.resignFirstResponder(){
                fileNumberGeter.inputText.becomeFirstResponder()
                let _: Timer = Timer.schedule(0.001) { _ in
                    self.mobileGeter.inputText.becomeFirstResponder()
                }
            }
        }
        if fileNumberCount > 5 { enableLogin = true }
        else if fileNumberCount != 0{
            enableLogin = false
            resetLoading()
        }
        if fileNumberCount < 6 && fileNumberGeter.enable && !enableLogin{
            topKeyboard()
        }
        if fileNumberCount > 4 && fileNumberGeter.enable && enableLogin{
            login()
        }else{
            resetLoading()
            dietConnection.cancelRequest()
        }
        let registerPoint = CGPoint(width-register.width/2-15,
                                    remainingHeight - register.height/2)
        register.animate(position: registerPoint, 0.4, curve)
    }
    
    //MARK: MOBILE RESULT
    var mobileResult: String{
        let mobile = mobileGeter.text.replace([" " : "", "-" : "", "(" : "", ")" : ""])
        let codeCount = countryCode.count
        let subscriptMobile = mobile.substring(from: 0, length: codeCount).enNumber
        let remining = "0\(mobile.substring(from: codeCount, length: mobile.count))"
        let fullMobile = "00\(mobile.substring(from: 1, length: mobile.count-1))"
        return countryCode == "+98" &&  subscriptMobile == countryCode ?
            remining.enNumber :
            subscriptMobile == countryCode ? fullMobile :
            mobile.enNumber
    }
    
    //MARK: MOBILE FORMAT
    func applyMobileFormat(_ mobile: String){
        let fixMobilFormat = mobile.applyPatternOnNumbers(pattern: numberPattern)
        if fixMobilFormat != "" {
            let text = isRTL ? fixMobilFormat.faNumber : fixMobilFormat.enNumber
            let count = countryCode.count
            let firstChar = mobile.substring(from: count, to: count+1)
            let code = isRTL ?
                countryCode.faNumber :
                countryCode.enNumber
            let mobileCode = mobile.substring(from: 0, to: count-1)

            mobileGeter.text(firstChar == "0" ||
                             firstChar == "۰" ||
                             mobile.count < countryCode.count ||
                             mobileCode != code ? "\(code) " : text)
        }else{
            let text = isRTL ?
                countryCode.faNumber :
                countryCode.enNumber
            mobileGeter.text("\(text)")
        }
    }
    
    //MARK: SHOW FILENUMBER
    let duration: CFTimeInterval = 0.6
    func showFileNumber(){
        canShowFileNumber = false
        let phoneGeter02Y = remainingHeight - (mobileGeter.height + mobileGeter.height/2) - forget.height - 5
        mobileGeter.animate(y: phoneGeter02Y, duration, curve)
        fileNumberGeter.isHidden = false
        fileNumberGeter.startView()
        let fileNumberGeter02Y = remainingHeight - fileNumberGeter.height/2 - forget.height - 5
        fileNumberGeter.animate(y: fileNumberGeter02Y, duration, curve)
        let forget01Y = remainingHeight - forget.height/2 - 10
        forget.animate(y: forget01Y, duration,  curve)
    }
    
    //MARK: HIDE FILENUMBER
    func hideFileNumber(){
        canShowFileNumber = true
        let phoneGeter01Y = remainingHeight - mobileGeter.height/2 - register.height - 5
        mobileGeter.animate(y: phoneGeter01Y, duration+0.1, curve)
        fileNumberGeter.animate(y: height+10, duration, curve)
        fileNumberGeter.closeView()
        let forget01Y = height*2 + forget.height+30
        forget.animate(y: forget01Y, duration, curve)
    }
    
    //MARK: TOP KEYBOARD
    func topKeyboard(){
        let phoneGeter02Y = remainingHeight - (mobileGeter.height + mobileGeter.height/2) - forget.height - 5 - register.height
        mobileGeter.animate(y: phoneGeter02Y, duration, curve)
        let fileNumberGeter01Y = remainingHeight - fileNumberGeter.height/2 - forget.height - 5 - register.height
        fileNumberGeter.animate(y: fileNumberGeter01Y, duration, curve)
        let forget01Y = remainingHeight - forget.height + 5 - register.height
        forget.animate(y: forget01Y, duration, curve)
    }
    
    
    //MARK: LOGIN
    var inLogin = false
    func login(){
        let phoneCount = mobileGeter.text.count
        let fileNumberCount = fileNumberGeter.text.count
        if enableLogin && phoneCount > 0 && fileNumberCount > 0 && !inLogin {
            inLogin = true
            let fileNumber = fileNumberGeter.text.enNumber
            dietConnection.getData(mobileResult, fileNumber)
        }else{
            inLogin = false
            resetLoading()
            dietConnection.cancelRequest()
        }
    }
    
    //MARK: END EDDITING
    func endEditing(){
        delegateLoginView?.endEditing()
        if !fileNumberGeter.enable{
            let phoneGeter01Y = height/2
            mobileGeter.animate(y: phoneGeter01Y, duration, curve)
        }else{
            let phoneGeter01Y = height/2 - mobileGeter.height
            mobileGeter.animate(y: phoneGeter01Y, duration, curve)
            
            let fileNumberGeter01Y = phoneGeter01Y + fileNumberGeter.height + 3
            fileNumberGeter.animate(y: fileNumberGeter01Y, duration, curve)
            
            let forget01Y = fileNumberGeter01Y + forget.height + 25
            forget.animate(y: forget01Y, duration, curve)
        }
        backRegister()
    }
    
    func backRegister(){
        register.animate(y: height-25, duration, curve)
        register.animate(x: width/2, duration, curve)
    }
    
    //MARK: TOUCHES BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let phoneGeterMinX = mobileGeter.x - mobileGeter.width/2
        let phoneGeterMaxX = mobileGeter.x + mobileGeter.width/2
        let phoneGeterMinY = mobileGeter.y - mobileGeter.height/2
        let phoneGeterMaxY = mobileGeter.y + mobileGeter.height/2
        
        let fileNumberGeterMinX = fileNumberGeter.x - fileNumberGeter.width/2
        let fileNumberGeterMaxX = fileNumberGeter.x + fileNumberGeter.width/2
        let fileNumberGeterMinY = fileNumberGeter.y - fileNumberGeter.height/2
        let fileNumberGeterMaxY = fileNumberGeter.y + fileNumberGeter.height/2
        
        if let point = touches.first?.location(in: self){
            if point.x < phoneGeterMinX || point.x > phoneGeterMaxX || point.y < phoneGeterMinY || point.y > phoneGeterMaxY{
                if mobileGeter.focus{
                    mobileGeter.inputText.resignFirstResponder()
                    endEditing()
                }
                if point.x < fileNumberGeterMinX || point.x > fileNumberGeterMaxX || point.y < fileNumberGeterMinY || point.y > fileNumberGeterMaxY{
                    if fileNumberGeter.focus{
                        fileNumberGeter.inputText.resignFirstResponder()
                        endEditing()
                    }
                }
            }
        }
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        register.animate(transformY: 170, 0.7, curve, 0.2)
        mobileGeter.closeView(delay: 0)
        fileNumberGeter.closeView(delay: 0.1)
        forget.close()
        var _ = Timer.schedule(1.1) { _ in self.remove() }
    }
}
