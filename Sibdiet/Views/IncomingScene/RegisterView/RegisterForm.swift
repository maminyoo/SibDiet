//
//  RegisterForm.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/28/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol RegisterFormDelegate {
    func registerFormSelected(cell: String)
    func registerFormDeselected()
}

class RegisterForm: UIView,
    TextEditorDelegate,
    DateEditorDelegate,
    SwitchValuesDelegate,
    RegisterFormDelegate{
    
    var delegateRegisterForm: RegisterFormDelegate?
    func delegate(_ delegate: RegisterFormDelegate){
        self.delegateRegisterForm = delegate
    }
    
    var enableRegister: Bool{ bloodEditor.enable && bloodEditor.selected }
    
    var editorsHeight = CGFloat()
    func editorsHeight(_ height: CGFloat){
        self.editorsHeight = height
    }
    
    let fname = register.fname
    let lname = register.lname
    let mobile = register.mobile
    
    let birthday = register.birthday
    let birthdayDay = register.birthdayDay
    let birthdayMonth = register.birthdayMonth
    let birthdayYear = register.birthdayYear
    let isSelectedMonth = register.isSelectedMonth
    let isSelectedYear = register.isSelectedYear
    var isBaby: Bool{ register.isBaby }
    
    let gender = register.gender
    var isMan: Bool { register.isMan }
    
    let marital = register.marital
    let blood = register.blood

    let values = RegisterFormValues()
    let leftRightSpace: CGFloat = 10
    
    let duration: CFTimeInterval = 0.5
    var jumpTimes: CGFloat = 2

    //MARK: INIT VIEW
    func initView(){
        setFnameEditor()
        setLnameEditor()
        setMobileEditor()
        setBirthdayEditor()
        setGenderEditor()
        setMaritalEditor()
        setBloodEditor()
        
        setTransform()
        
        startFname()
        if fname.count < 2{ focusTextEditor(fnameEditor, 0.5)
        }else if lname.count < 2{
            startLname()
            focusTextEditor(lnameEditor, 0.8)
        }else if mobile.count < 11{
            startLname()
            startMobile()
            focusTextEditor(mobileEditor, 0.9)
        }else{
            startLname()
            startMobile()
            startBirthday()
            if isSelectedMonth && !isSelectedYear{
                var _ = Timer.schedule(0.9) { _ in
                    self.focusYear()
                }
            }else if isSelectedYear{ startGender()
                if genderEditor.selected {
                    if !isBaby && !isMan{ startMarital()
                        if maritalEditor.selected{ startBlood() }
                    }else{ startBlood() }
                } 
            }
        }
    }
    
    //MARK: TRANSFORM
    func setTransform(){
        let y = height*jumpTimes
        mobileEditor.transformY(y)
        fnameEditor.transformY(y)
        lnameEditor.transformY(y)
        birthdayEditor.transformY(y)
        genderEditor.transformY(y)
        maritalEditor.transformY(y)
        bloodEditor.transformY(y)
    }
    
    //MARK: START EDDITORS
    func startFname(){
        fnameEditor.startView(delay: 0.2)
        fnameEditor.animate(transform: .identity, duration, curve, 0.25)
    }
    
    func startLname(){
        lnameEditor.startView(delay: 0.3)
        lnameEditor.animate(transform: .identity, duration, curve, 0.35)
    }
    
    func startMobile(){
        mobileEditor.startView(delay: 0.4)
        mobileEditor.animate(transform: .identity, duration, curve, 0.45)
    }
    
    func startBirthday(){
        birthdayEditor.startView(delay: 0.5)
        birthdayEditor.animate(transform: .identity, duration, curve, 0.55)
    }
    
    func startGender(){
        genderEditor.startView(delay: 0.6)
        genderEditor.animate(transform: .identity, duration, curve, 0.65)
    }
    
    func startMarital(){
        maritalEditor.startView(delay: 0.7)
        maritalEditor.animate(transform: .identity, duration, curve, 0.75)
    }
    
    func startBlood(){
        bloodEditor.startView(delay: 0.8)
        bloodEditor.animate(transform: .identity, duration, curve, 0.85)
    }
    
    func focusTextEditor(_ textEditor : TextEditor, _ delay: CFTimeInterval){
        var _ = Timer.schedule(delay) { _ in
            textEditor.inputText.becomeFirstResponder()
        }
    }
    
    //MARK: FNAME
    var fnameEditor = TextEditor()
    func setFnameEditor(){
        fnameEditor.frame(leftRightSpace,
                          leftRightSpace/2,
                          WIDTH - leftRightSpace*2,
                          editorsHeight)
        fnameEditor.title(values.fnameTitle)
        fnameEditor.isCharactersCheck(false)
        fnameEditor.placeholder(values.fnameHolder)
        fnameEditor.text(fname)
        fnameEditor.delegate(self)
        fnameEditor.shadow(.zero, gray08, 0.6, 0.7)
        fnameEditor.initView()
        addSubview(fnameEditor)
    }
    
    //MARK: LNAME
    var lnameEditor = TextEditor()
    func setLnameEditor(){
        lnameEditor.frame(leftRightSpace,
                          fnameEditor.y + editorsHeight/2,
                          WIDTH-leftRightSpace*2,
                          editorsHeight)
        lnameEditor.title(values.lnameTitle)
        lnameEditor.isCharactersCheck(false)
        lnameEditor.placeholder(values.lnameHolder)
        lnameEditor.text(lname)
        lnameEditor.delegate(self)
        lnameEditor.shadow(.zero, gray08, 0.6, 0.7)
        lnameEditor.initView()
        addSubview(lnameEditor)
    }
    
    //MARK: MOBILE
    var mobileEditor = TextEditor()
    func setMobileEditor(){
        mobileEditor.frame(leftRightSpace,
                           lnameEditor.y + editorsHeight/2,
                           WIDTH - leftRightSpace*2,
                           editorsHeight)
        mobileEditor.title(values.mobileTitle)
        mobileEditor.text(mobile)
        mobileEditor.keyboardType(.numberPad)
        mobileEditor.enableCharacters(NUMBER_CHARS)
        mobileEditor.delegate(self)
        mobileEditor.shadow(.zero, gray08, 0.6, 0.7)
        mobileEditor.initView()
        addSubview(mobileEditor)
    }
    
    //MARK: BIRTHDAY
    var birthdayEditor = DateEditor()
    func setBirthdayEditor(){
        birthdayEditor.frame(leftRightSpace,
                             mobileEditor.y + editorsHeight/2,
                             WIDTH - leftRightSpace*2,
                             editorsHeight)
        birthdayEditor.title(values.birthdayTitle)
        birthdayEditor.date(birthday)
        birthdayEditor.dateType(values.dateType)
        birthdayEditor.isSelectedDay(register.isSelectedDay)
        birthdayEditor.dayTitle(values.dayTitle)
        birthdayEditor.daysLabel(values.daysLabel)
        birthdayEditor.isSelectedMonth(register.isSelectedMonth)
        birthdayEditor.monthTitle(values.monthTitle)
        birthdayEditor.dayResult(register.birthdayDay)
        birthdayEditor.monthResult(register.birthdayMonth)
        birthdayEditor.monthsLabel(values.monthsLabel)
        birthdayEditor.monthNumber(register.monthNumber)
        birthdayEditor.monthReplaceCharacters(values.monthReplaceCharacters)
        birthdayEditor.isSelectedYear(register.isSelectedYear)
        birthdayEditor.yearTitle(values.yearTitle)
        birthdayEditor.initView()
        birthdayEditor.delegate(self)
        birthdayEditor.shadow(.zero, gray08, 0.6, 0.7)
        addSubview(birthdayEditor)
    }
    
    //MARK: GENDER
    var genderEditor = SwitchValues()
    func setGenderEditor(){
        genderEditor.frame(leftRightSpace,
                           birthdayEditor.y + editorsHeight/2,
                           WIDTH - leftRightSpace*2,
                           editorsHeight)
        genderEditor.title(values.genderTitle)
        genderEditor.options(values.genderOptions)
        genderEditor.result(gender)
        genderEditor.selected(register.genderSelected)
        genderEditor.xRow(2)
        genderEditor.autoOpen(false)
        genderEditor.delegate(self)
        genderEditor.initView()
        genderEditor.shadow(.zero, gray08, 0.6, 0.7)
        addSubview(genderEditor)
    }
    
    //MARK: MARITAL
    var maritalEditor = SwitchValues()
    func setMaritalEditor(){
        maritalEditor.frame(leftRightSpace,
                            genderEditor.y + editorsHeight/2,
                            WIDTH - leftRightSpace*2,
                            editorsHeight)
        maritalEditor.title(values.maritalTitle)
        maritalEditor.options(values.maritalOptions)
        maritalEditor.result(marital)
        maritalEditor.xRow(2)
        maritalEditor.selected(register.maritalSelected)
        maritalEditor.delegate(self)
        maritalEditor.initView()
        maritalEditor.shadow(.zero, gray08, 0.6, 0.7)
        addSubview(maritalEditor)
    }

    //MARK: BLOOD
    var bloodEditor = SwitchValues()
    func setBloodEditor(){
        let yHelper = isBaby || isMan ? genderEditor.y : maritalEditor.y
        bloodEditor.frame(leftRightSpace,
                          yHelper + editorsHeight/2,
                          WIDTH - leftRightSpace*2,
                          editorsHeight)
        bloodEditor.title(values.bloodTitle)
        bloodEditor.result(blood)
        bloodEditor.options(values.bloodOptions)
        bloodEditor.xRow(5)
        bloodEditor.shadow(.zero, gray08, 0.6, 0.7)
        bloodEditor.delegate(self)
        bloodEditor.selected(register.bloodSelected)
        bloodEditor.initView()
        addSubview(bloodEditor)
    }
    
    //MARK: FORM HEIGHT
    var formHeight: CGFloat{
        var result:CGFloat = editorsHeight + 8
        if lnameEditor.enable{ result += editorsHeight }
        if mobileEditor.enable{ result += editorsHeight }
        if birthdayEditor.enable{ result += editorsHeight }
        if birthdayEditor.isOpenDay{ result += birthdayEditor.daysHeight }
        if birthdayEditor.isOpenMonth{ result += birthdayEditor.monthsHeight }
        if genderEditor.enable{ result += editorsHeight }
        if genderEditor.isOpen{ result += genderEditor.openHeight }
        if maritalEditor.enable{ result += editorsHeight }
        if maritalEditor.isOpen{ result += maritalEditor.openHeight }
        if bloodEditor.enable{ result += editorsHeight }
        if bloodEditor.isOpen{ result += bloodEditor.openHeight }
        return result
    }
    
    //MARK: ON FOCUS
    func onFocus() {
        let transform = CGAffineTransform(y: height*jumpTimes)
        let mobile = mobileEditor.text.substring(to: numberPattern.count-1)
        register.mobile = mobile
        applyMobileFormat(mobile)
        
        let fname = fnameEditor.text
        register.fname = fname
        
        let lname = lnameEditor.text
        register.lname = lname
        
        if fname.count>1{
            lnameEditor.startView(delay: 0.0)
            lnameEditor.animate(transform: .identity, duration, curve, 0.05)
            if lname.count>1{
                mobileEditor.startView(delay: 0.05)
                mobileEditor.animate(transform: .identity, duration, curve, 0.10)
                if mobile.count>numberPattern.count-1{
                    birthdayEditor.startView(delay: 0.10)
                    birthdayEditor.animate(transform: .identity, duration, curve, 0.15)
                    if birthdayEditor.isSelectedYear && birthdayEditor.enable{
                        genderEditor.startView(delay: 0.15)
                        genderEditor.animate(transform: .identity, duration, curve, 0.20)
                        if genderEditor.selected{
                            if !isMan && !isBaby{
                                maritalEditor.startView(delay: 0.20)
                                maritalEditor.animate(transform: .identity, duration, curve, 0.35)
                                if maritalEditor.selected{
                                    bloodEditor.startView(delay: 0.25)
                                    bloodEditor.animate(transform: .identity, duration, curve, 0.30)
                                }
                            }else{
                                maritalEditor.closeView(delay: 0.10)
                                maritalEditor.animate(transform: transform, duration, curve, 0.20)
                                maritalEditor.reset()
                                saveSwitchValue()
                                bloodEditor.animate(transform: .identity, duration, curve, 0.35)
                                bloodEditor.startView(delay: 0.25)
                            }
                        }
                    }else{
                        genderEditor.closeView(delay: 0.20)
                        genderEditor.animate(transform: transform, duration, curve, 0.30)
                        maritalEditor.closeView(delay: 0.15)
                        maritalEditor.animate(transform: transform, duration, curve, 0.25)
                        bloodEditor.closeView(delay: 0.10)
                        bloodEditor.animate(transform: transform, duration, curve, 0.20)
                    }
                }else{
                    birthdayEditor.closeView(delay: 0.25)
                    birthdayEditor.animate(transform: transform, duration, curve, 0.35)
                    genderEditor.closeView(delay: 0.20)
                    genderEditor.animate(transform: transform, duration, curve, 0.30)
                    maritalEditor.closeView(delay: 0.15)
                    maritalEditor.animate(transform: transform, duration, curve, 0.25)
                    bloodEditor.closeView(delay: 0.10)
                    bloodEditor.animate(transform: transform, duration, curve, 0.20)
                }
            }else{
                mobileEditor.closeView(delay: 0.30)
                mobileEditor.animate(transform: transform, duration, curve, 0.40)
                birthdayEditor.closeView(delay: 0.25)
                birthdayEditor.animate(transform: transform, duration, curve, 0.35)
                genderEditor.closeView(delay: 0.20)
                genderEditor.animate(transform: transform, duration, curve, 0.30)
                maritalEditor.closeView(delay: 0.15)
                maritalEditor.animate(transform: transform, duration, curve, 0.25)
                bloodEditor.closeView(delay: 0.10)
                bloodEditor.animate(transform: transform, duration, curve, 0.20)
            }
        }else{
            lnameEditor.closeView(delay: 0.35)
            lnameEditor.animate(transform: transform, duration, curve, 0.45)
            mobileEditor.closeView(delay: 0.30)
            mobileEditor.animate(transform: transform, duration, curve, 0.40)
            birthdayEditor.closeView(delay: 0.25)
            birthdayEditor.animate(transform: transform, duration, curve, 0.35)
            genderEditor.closeView(delay: 0.20)
            genderEditor.animate(transform: transform, duration, curve, 0.30)
            maritalEditor.closeView(delay: 0.15)
            maritalEditor.animate(transform: transform, duration, curve, 0.25)
            bloodEditor.closeView(delay: 0.10)
            bloodEditor.animate(transform: transform, duration, curve, 0.20)
        }
        
        birthdayEditor.closeDay()
        birthdayEditor.closeMonth()
        closeSwitchValues()
    }
    
    //MARK: MOBILE FORMAT
    func applyMobileFormat(_ mobile: String){
        let fixMobilFormat = mobile.applyPatternOnNumbers(pattern: numberPattern)
        if fixMobilFormat != "" {
            let text = isRTL ?
                fixMobilFormat.faNumber :
                fixMobilFormat.enNumber
            let count = countryCode.count
            let firstChar = mobile.substring(from: count, to: count+1)
            let code = isRTL ?
                countryCode.faNumber :
                countryCode.enNumber
            let mobileCode = mobile.substring(from: 0, to: count-1)
            mobileEditor.text(firstChar == "0" ||
                              firstChar == "۰" ||
                              mobile.count < countryCode.count ||
                              mobileCode != code ? "\(code) " : text)
        }else{
            let text = isRTL ?
               countryCode.faNumber :
               countryCode.enNumber
            mobileEditor.text("\(text) ")
        }
    }
    
    func endEditing() {
        registerFormDeselected()
    }
    
    func textEditorSelected(cell: String) {
        registerFormSelected(cell: cell)
    }
    
    func onReturn() {
        registerFormDeselected()
    }
    
    func inCorrectMobile() {
        mobileEditor.inputText.placeholder(values.inCorrectMobileTitle)
        mobileEditor.focusKeyboard()
        mobileEditor.text(countryCode)
    }
    
    //MARK: OPEN DAY
    func openDay() {
        closeKeyboard()
        birthdayEditor.closeMonth()
        closeSwitchValues()
        birthdayEditor.animate(height: editorsHeight + birthdayEditor.daysHeight, duration, curve)
        birthdayEditor.animate(y: mobileEditor.y + editorsHeight + birthdayEditor.daysHeight/2, duration , curve)
        genderEditor.animate(y: birthdayEditor.y + editorsHeight + birthdayEditor.daysHeight/2, duration, curve)
        animateMaritalBlood()
        registerFormSelected(cell: birthdayEditor.dayTitle)
    }
    
    //MARK: CLOSE KEYBOARD
    func closeKeyboard(){
        mobileEditor.closeKeyboard()
        fnameEditor.closeKeyboard()
        lnameEditor.closeKeyboard()
        birthdayEditor.closeKeyboard()
    }
    
    //MARK: CLOSE DAY
    func closeDay() {
        saveBirthday()
        birthdayEditor.animate(height: editorsHeight , duration, curve)
        birthdayEditor.animate(y: mobileEditor.y + editorsHeight, duration , curve)
        genderEditor.animate(y: birthdayEditor.y + editorsHeight , duration, curve)
        animateMaritalBlood()
        registerFormDeselected()
    }
    
    //MARK: OPEN MONTH
    func openMonth() {
        closeKeyboard()
        birthdayEditor.closeDay()
        closeSwitchValues()
        birthdayEditor.closeKeyboard()
        birthdayEditor.animate(height: editorsHeight + birthdayEditor.monthsHeight, duration, curve)
        birthdayEditor.animate(y: mobileEditor.y + editorsHeight + birthdayEditor.monthsHeight/2, duration , curve)
        genderEditor.animate(y: birthdayEditor.y + editorsHeight + birthdayEditor.monthsHeight/2, duration, curve)
        animateMaritalBlood()
        registerFormSelected(cell: birthdayEditor.monthTitle)
    }
    
    //MARK: CLOSE MONTH
    func closeMonth() {
        saveBirthday()
        birthdayEditor.animate(height: editorsHeight , duration, curve)
        birthdayEditor.animate(y: mobileEditor.y + editorsHeight, duration , curve)
        if register.isSelectedYear{
            var _ = Timer.schedule(0.4) { _ in self.delayForFocusYear() }
        }
        genderEditor.animate(y: birthdayEditor.y + editorsHeight , duration, curve)
        animateMaritalBlood()
        registerFormDeselected()
    }
    
    //MARK: MARITAL BLOOD FIX Y
    func animateMaritalBlood(){
        if !isMan && !isBaby{
            maritalEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
            bloodEditor.animate(y: maritalEditor.y + editorsHeight, duration, curve)
        }else{
            maritalEditor.reset()
            saveSwitchValue()
            maritalEditor.closeView(delay: 0.10)
            maritalEditor.animate(transformY: height*jumpTimes, duration, curve, 0.15)
            bloodEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
        }
    }
    
    //MARK: DELAY YEAR
    @objc func delayForFocusYear(){
        if !birthdayEditor.isSelectedMonth{
            if birthdayEditor.yearEditor.text == Date().year{ birthdayEditor.yearEditor.text = "" }
            birthdayEditor.yearEditor.becomeFirstResponder()
        }
    }
    
    //MARK: CLOSE SWICH VALUE
    func closeSwitchValues(){
        genderEditor.close()
        maritalEditor.close()
        bloodEditor.close()
    }
    
    //MARK: ON FOCUS YEAR
    func onFocusYearEditor() {
        let transform = CGAffineTransform(y: height*jumpTimes)
        saveBirthday()
        closeSwitchValues()
        if register.birthdayYear.count >= 4{
            genderEditor.startView(delay: 0.0)
            genderEditor.animate(transform: .identity, duration, curve, 0.05)
            if genderEditor.selected{
                if !isMan && !isBaby{
                    maritalEditor.startView(delay: 0.05)
                    maritalEditor.animate(transform: .identity, duration, curve, 0.10)
                    if maritalEditor.selected{
                        bloodEditor.startView(delay: 0.10)
                        bloodEditor.animate(transform: .identity, duration, curve, 0.15)
                    }
                }else{
                    maritalEditor.closeView(delay: 0.10)
                    maritalEditor.animate(transform: transform, duration, curve, 0.15)
                    maritalEditor.reset()
                    saveSwitchValue()
                    bloodEditor.startView(delay: 0.10)
                    bloodEditor.animate(transform: .identity, duration, curve, 0.15)
                    bloodEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
                }
            }
        }else{
            genderEditor.closeView(delay: 0.20)
            genderEditor.animate(transform: transform, duration, curve, 0.30)
            maritalEditor.closeView(delay: 0.15)
            maritalEditor.animate(transform: transform, duration, curve, 0.25)
            bloodEditor.closeView(delay: 0.10)
            bloodEditor.animate(transform: transform, duration, curve, 0.15)
        }
        registerFormSelected(cell: birthdayEditor.yearTitle)
    }
    
    //MARK: END EDDITING DATE
    func endEditingDateEditor() {
        saveBirthday()
    }
    
    //MARK: SAVE BIRTHDAY
    func saveBirthday(){
        register.birthdayYear = birthdayEditor.yearEditor.text!
        register.isSelectedYear = birthdayEditor.isSelectedYear
        register.isSelectedMonth = birthdayEditor.isSelectedMonth
        register.birthdayMonth = birthdayEditor.monthResult
        register.monthNumber = birthdayEditor.monthNumber
        register.isSelectedDay = birthdayEditor.isSelectedDay
        register.birthdayDay = birthdayEditor.dayResult
        register.birthday = birthdayEditor.result
    }
    
    //MARK: OPEN SWICH VALUES
    func openSwitchValues(cell: String) {
        closeKeyboard()
        birthdayEditor.closeDay()
        birthdayEditor.closeMonth()
        switch cell {
        case values.genderTitle: openGender()
        case values.maritalTitle: openMarital()
        case values.bloodTitle: openBlood()
        default: break
        }
    }
    
    //MARK: OPEN GENDER
    func openGender(){
        let transform = CGAffineTransform(y: height*jumpTimes)
        maritalEditor.close()
        bloodEditor.close()
        genderEditor.animate(height: editorsHeight + genderEditor.openHeight, duration, curve)
        genderEditor.animate(y: birthdayEditor.y + genderEditor.openHeight/2 + editorsHeight, duration, curve)
        if !isMan && !isBaby{
            maritalEditor.animate(y: genderEditor.y + genderEditor.openHeight/2 + editorsHeight, duration, curve)
            bloodEditor.animate(y: maritalEditor.y + editorsHeight, duration, curve)
        }else{
            maritalEditor.closeView(delay: 0.10)
            maritalEditor.animate(transform: transform, duration, curve, 0.20)
            maritalEditor.reset()
            saveSwitchValue()
            bloodEditor.animate(y: genderEditor.y + genderEditor.openHeight/2 + editorsHeight, duration, curve)
        }
        registerFormSelected(cell: genderEditor.title)
    }
    
    //MARK: OPEN MARITAL
    func openMarital(){
        genderEditor.close()
        bloodEditor.close()
        maritalEditor.animate(height: editorsHeight + maritalEditor.openHeight, duration, curve)
        maritalEditor.animate(y: genderEditor.y + maritalEditor.openHeight/2 + editorsHeight, duration, curve)
        bloodEditor.animate(y: maritalEditor.y + maritalEditor.openHeight/2 + editorsHeight, duration, curve)
        registerFormSelected(cell: maritalEditor.title)
    }
    
    //MARK: OPEN BLOOD
    func openBlood(){
        genderEditor.close()
        maritalEditor.close()
        let height: CGFloat = editorsHeight + bloodEditor.openHeight
        let y = !isMan && !isBaby ?
            maritalEditor.y + bloodEditor.openHeight/2 :
            genderEditor.y + bloodEditor.openHeight/2
        bloodEditor.animate(height: height, duration, curve)
        bloodEditor.animate(y: y + editorsHeight, duration, curve)
        registerFormSelected(cell: bloodEditor.title)
    }
    
    //MARK: CLOSE SWICH VALUES
    func closeSwitchValues(cell: String) {
        saveSwitchValue()
        switch cell {
        case values.genderTitle: closeGender()
        case values.maritalTitle: closeMarital()
        case values.bloodTitle: closeBloodEditor()
        default: break
        }
        registerFormDeselected()
    }
    
    //MARK: CLOSE GENDER
    func closeGender(){
        let transform = CGAffineTransform(y: self.height*jumpTimes)
        genderEditor.animate(height: editorsHeight, duration, curve)
        genderEditor.animate(y: birthdayEditor.y + editorsHeight, duration, curve)
        if !isMan && !isBaby && genderEditor.selected{
            if !maritalEditor.enable{
                startMarital()
                maritalEditor.animate(transform: .identity, duration, curve)
            }
            maritalEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
            if maritalEditor.selected{
                if !bloodEditor.enable{
                    bloodEditor.startView()
                    bloodEditor.animate(transform: .identity, duration, curve, 0.05)
                }
                bloodEditor.animate(y: maritalEditor.y + editorsHeight, duration, curve)
            }else{
                bloodEditor.closeView()
                bloodEditor.animate(transform: transform, duration, curve, 0.1)
            }
        }else{
            maritalEditor.closeView()
            maritalEditor.animate(transform: transform, duration, curve, 0.1)
            maritalEditor.reset()
            saveSwitchValue()
            if !bloodEditor.enable && genderEditor.selected{
                bloodEditor.startView()
                bloodEditor.animate(transform: .identity, duration, curve, 0.1)
            }
            bloodEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
        }
    }
    
    //MARK: CLOSE MARITAL
    func closeMarital(){
        maritalEditor.animate(height: editorsHeight, duration, curve)
        maritalEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
        if maritalEditor.selected{
            if !bloodEditor.enable{
                bloodEditor.startView()
                bloodEditor.animate(transform: .identity, duration, curve)
            }
            bloodEditor.animate(y: maritalEditor.y + editorsHeight, duration, curve)
        }
    }
    
    //MARK: CLOSE BLOOD
    func closeBloodEditor(){
        bloodEditor.animate(height: editorsHeight, duration, curve)
        let y = !isMan && !isBaby ?
            maritalEditor.y + editorsHeight :
            genderEditor.y + editorsHeight
        bloodEditor.animate(y: y, duration, curve)
    }
    
    //MARK: SAVE SWITCH VALUES
    func saveSwitchValue() {
        register.gender = genderEditor.result
        register.genderSelected = genderEditor.selected
        register.marital = maritalEditor.result
        register.maritalSelected = maritalEditor.selected
        register.blood = bloodEditor.result
        register.bloodSelected = bloodEditor.selected
    }
    
    @objc func focusYear(){
        birthdayEditor.yearEditor.becomeFirstResponder()
    }
    
    func registerFormSelected(cell: String) {
        delegateRegisterForm?.registerFormSelected(cell: cell)
    }
    
    func registerFormDeselected() {
        delegateRegisterForm?.registerFormDeselected()
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        closeKeyboard()
        fnameEditor.closeView(delay: 0.0)
        lnameEditor.closeView(delay: 0.1)
        mobileEditor.closeView(delay: 0.0)
        birthdayEditor.closeView(delay: 0.1)
        genderEditor.closeView(delay: 0.2)
        maritalEditor.closeView(delay: 0.3)
        bloodEditor.closeView(delay: maritalEditor.selected ? 0.2 : 0.3)
        var _ = Timer.schedule(1.5) { _ in self.remove() }
    }
}
