//
//  ProfileFormValues.swift
//  Sibdiet
//
//  Created by Amin Sadeghian  on 4/22/19.
//  Copyright © 2019 maminyoo All rights reserved.
//

import Foundation

struct ProfileFormValues{
    
    var mobileTitle: String{
        isEN ? "Mobile" : "شماره همراه"
    }
    
    var mobileValue: String{
        isEN ?
            updateProfile.mobilePattern.enNumber :
            updateProfile.mobilePattern.faNumber
    }
    
    var emailTitle: String{
        isEN ? "Email" : "ایمیل"
    }
    
    var birthdayTitle: String{
        isEN ? "Birthday" : "تولد"
    }
    
    var dateType: String{
        isEN ? "miladi" : "jalali"
    }
    
    var daysLabel:[String]{
        isEN ? ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"] : ["۰۱","۰۲","۰۳","۰۴","۰۵","۰۶","۰۷","۰۸","۰۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰","۳۱"]
    }
    
    var monthsLabel:[String]{
        isEN ?
            ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November","December"] : ["فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی","بهمن","اسفند"]
    }
    
    var monthReplaceCharacters: [String: String]{
        isEN ?
            ["January":"01",
             "February":"02",
             "March":"03",
             "April":"04",
             "May":"05",
             "June":"06",
             "July":"07",
             "August":"08",
             "September":"09",
             "October":"10",
             "November":"11",
             "December":"12"] : ["فرور10ن":"01","ار10بهشت":"02","خرداد":"03","تیر":"04","مرداد":"05","شهریور":"06","مهر":"07","آبان":"08","آذر":"09","دی":"10","بهمن":"11","اسفند":"12","اردیبهشت":"02","فروردین":"01"]
    }
    
    var genderTitle: String{
        isEN ? "Gender" : "جنسیت"
    }
    var gender: String{
        let g = updateProfile.genderResult
        switch language {
        case EN: return g == "MALE" ? "Male" : "Female"
        default: return g == "MALE" ? "مذکر" : "مونث"
        }
    }
    var genderOptions:[String]{
        isEN ? ["Male", "Female"] : ["مذکر", "مونث"]
    }
    
    var maritalTitle: String{
        isEN ? "Marital" : "تاهل"
    }
    var marital: String{
        let g = updateProfile.maritalResult
        switch language {
        case EN:
            return g == "MARRIED" ? "Married" : "Single"
        default:
            return g == "MARRIED" ? "متاهل" : "مجرد"
        }
    }
    var maritalOptions:[String]{
        isEN ? ["Single", "Married"] : ["مجرد", "متاهل"]
    }
    
    var bloodTitle: String{
        isEN ? "Blood" : "گروه خونی"
    }
    var blood: String{
        let b = updateProfile.bloodResult
        switch language {
        case EN:
            return b == "NOT_KNOW" ? "Dn't know" : b
        default:
            return b == "NOT_KNOW" ? "نمی دانم" : b
        }
    }
    var bloodOptions:[String]{
        isEN ?
            ["A+", "A-", "B+","B-", "O+", "O-", "AB+", "AB-", "Dn't know"] :
            ["A+", "A-", "B+","B-", "O+", "O-", "AB+", "AB-", "نمی دانم"]
    }    
    
    var countryTitle: String{
        isEN ? "Country" : "کشور"
    }
    
