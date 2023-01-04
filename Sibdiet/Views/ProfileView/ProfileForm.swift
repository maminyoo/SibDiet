//
//  ProfileForm.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/13/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol ProfileFormDelegate {
    func profileFormSelected(cell: String)
    func profileFormDeSelected()
}

class ProfileForm: UIView, ProfileFormDelegate, TextEditorDelegate, DateEditorDelegate, SwitchValuesDelegate{
    
    var delegateProfileForm: ProfileFormDelegate?
    func delegate(_ delegate: ProfileFormDelegate){
        self.delegateProfileForm = delegate
    }
    
    var editorsHeight = CGFloat()
    func editorsHeight(_ height: CGFloat){
        self.editorsHeight = height
    }
    
    let duration: CFTimeInterval = 0.5
    let values = ProfileFormValues()
    let leftRightSpace: CGFloat = 10

    //MARK: INIT VIEW
    func initView(){
        profile.saveProfile()
        setMobileEditor()
        setEmailEditor()
        setDateEditor()
        setGenderEditor()
        setMaritalEditor()
        setBloodEditor()
        setCountryEditor()
        setCityEditor()
        setAddressEditor()
        setHomePhoneEditor()

        mobileEditor.startView(delay: 0.4)
        emailEditor.startView(delay: 0.3)
        dateEditor.startView(delay: 0.5)
        genderEditor.startView(delay: 0.4)
        maritalEditor.startView(delay: 0.5)
        bloodEditor.startView(delay: 0.6)
        countryEditor.startView(delay: 0.7)
        cityEditor.startView(delay: 0.8)
        addressEditor.startView(delay: 0.7)
        homePhoneEditor.startView(delay: 0.8)
    }
    
    //MARK: MOBILE
    let mobileEditor = TextEditor()
    func setMobileEditor(){
        mobileEditor.frame(leftRightSpace,
                           0,
                           width-leftRightSpace*2,
                           editorsHeight)
        mobileEditor.title(values.mobileTitle)
        mobileEditor.isEnable(false)
        mobileEditor.placeholder(values.mobileValue)
        mobileEditor.text(values.mobileValue)
        mobileEditor.keyboardType(.numberPad)
        mobileEditor.shadow(.zero, gray08, 0.7, 0.6)
        mobileEditor.delegate(self)
        mobileEditor.enableCharacters(NUMBER_CHARS)
        mobileEditor.initView()
        addSubview(mobileEditor)
    }
    
    //MARK: EMAIL
    let emailEditor = TextEditor()
    func setEmailEditor(){
        emailEditor.frame(leftRightSpace,
                          mobileEditor.y + mobileEditor.height/2,
                          self.width-leftRightSpace*2,
                          editorsHeight)
        emailEditor.title(values.emailTitle)
        emailEditor.placeholder("email@website.com")
        emailEditor.text(profile.email)
        emailEditor.keyboardType(.emailAddress)
        emailEditor.shadow(.zero, gray08, 0.7, 0.6)
        emailEditor.isCharactersCheck(false)
        emailEditor.delegate(self)
        emailEditor.initView()
        addSubview(emailEditor)
    }

    //MARK: DATE
    let dateEditor = DateEditor()
    func setDateEditor(){
        dateEditor.frame(leftRightSpace,
                         emailEditor.y + emailEditor.height/2,
                         width-leftRightSpace*2,
                         editorsHeight)
        dateEditor.date(profile.birthday)
        dateEditor.dateType(values.dateType)
        dateEditor.daysLabel(values.daysLabel)
        dateEditor.monthsLabel(values.monthsLabel)
        dateEditor.monthReplaceCharacters(values.monthReplaceCharacters)
        dateEditor.title(values.birthdayTitle)
        dateEditor.shadow(.zero, gray08, 0.7, 0.6)
        dateEditor.delegate(self)
        dateEditor.initView()
        addSubview(dateEditor)
    }
    
    //MARK: GENDER
    let genderEditor = SwitchValues()
    func setGenderEditor(){
        genderEditor.frame(leftRightSpace,
                           dateEditor.y + dateEditor.height/2,
                           width-leftRightSpace*2,
                           editorsHeight)
        genderEditor.title(values.genderTitle)
        genderEditor.shadow(.zero, gray08, 0.7, 0.6)
        genderEditor.result(values.gender)
        genderEditor.options(values.genderOptions)
        genderEditor.xRow(2)
        genderEditor.delegate(self)
        genderEditor.initView()
        addSubview(genderEditor)
    }
    
