//
//  GeneralInfoValues.swift
//  Sibdiet
//
//  Created by Amin on 5/9/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class GeneralInfoValues{
    
    var backButtonTitle: String{
        switch language {
        case EN: return "Back"
        default: return  "بازگشت"
        }
    }
    
    var genderMarital:String{
        var gender: String{
            switch language {
            case EN: return profile.gender == MALE ? "Male" : "Female"
            default: return profile.gender == MALE ? "مذکر" : "مونث"
            }
        }
        var marital: String{
            switch language {
            case EN: return profile.marital == SINGLE ? "Single" : "Married"
            default: return profile.marital == SINGLE ? "مجرد" : "متاهل"
            }
        }
        return gender + "  /  " + marital
    }
    
    var age: String{
        let birthday = profile.birthday
        let days = birthday.days(to: Date())
        switch language {
        case EN: return days.dateString
        default: return days.persianDateString
        }
    }
    
    var BMI: String{
        let st = Double(updateBody.stature.result)!
        let st02 = (st / 100) * (st / 100)
        let bmi = Double(updateBody.weight.result)! / st02
        return "BMI : \(bmi.rounded(toPlaces: 2))"
    }
    
    var bodyState: String{
        var result = ""
        let bmi = Double(BMI.substring(from: 6, to: BMI.count))!
        switch bmi {
        case 0...16.5:
            switch language{
            case EN : result = "Severe weight deficiency"
            default : result = "کمبود وزن شدید"
            }
        case 16.5...18.5:
            switch language{
            case EN : result = "Weight deficiency"
            default : result = "كمبود وزن"
            }
        case 18.5...24.9:
            switch language{
            case EN : result = "Normal"
            default : result =  "عادی"
            }
        case 24.9...29.9:
            switch language{
            case EN : result = "Overweight"
            default : result = "اضافه وزن"
            }
        case 29.9...34.9:
            switch language{
            case EN : result = "Fat"
            default : result = "چاق"
            }
        case 34.9...39.9:
            switch language{
            case EN : result = "Very obese"
            default : result = "بسیار چاق"
            }
        case 39.9...100:
            switch language{
            case EN : result = "Morbidly obese"
            default : result = "چاقی مفرط"
            }
        default: break
        }
        return result
    }
    
    var ageYears: Int{
        let now = Date()
        let birthday = profile.birthday
        let days = birthday.days(to: now)
        return days/365
    }
    
    var weight: NSMutableAttributedString{
        var weight: String{
            switch language{
            case EN : return updateBody.weight.result
            default : return updateBody.weight.result.faNumber
            }
        }
        var fullWeight: String{
            switch language{
            case EN : return "Weight  " + weight + "  kg"
            default : return "وزن  " + weight + "  کیلوگرم"
            }
        }
        let sFont = UIFont(Sahel_Bold, 30)!
        let font = UIFont(Sahel, 22)!
        return fullWeight.mutableString(specialString: weight,
                                        defaultFont: font,
                                        defaultColor: gray05,
                                        specialFont: sFont,
                                        specialColor: gray05,
                                        specialBackgroundColor: UIColor.clear)
    }
    
    var stature: NSMutableAttributedString{
        var stature: String{
            switch language{
            case EN : return updateBody.stature.result
            default : return updateBody.stature.result.faNumber
            }
        }
        var fullStature: String{
            switch language{
            case EN : return "Stature  " + stature + "  cm"
            default : return "قد  " + stature + "  سانتیمتر"
            }
        }
        let sFont = UIFont(Sahel_Bold, 30)!
        let font = UIFont(Sahel, 22)!
        return fullStature.mutableString(specialString: stature,
                                         defaultFont: font,
                                         defaultColor: gray05,
                                         specialFont: sFont,
                                         specialColor: gray05,
                                         specialBackgroundColor: UIColor.clear)
    }
    
    var wrist: NSMutableAttributedString{
        var wrist: String{
            switch language{
            case EN : return updateBody.wrist.result
            default : return updateBody.wrist.result.faNumber
            }
        }
        var fullWrist: String{
            switch language{
            case EN : return "Wrist  " + wrist + "  cm"
            default : return "دور مچ  " + wrist + "  سانتیمتر"
            }
        }
        let sFont = UIFont(Sahel_Bold, 30)!
        let font = UIFont(Sahel, 22)!
        return fullWrist.mutableString(specialString: wrist,
                                       defaultFont: font,
                                       defaultColor: gray05,
                                       specialFont: sFont,
                                       specialColor: gray05,
                                       specialBackgroundColor: UIColor.clear)
    }
    
    var noIdealHave: String{
        switch language {
        case EN: return "Ideal Weight" +
            "\n" + "will appear with" +
            "\n" + "diet adjustments"
        default: return "وزن ایدآل" +
            "\n" + "بعد از تنظیم رژیم" +
            "\n" + "قابل مشاهده می باشد"
        }
    }
    
    var ideal: NSMutableAttributedString{
        var string: String{
            switch language {
            case EN: return "Ideal ≈" + "\n" + "Weight"
            default: return "وزن ≈" + "\n" + "ایدآل"
            }
        }
        return mutable("~", string)
    }
    
    var idealKG: String{
        switch language {
        case EN: return "KG"
        default: return "کیلوگرم"
        }
    }
    
    var normalWeight: String{
        let ideal = Float(profile.diet.idealWeight)?.int.string
        switch language {
        case EN: return ideal!.enNumber
        default: return ideal!.faNumber
        }
    }
    
    var hasIdealWeight: Bool { profile.diet.idealWeight != "" }
    
    var isOverWeight: Bool{ Double(updateBody.weight.result)! - Double(normalWeight.enNumber)!>0 }
    
    var overWeight: String{
        let over = (Double(updateBody.weight.result)?.rounded())! - Double(normalWeight.enNumber)!
        let result = String(Int(over)).faNumber.replace(["-": ""])
        switch language {
        case EN: return result.enNumber
        default: return result.faNumber
        }
    }
    
    var over: String{
        switch language {
        case EN: return isOverWeight ? "Over \("\n")Weight" : "Under \("\n")Weight"
        default: return isOverWeight ?
            "اضافه \("\n")وزن"
            : "کمبود \("\n")وزن"
        }
    }
    
    var specialInfo: String{
        switch language {
        case EN: return "  ▾  " + "Special Information" + "  ▾  "
        default: return "  ▾  " + "اطلاعات تخصصی" + "  ▾  "
        }
    }
    
    func mutable(_ sString: String,
                 _ string: String) -> NSMutableAttributedString{
        let sFont = UIFont(Sahel, 28)!
        let font = UIFont(Sahel, 22)!
        return string.mutableString(specialString: sString,
                                    defaultFont: font,
                                    defaultColor: gray06,
                                    specialFont: sFont,
                                    specialColor: skyBlue01,
                                    specialBackgroundColor: UIColor.clear)
    }
}