    var countryCorrection: String{
        let country = updateProfile.country
        var result = ""
        switch country {
        case "US", "AG", "AI", "AS", "BB", "BM", "BS",
             "DM", "DO", "GD", "GU", "JM", "KN", "KY",
             "LC", "MP", "MS", "PR", "SX", "TC", "TT",
             "VC", "VG", "VI", "UM": result = isEN ? "United State" : "آمریکا"
        case "AT": result = isEN ? "Austria" : "اتریش"
        case "AM": result = isEN ? "Armenia" : "ارمنستان"
        case "UZ": result = isEN ? "Uzbekistan" : "ازبکستان"
        case "ES": result = isEN ? "Spain" : "اسپانیا"
        case "AU": result = isEN ? "Australia" : "استرالیا"
        case "AF": result = isEN ? "Afghanistan" : "افغانستان"
        case "AE": result = isEN ? "Emirates" : "امارات"
        case "ID": result = isEN ? "Indonesia" : "اندونزی"
        case "GB": result = isEN ? "England" : "انگلستان"
        case "UA": result = isEN ? "Ukraine" : "اوکراین"
        case "IT": result = isEN ? "Italy" : "ایتالیا"
        case "IR": result = isEN ? "Iran" : "ایران"
        case "IE": result = isEN ? "Ireland" : "ایرلند"
        case "IS": result = isEN ? "Iceland" : "ایسلند"
        case "AZ": result = isEN ? "Azerbaijan" : "آذربایجان"
        case "AR": result = isEN ? "Argentina" : "آرژانتین"
        case "AL": result = isEN ? "Albania" : "آلبانی"
        case "DE": result = isEN ? "Germany" : "آلمان"
        case "BH": result = isEN ? "Bahrain" : "بحرین"
        case "BR": result = isEN ? "Brazil" : "برزیل"
        case "BE": result = isEN ? "Belgium" : "بلژیک"
        case "PK": result = isEN ? "Pakistan" : "پاکستان"
        case "TJ": result = isEN ? "Tajikistan" : "تاجیکستان"
        case "TH": result = isEN ? "Thailand" : "تایلند"
        case "TW": result = isEN ? "Taiwan" : "تایوان"
        case "TM": result = isEN ? "Turkmenistan" : "ترکمنستان"
        case "SY": result = isEN ? "Syria" : "سوریه"
        case "KR": result = isEN ? "South Korea" : "کره"
        case "CN": result = isEN ? "China" : "چین"
        case "DK": result = isEN ? "Denmark" : "دانمارک"
        case "RO": result = isEN ? "Romania" : "رومانی"
        case "JP": result = isEN ? "Japan" : "ژاپن"
        case "PS": result = isEN ? "Palestine" : "فلسطین"
        case "SG": result = isEN ? "Singapore" : "سنگاپور"
        case "SE": result = isEN ? "Sweden" : "سوئد"
        case "CH": result = isEN ? "Swiss" : "سوئیس"
        case "IQ": result = isEN ? "Iraq" : "عراق"
        case "SA": result = isEN ? "Saudi Arabia" : "عربستان"
        case "OM": result = isEN ? "Oman" : "عمان"
        case "FR": result = isEN ? "France" : "فرانسه"
        case "FI": result = isEN ? "Finland" : "فنلاند"
        case "PH": result = isEN ? "Philippines" : "فیلیپین"
        case "CY": result = isEN ? "Cyprus" : "قبرس"
        case "KG": result = isEN ? "Kyrgyzstan" : "قرقیزستان"
        case "KZ": result = isEN ? "Kazakhstan" : "قزاقستان"
        case "QA": result = isEN ? "Qatar" : "قطر"
        case "CA": result = isEN ? "Canada" : "کانادا"
        case "PT": result = isEN ? "Portugal" : "پرتغال"
        case "KW": result = isEN ? "Kuwait" : "کویت"
        case "GE": result = isEN ? "Georgia" : "گرجستان"
        case "GT": result = isEN ? "Guatemala" : "گواتمالا"
        case "LB": result = isEN ? "Lebanon" : "لبنان"
        case "PL": result = isEN ? "Poland" : "لهستان"
        case "MY": result = isEN ? "Malaysia" : "مالزی"
        case "HU": result = isEN ? "Hungary" : "مجارستان"
        case "EG": result = isEN ? "Egypt" : "مصر"
        case "MX": result = isEN ? "Mexico" : "مکزیک"
        case "NO": result = isEN ? "Norway" : "نروژ"
        case "NZ": result = isEN ? "New Zealand" : "نیوزلند"
        case "NL": result = isEN ? "Netherlands" : "هلند"
        case "IN": result = isEN ? "India" : "هندوستان"
        case "HK": result = isEN ? "Hong Kong" : "هنگ کنگ"
        case "YE": result = isEN ? "Yemen" : "یمن"
        case "GR": result = isEN ? "Greece" : "یونان"
        case "TR": result = isEN ? "Turkey" : "ترکیه"
        case "EU": result = isEN ? "Others" : "سایر"
        default: return "The United State"
        }
        return result
    }
    
    var cityTitle: String{
        isEN ? "City" : "شهر"
    }
    
    var homePhoneTitle: String{
        isEN ? "Home No" : "تلفن ثابت"
    }
    var homePhone: String{
        switch language {
        case EN: return updateProfile.homePhone.enNumber
        default: return updateProfile.homePhone.faNumber
        }
    }
    
    var addressTitle: String{
        isEN ? "Address" : "آدرس"
    }
}
