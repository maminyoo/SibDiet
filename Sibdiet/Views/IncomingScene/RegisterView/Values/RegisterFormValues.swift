//
//  RegisterFormValues.swift
//  Sibdiet
//
//  Created by Amin on 3/26/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import Foundation

class RegisterFormValues{

    var mobileTitle: String{
        isEN ? "Mobile" : "شماره همراه"
    }
    var mobileHolder: String{
        isEN ? "0987654321" : "۰۹۱۲۳۴۵۶۷۸۹"
    }
    
    var fnameTitle: String{
        isEN ? "Name" : "نام"
    }
    var fnameHolder: String{
        isEN ? "First name" : "به فارسی"
    }
    
    var lnameTitle: String{
        isEN ? "Family" : "نام خانوادگی"
    }
    var lnameHolder: String{
        isEN ? "Last name" : "به فارسی"
    }
    
    var dateType: String{
        isEN ? "miladi" : "jalali"
    }
    var dayTitle: String{
        isEN ? "Day" : "روز"
    }
    var birthdayTitle: String{
        isEN ? "Birthday" : "تولد"
    }
    var daysLabel:[String]{
        isEN ? ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"] : ["۰۱","۰۲","۰۳","۰۴","۰۵","۰۶","۰۷","۰۸","۰۹","۱۰","۱۱","۱۲","۱۳","۱۴","۱۵","۱۶","۱۷","۱۸","۱۹","۲۰","۲۱","۲۲","۲۳","۲۴","۲۵","۲۶","۲۷","۲۸","۲۹","۳۰","۳۱"]
    }
    
    var monthTitle: String{
        isEN ? "Month" : "ماه"
    }
    var monthsLabel:[String]{
         isEN ?
        ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November","December"] :
    ["فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی","بهمن","اسفند"]
    }
    
    var monthReplaceCharacters: [String: String]{
         isEN  ?
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
             "December":"12"] :
            ["فروردین":"01"
                ,"اردیبهشت":"02"
    ,"تیر":"04"
                ,"مرداد":"05"
                ,"شهریور":"06"
                ,"مهر":"07"
                ,"آبان":"08"
                ,"آذر":"09"
                ,"دی":"10"
                ,"بهمن":"11"
               ,"اسفند":"12"
                ,"فرور10ن":"01"
                ,"ار10بهشت":"02"]
    }
    var yearTitle: String{
        isEN ? "Year" : "سال"
    }
    
    var genderTitle: String{
       isEN ? "Gender" : "جنسیت"
    }
    
    var genderOptions:[String]{
        isEN ? ["Male", "Female"] : ["مذکر", "مونث"]
    }
    
    var maritalTitle: String{
        isEN ? "Marital" : "تاهل"
    }
    
    var maritalOptions:[String]{
        isEN ? ["Single", "Married"] : ["مجرد", "متاهل"]
    }
    
    var bloodTitle: String{
        isEN ? "Blood" : "گروه خونی"
    }
    
    var bloodOptions:[String]{
        isEN ?
            ["A+", "A-", "B+","B-", "O+", "O-", "AB+", "AB-", "Dn't know"] :
            ["A+", "A-", "B+","B-", "O+", "O-", "AB+", "AB-", "نمی دانم"]
    }
    
    var inCorrectMobileTitle: String{
        isEN ? "Number is not correct" : "شماره همراه صحیح نیست"
    }
}