    //MARK: MARITAL
    let maritalEditor = SwitchValues()
    func setMaritalEditor(){
        maritalEditor.frame(leftRightSpace,
                            genderEditor.y + genderEditor.height/2,
                            width-leftRightSpace*2,
                            editorsHeight)
        maritalEditor.title(values.maritalTitle)
        maritalEditor.shadow(.zero, gray08, 0.7, 0.6)
        maritalEditor.xRow(2)
        maritalEditor.options(values.maritalOptions)
        maritalEditor.result(values.marital)
        maritalEditor.delegate(self)
        maritalEditor.initView()
        addSubview(maritalEditor)
    }
    
    //MARK: BLOOD
    let bloodEditor = SwitchValues()
    func setBloodEditor(){
        bloodEditor.frame(leftRightSpace,
                          maritalEditor.y + maritalEditor.height/2,
                          width-leftRightSpace*2,
                          editorsHeight)
        bloodEditor.title(values.bloodTitle)
        bloodEditor.result(values.blood)
        bloodEditor.options(values.bloodOptions)
        bloodEditor.xRow(5)
        bloodEditor.shadow(.zero, gray08, 0.7, 0.6)
        bloodEditor.delegate(self)
        bloodEditor.initView()
        addSubview(bloodEditor)
    }
    
    //MARK: COUNTRY
    let countryEditor = SwitchValues()
    func setCountryEditor(){
        countryEditor.frame(leftRightSpace,
                            bloodEditor.y + bloodEditor.height/2,
                            width-leftRightSpace*2,
                            editorsHeight)
        countryEditor.title(values.countryTitle)
        countryEditor.result(values.countryCorrection)
        countryEditor.shadow(.zero, gray08, 0.7, 0.6)
        countryEditor.xRow(3)
        countryEditor.options(["x","y","z"])
        countryEditor.isDisable(true)
        countryEditor.initView()
        addSubview(countryEditor)
    }
    
    //MARK: CITY
    let cityEditor = TextEditor()
    func setCityEditor(){
        cityEditor.frame(leftRightSpace,
                         countryEditor.y + countryEditor.height/2,
                         width-leftRightSpace*2,
                         editorsHeight)
        cityEditor.title(values.cityTitle)
        cityEditor.isCharactersCheck(false)
        cityEditor.placeholder(profile.city)
        cityEditor.text(profile.city)
        cityEditor.shadow(.zero, gray08, 0.7, 0.6)
        cityEditor.delegate(self)
        cityEditor.initView()
        addSubview(cityEditor)
    }
    
    //MARK: ADDRESS
    let addressEditor = TextEditor()
    func setAddressEditor(){
        addressEditor.frame(leftRightSpace,
                            cityEditor.y + cityEditor.height/2,
                            width-leftRightSpace*2,
                            editorsHeight)
        addressEditor.title(values.addressTitle)
        addressEditor.isCharactersCheck(false)
        addressEditor.placeholder(profile.homeAddress)
        addressEditor.text(profile.homeAddress)
        addressEditor.shadow(.zero, gray08, 0.7, 0.6)
        addressEditor.delegate(self)
        addressEditor.initView()
        addSubview(addressEditor)
    }
    
    //MARK: HOME PHONE
    let homePhoneEditor = TextEditor()
    func setHomePhoneEditor(){
        homePhoneEditor.frame(leftRightSpace,
                              addressEditor.y + addressEditor.height/2,
                              width-leftRightSpace*2,
                              editorsHeight)
        homePhoneEditor.title(values.homePhoneTitle)
        homePhoneEditor.enableCharacters(NUMBER_CHARS)
        homePhoneEditor.keyboardType(.phonePad)
        homePhoneEditor.placeholder(values.homePhone)
        homePhoneEditor.text(values.homePhone)
        homePhoneEditor.shadow(.zero, gray08, 0.7, 0.6)
        homePhoneEditor.delegate(self)
        homePhoneEditor.initView()
        addSubview(homePhoneEditor)
    }
    
    //MARK: FORM HEIGHT
    var formHeight: CGFloat{
        var height = editorsHeight*10
        if dateEditor.isOpenDay{ height += dateEditor.daysHeight }
        else if dateEditor.isOpenMonth{ height += dateEditor.monthsHeight }
        else if genderEditor.isOpen{ height += genderEditor.openHeight }
        else if maritalEditor.isOpen{ height += maritalEditor.openHeight }
        else if bloodEditor.isOpen{ height += bloodEditor.openHeight }
        return height
    }
    
