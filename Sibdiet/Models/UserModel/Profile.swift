//
//  Profile.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/1/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Profile {
    
    var deviceId: String{
        get{ standard.string(forKey: "DEVICE_IDP") ?? String() }
        set{ standard.set(newValue, forKey: "DEVICE_IDP") }
    }
    var appleId: String{
        get{ standard.string(forKey: "APPLE_IDP") ?? String() }
        set{ standard.set(newValue, forKey: "APPLE_IDP") }
    }
    var fname: String{
        get{ standard.string(forKey: "FNAMEP") ?? String() }
        set{ standard.set(newValue, forKey: "FNAMEP") }
    }
    var lname: String{
        get{ standard.string(forKey: "LNAMEP") ?? String() }
        set{ standard.set(newValue, forKey: "LNAMEP") }
    }
    var fullName: String{ "\(fname) \(lname)" }
    
    var mobile: String{
        get{ standard.string(forKey: "MOBILEP") ?? String() }
        set{ standard.set(newValue, forKey: "MOBILEP") }
    }
    var email: String{
        get{ standard.string(forKey: "EMAILP") ?? String() }
        set{ standard.set(newValue, forKey: "EMAILP") }
    }
    var fileNumber: String{
        get{ standard.string(forKey: "FILENUMBERP") ?? String() }
        set{ standard.set(newValue, forKey: "FILENUMBERP") }
    }
    var birthday: Date{
        get{ standard.object(forKey: "BIRTHDAYP") as! Date }
        set{ standard.set(newValue, forKey: "BIRTHDAYP") }
    }
    var gender: String{
        get{ standard.string(forKey: "GENDERP") ?? String() }
        set{ standard.set(newValue, forKey: "GENDERP") }
    }
    var isMan: Bool{ genderResult == MALE }
    var genderResult: String{ gender == MOANAS || gender == Female || gender == FEMALE ? FEMALE : MALE }
    
    var marital: String{
        get{ standard.string(forKey: "MARITALP") ?? String() }
        set{ standard.set(newValue, forKey: "MARITALP") }
    }
    var isMarital: Bool { marital == "MARRIED" }

    var blood: String{
        get{ standard.string(forKey: "BLOODP") ?? String() }
        set{ standard.set(newValue, forKey: "BLOODP") }
    }
    var country : String{
        get{ standard.string(forKey: "COUNTRYP") ?? String() }
        set{ standard.set(newValue, forKey: "COUNTRYP") }
    }
    var city: String{
        get{ standard.string(forKey: "CITYP") ?? String() }
        set{ standard.set(newValue, forKey: "CITYP") }
    }
    var homeAddress: String{
        get{ standard.string(forKey: "HOMEADDRESSP") ?? String() }
        set{ standard.set(newValue, forKey: "HOMEADDRESSP") }
    }
    var homePhone: String{
        get{ standard.string(forKey: "HOMEPHONEP") ?? String() }
        set{ standard.set(newValue, forKey: "HOMEPHONEP") }
    }
    var id: String{
        get{ standard.string(forKey: "IDP") ?? String() }
        set{ standard.set(newValue, forKey: "IDP") }
    }
    var realID: String{
        get{ standard.string(forKey: "REALID") ?? String() }
        set{ standard.set(newValue, forKey: "REALID") }
    }
    var published: String{
        get{ standard.string(forKey: "PUBLISHEDP") ?? String() }
        set{ standard.set(newValue, forKey: "PUBLISHEDP") }
    }
    var dietCount: Int{
        get{ standard.integer(forKey: "DIETCOUNTP\(dietConnection.fileNumber)") }
        set{ standard.set(newValue, forKey: "DIETCOUNTP\(dietConnection.fileNumber)") }
    }
    
    var isBaby: Bool{ Date().months(since: birthday)!/12 < 17 }

    var education = String()
    var job = String()
    var telegramId = String()
    var secretkey = String()
    var naturalTemper = String()
    var isFirstTime: Bool{ dietCount <= 0 }
    var hasDiet: Bool{ dietCount != 0 && diet.idealWeight != String() }
    
    var diet = Diet()
    var prescriptions = Prescriptions()
    var supplements = [Supplements]()
    
    func loadSupplement(){
        if let supplement = standard.object(forKey: "SUPPLEMENTS") as? Data {
            if let res = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(supplement)
                as? [Supplements] {
                supplements = res
            }
        }
    }
    
    var body = Body()
    
    //MARK: SET PROFILE
    func setProfile(json: JSON){
        appleId       = json[PROFILE][APPLE_ID].stringValue
        city          = json[PROFILE][CITY].stringValue
        marital       = json[PROFILE][MARITAL].stringValue
        mobile        = json[PROFILE][MOBILE].stringValue
        homeAddress   = json[PROFILE][HOME_ADDRESS].stringValue
        gender        = json[PROFILE][GENDER].stringValue
        naturalTemper = json[PROFILE][NATURAL_TAMPER].stringValue
        homePhone     = json[PROFILE][HOME_PHONE].stringValue
        birthday      = json[PROFILE][BIRTHDAY].stringValue.date
        telegramId    = json[PROFILE][TELEGRAM_ID].stringValue
        fileNumber    = json[PROFILE][ID].stringValue
        email         = json[PROFILE][EMAIL].stringValue
        lname         = json[PROFILE][L_NAME].stringValue
        job           = json[PROFILE][JOB].stringValue
        education     = json[PROFILE][EDUCATION].stringValue
        blood         = json[PROFILE][BLOOD].stringValue
        fname         = json[PROFILE][F_NAME].stringValue
        country       = json[PROFILE][COUNTRY].stringValue
        saveProfile()
    }
    
    //MARK: SAVE UPDATE
    func saveUpdate(){
        mobile      = updateProfile.mobile.enNumber
        birthday    = updateProfile.birthday
        gender      = updateProfile.genderResult
        marital     = updateProfile.maritalResult
        blood       = updateProfile.bloodResult
        city        = updateProfile.city
        email       = updateProfile.email
        homePhone   = updateProfile.homePhone
        homeAddress = updateProfile.homeAddress
    }
    
    //MARK: SAVE PROFILE
    func saveProfile(){
        updateProfile.mobile      = mobile.enNumber
        updateProfile.birthday    = birthday
        updateProfile.gender      = gender
        updateProfile.marital     = marital
        updateProfile.blood       = blood
        updateProfile.country     = country
        updateProfile.city        = city
        updateProfile.email       = email
        updateProfile.homePhone   = homePhone.enNumber
        updateProfile.homeAddress = homeAddress
    }
    
    //MARK: SAVE SUPPLEMENT
    func setSupplementData(json: JSON){
        supplements = [Supplements]()
        let prescriptions = json[DIET][PRESCRIPTIONS]
        if prescriptions.count > 0{
            for (_, prescription): (String, JSON) in prescriptions{
                let supplement          = Supplements(title: prescription[TITLE].stringValue,
                                                      printTitle: prescription[PRINT_TITLE].stringValue,
                                                      amount: prescription[AMOUNT].stringValue,
                                                      usage: prescription[USAGE].stringValue,
                                                      descriptions: prescription[DESCRIPTION].stringValue)
                supplements.append(supplement)
            }
        }
        let hprescriptions = json[DIET][HPRESCRIPTIONS]
        if hprescriptions.count > 0{
            for (_, hprescription): (String, JSON) in hprescriptions{
                let supplement          = Supplements(title: hprescription[TITLE].stringValue,
                                                      printTitle: hprescription[PRINT_TITLE].stringValue,
                                                      amount: hprescription[AMOUNT].stringValue,
                                                      usage: hprescription[USAGE].stringValue,
                                                      descriptions: hprescription[DESCRIPTION].stringValue)
                
                supplements.append(supplement)
            }
        }
        
        if #available(iOS 11.0, *) {
            if let meal = try? NSKeyedArchiver.archivedData(withRootObject: supplements,
                                                            requiringSecureCoding: false) {
                standard.set(meal, forKey: "SUPPLEMENTS")
            }
        }
    }
}
