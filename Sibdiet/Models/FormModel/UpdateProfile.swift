//
//  UpdateProfile.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/21/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import Foundation

class UpdateProfile{
    var mobile = String()
    var mobilePattern: String{
        let firstTwoCharacter = mobile.substring(from: 0, to: 1).enNumber
        let isNatialCode = firstTwoCharacter == "00"
        let inCounrty = firstTwoCharacter == "09" && countryCode == "+98"
        let inNatial = "+" + mobile.substring(from: 2, to:  mobile.count-1).enNumber
        let inNumber = countryCode + mobile.substring(from: 1, to: mobile.count-1).enNumber
        return inCounrty ? inNumber.applyPatternOnNumbers(pattern: numberPattern) :
            isNatialCode ? inNatial.applyPatternOnNumbers(pattern: numberPattern) : mobile
    }
    
    var email = String()
    var birthday = Date()
    var isBaby: Bool{ Date().months(since: birthday)!/12 < 17 }
    
    var gender = String()
    var isMan: Bool{ genderResult == MALE }
    var genderResult: String{ gender == MOANAS || gender == Female || gender == FEMALE ? FEMALE : MALE }
    
    var marital = String()
    var isMarital: Bool{ maritalResult == MARRIED }
    var maritalResult: String{ marital == MOTAAHEL || marital == Married || marital == MARRIED ? MARRIED : SINGLE }
    
    var blood = String()
    var bloodResult:String{ blood == NEMIDANAM || blood == DNT_KNOW ? NOT_KNOW : blood }
    
    var country = String()
    var city = String()
    var homePhone = String()
    var homeAddress = String()
    
    //MARK: PROFILE PARAMETERS
    var profileParams: [String: String] { [BIRTHDAY     : birthday.toString,
                                           GENDER       : genderResult,
                                           MARITAL      : maritalResult,
                                           BLOOD        : bloodResult,
                                           APPLE_ID     : deviceId,
                                           LIMOO_ID     : "",
                                           CITY         : city,
                                           EMAIL        : email,
                                           HOME_PHONE   : homePhone.enNumber,
                                           HOME_ADDRESS : homeAddress.enNumber,
                                           COUNTRY      : settings.regionCode] }
    //MARK: NEED SAVE
    var needUpdate: Bool{
        var bool = false
        if      profile.birthday.toString      != birthday.toString{ bool = true }
        else if profile.gender                 != genderResult{ bool = true }
        else if profile.marital                != maritalResult{ bool = true }
        else if profile.blood                  != bloodResult{ bool = true }
        else if profile.city                   != city{ bool = true }
        else if profile.homePhone.enNumber     != homePhone.enNumber{ bool = true }
        else if profile.homeAddress.enNumber   != homeAddress.enNumber{ bool = true }
        else if profile.email                  != email{ bool = true }
        return bool
    }
}