    //MARK: ON FOCUS
    func onFocus() {
        let email = emailEditor.text
        updateProfile.email = email.isValidEmail ? email : ""
        
        if cityEditor.text == "⏤"{ cityEditor.text = "" }
        if addressEditor.text == "⏤"{ addressEditor.text = "" }
        updateProfile.city = cityEditor.text
        
        let homePhone = homePhoneEditor.text.substring(to: 15)
        updateProfile.homePhone = homePhone
        homePhoneEditor.text = isRTL ? homePhone.faNumber : homePhone.enNumber
        
        updateProfile.homeAddress = addressEditor.text
        
        closeSwitchs()
        dateEditor.closeDay()
        dateEditor.closeMonth()
    }
    
    func textEditorSelected(cell: String) {
        profileFormSelected(cell: cell)
    }
    
    func endEditing() {
        profileFormDeSelected()
        saveToEghtedar()
    }
    
    func onReturn() {
        profileFormDeSelected()
        saveToEghtedar()
    }
    
    //MARK: CLOSE KEYBOARD
    func closeKeyboard(){
        mobileEditor.closeKeyboard()
        emailEditor.closeKeyboard()
        cityEditor.closeKeyboard()
        homePhoneEditor.closeKeyboard()
        addressEditor.closeKeyboard()
        dateEditor.closeKeyboard()
    }
    
    //MARK: CLOSE SWICHES
    func closeSwitchs(){
        bloodEditor.close()
        genderEditor.close()
        maritalEditor.close()
    }
    
    //MARK: OPEN DAY
    func openDay() {
        closeKeyboard()
        closeSwitchs()
        dateEditor.closeMonth()
        dateEditor.animate(height: editorsHeight + dateEditor.daysHeight, duration, curve)
        dateEditor.animate(y: emailEditor.y + editorsHeight + dateEditor.daysHeight/2 , duration, curve)
        genderEditor.animate(y: dateEditor.y + editorsHeight + dateEditor.daysHeight/2, duration, curve)
        pushDownMaritalEditor()
        profileFormSelected(cell: "day")
    }
    
    //MARK: CLOSE DAY
    func closeDay() {
        closeDateEditor()
        profileFormDeSelected()
    }
    
    //MARK: OPEN MONTH
    func openMonth() {
        closeKeyboard()
        closeSwitchs()
        dateEditor.closeDay()
        dateEditor.animate(height: editorsHeight + dateEditor.monthsHeight, duration, curve)
        dateEditor.animate(y: emailEditor.y + editorsHeight + dateEditor.monthsHeight/2 , duration, curve)
        genderEditor.animate(y: dateEditor.y + editorsHeight + dateEditor.monthsHeight/2, duration, curve)
        pushDownMaritalEditor()
        profileFormSelected(cell: "month")
    }
    
    //MARK: CLOSE MONTH
    func closeMonth() {
        closeDateEditor()
        profileFormDeSelected()
    }
    
    //MARK: CLOSE DATE
    func closeDateEditor(){
        dateEditor.animate(height: editorsHeight, duration, curve)
        dateEditor.animate(y: emailEditor.y + editorsHeight , duration, curve)
        genderEditor.animate(y: dateEditor.y + editorsHeight , duration, curve)
        maritalEditor.animate(y: genderEditor.y + editorsHeight , duration, curve)
        pushDownBloodEditor()
        endEditingDateEditor()
    }
    
    //MARK: PUSH BLOOD
    func pushDownBloodEditor(){
        bloodEditor.animate(y: maritalEditor.y + editorsHeight, duration, curve)
        pushDownCountryEditor()
    }
    
    //MARK: PUSH COUNTRY
    func pushDownCountryEditor(){
        countryEditor.animate(y: bloodEditor.y + editorsHeight, duration, curve)
        pushDownCityEditor()
    }
    
    //MARK: PUSH CITY
    func pushDownCityEditor(){
        cityEditor.animate(y: countryEditor.y + editorsHeight, duration, curve)
        addressEditor.animate(y: cityEditor.y + editorsHeight, duration, curve)
        homePhoneEditor.animate(y: addressEditor.y + editorsHeight, duration, curve)
    }
    
    //MARK: FOCUS YEAR
    func onFocusYearEditor() {
        closeSwitchs()
        profileFormSelected(cell: "year")
        saveToEghtedar()
    }
    
    //MARK: END EDDITING DATE
    func endEditingDateEditor() {
        updateProfile.birthday = dateEditor.result
        profileFormDeSelected()
    }
    
