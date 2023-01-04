//
//  Register.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/29/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import Foundation

class Register{
    var oldFullName = ""
    var oldFileNumber = ""
    var isDuplicateMobile = false
    
    var fileNumber = ""
    var newMobil = ""
    var fname = ""
    var lname = ""
    
    var mobile = ""
    var mobileResult: String{
        let mobile = self.mobile.replace([" ":"","-":"","(":"",")":""])
        let codeCount = countryCode.count
        let subscriptMobile = mobile.substring(from: 0, length: codeCount).enNumber
        let remining = "0\(mobile.substring(from: codeCount, length: mobile.count))"
        let fullMobile = "00\(mobile.substring(from: 1, length: mobile.count-1))"
        return countryCode == "+98" && subscriptMobile == countryCode ?
            remining.enNumber :
            subscriptMobile == countryCode ? fullMobile :
            mobile.enNumber
    }
    
    var fullName: String{ fname + " " + lname }
    
    var birthday = Date()
    var birthdayDay = ROOZ
    var isSelectedDay = false
    
    var birthdayMonth = MAH
    var monthNumber = String()
    var isSelectedMonth = false
    
    var birthdayYear = SAL
    var isSelectedYear = false
    
    var isBaby: Bool{ Date().months(since: birthday)!/12 < 17 }
    
    var gender = String()
    var genderSelected = false
    var genderResult: String{ gender == MOANAS || gender == Female ? FEMALE :  gender == MOZAKAR || gender == Male ? MALE : BABY }
    
    var isMan: Bool { genderResult == MALE }
    
    var marital = String()
    var maritalSelected = false
    var maritalResult: String{ !isBaby || !isMan && marital == MOTAAHEL || marital == Married ? MARRIED : SINGLE }
    
    var education = ""
    var blood = ""
    var bloodSelected = false
    var bloodResult:String{ blood == NEMIDANAM || blood == DNT_KNOW ? NOT_KNOW : blood }
    
    var city = String()
    var homephone = String()
    var homeaddress = String()
    
    //MARK: REGISTER PARAMETERS
    var registerParams: [String: String]{ [F_NAME      : fname,
                                           L_NAME      : lname,
                                           MOBILE      : mobileResult.enNumber,
                                           BIRTHDAY    : birthday.toString,
                                           GENDER      : genderResult,
                                           MARITAL     : maritalResult,
                                           EDUCATION   : ELEMENTARY,
                                           BLOOD       : bloodResult,
                                           APPLE_ID    : profile.deviceId,
                                           JOB         : " ",
                                           COUNTRY     : settings.regionCode,
                                           CITY        : "⏤",
                                           HOME_PHONE  : " ",
                                           HOME_ADDRESS: "⏤"] }
    //MARK: RESET
    func reset(){
        isDuplicateMobile = false
        oldFileNumber     = String()
        fname             = String()
        lname             = String()
        newMobil          = String()
        mobile            = String()
        birthday          = Date()
        birthdayDay       = ROOZ
        isSelectedDay     = false
        birthdayMonth     = MAH
        isSelectedMonth   = false
        birthdayYear      = SAL
        isSelectedYear    = false
        gender            = String()
        genderSelected    = false
        marital           = String()
        maritalSelected   = false
        education         = String()
        blood             = String()
        bloodSelected     = false
        city              = String()
        homephone         = String()
        homeaddress       = String()
    }
}