    //MARK: OPEN SWITCH VALUES
    func openSwitchValues(cell: String) {
        dateEditor.closeDay()
        dateEditor.closeMonth()
        switch cell {
        case ProfileFormValues().genderTitle: openGenderEditor()
        case ProfileFormValues().maritalTitle: openMaritalEditor()
        case ProfileFormValues().bloodTitle: openBloodEditor()
        default: break
        }
        closeKeyboard()
    }
    
    //MARK: OPEN GENDER
    func openGenderEditor(){
        maritalEditor.close()
        bloodEditor.close()
        genderEditor.animate(height: editorsHeight + genderEditor.openHeight, duration, curve)
        genderEditor.animate(y: dateEditor.y + editorsHeight + genderEditor.openHeight/2, duration, curve)
        maritalEditor.animate(y: genderEditor.y + editorsHeight + genderEditor.openHeight/2, duration, curve)
        pushDownBloodEditor()
        profileFormSelected(cell: "gender")
    }
    
    //MARK: OPEN MARITAL
    func openMaritalEditor(){
        genderEditor.close()
        bloodEditor.close()
        maritalEditor.animate(height: editorsHeight + maritalEditor.openHeight, duration, curve)
        maritalEditor.animate(y: genderEditor.y + editorsHeight + maritalEditor.openHeight/2, duration, curve)
        bloodEditor.animate(y: maritalEditor.y + editorsHeight + maritalEditor.openHeight/2, duration, curve)
        pushDownCountryEditor()
        profileFormSelected(cell: "marital")
    }
    
    //MARK: OPEN BLOOD
    func openBloodEditor(){
        genderEditor.close()
        maritalEditor.close()
        bloodEditor.animate(height: editorsHeight + bloodEditor.openHeight, duration, curve)
        bloodEditor.animate(y: maritalEditor.y + editorsHeight + bloodEditor.openHeight/2 , duration, curve)
        countryEditor.animate(y: bloodEditor.y + editorsHeight + bloodEditor.openHeight/2, duration, curve)
        pushDownCityEditor()
        profileFormSelected(cell: "blood")
    }
    
    //MARK: CLOSE SWITCH VALUES
    func closeSwitchValues(cell: String) {
        switch cell {
        case ProfileFormValues().genderTitle: closeGenderEditor()
        case ProfileFormValues().maritalTitle: closeMaritalEditor()
        case ProfileFormValues().bloodTitle: closeBloodEditor()
        default: break
        }
        saveSwitchValues()
    }
    
    //MARK: CLOSE GENDER
    func closeGenderEditor(){
        genderEditor.animate(height: editorsHeight, duration, curve)
        genderEditor.animate(y: dateEditor.y + editorsHeight, duration, curve)
        pushDownMaritalEditor()
    }
    
    //MARK: CLOSE MARITAL
    func closeMaritalEditor(){
        maritalEditor.animate(height: editorsHeight, duration, curve)
        pushDownMaritalEditor()
    }
    
    //MARK: CLOSE BLOOD
    func closeBloodEditor(){
        bloodEditor.animate(height: editorsHeight, duration, curve)
        pushDownBloodEditor()
    }
    
    //MARK: PUSH MARITAL
    func pushDownMaritalEditor(){
        maritalEditor.animate(y: genderEditor.y + editorsHeight, duration, curve)
        pushDownBloodEditor()
    }
    
    //MARK: SAVE SWITCH
    func saveSwitchValues() {
        updateProfile.gender = genderEditor.result
        updateProfile.marital = maritalEditor.result
        updateProfile.blood = bloodEditor.result
        profileFormDeSelected()
    }
    
    //MARK: FORM SELECTED
    func profileFormSelected(cell: String) {
        delegateProfileForm?.profileFormSelected(cell: cell)
    }
    
    func profileFormDeSelected() {
        delegateProfileForm?.profileFormDeSelected()
        saveToEghtedar()
    }
    
    //MARK: SAVE TO SERVER
    func saveToEghtedar(){
        if updateProfile.needUpdate{
            dietConnection.update()
        }
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        mobileEditor   .closeView(delay: 0.5)
        emailEditor    .closeView(delay: 0.3)
        dateEditor     .closeView(delay: 0.4)
        genderEditor   .closeView(delay: 0.5)
        maritalEditor  .closeView(delay: 0.4)
        bloodEditor    .closeView(delay: 0.4)
        countryEditor  .closeView(delay: 0.3)
        cityEditor     .closeView(delay: 0.2)
        addressEditor  .closeView(delay: 0.3)
        homePhoneEditor.closeView(delay: 0.2)
    }
}
