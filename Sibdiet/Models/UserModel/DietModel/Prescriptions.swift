//
//  Prescriptions.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/2/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import SwiftyJSON

class Prescriptions{
    let replaceString = ["&nbsp;": "",
                         "&": "",
                         ";": "",
                         "nbsp": "",
                         "-": "، ",
                         ")": ") ",
                         "(مدت برنامه در بالای رژیم درج شده است)": "",
                         "همچنین ازطریق سایت رژیمی کالا(www. rejimikala. com) ویاشماره تماس02166287312خرید میسراست.": "",
                         "zwnj":"",
                         ".": ". ",
                         "کدعددی پکیج ادویه ویژه خود به سامانه 09196636030 ازقیمت وشرایط ارسال ادویه مطلع ودرصورت تایید آنرا بصورت آماده و بهداشتی براساس رژیم غذایی خوددرب منزل تحویل بگیرید،": "",
                         "برای دسترسی راحت ترمیتوانید با ارسال": "",
                         "کد(65)": "",
                         "و در پایان از طریق سایت و یا از طریق روبات و یا از طریق اپلیکیشن ها نیز با ما مرتبط باشید.": "",
                         "اميدورام كه اين دوره رابا موفقيت به پايان ببريدتوجه داشته باشيد شمابايستي اجبارا بعدازاتمام مدت رژيم(مدت رژيم دربالاي صفحه مندرج شده است) رژيم خودرا تغييردهيد.": "",
                         "توجه داشته باشيد شما بايستي اجبارا بعد ازاتمام مدت رژيم (مدت رژيم دربالاي صفحه مندرج شده است) رژيم خود را تغييردهيد براي اين منظورمي توانيد يا بصورت حضوري يا بصورت مشاوره تلفني و يا اينترنتي اقدام نماييد": "",
                         "شمابايستي اجبارابعدازاتمام مدت رژيم(مدت رژيم دربالاي صفحه مندرج شده است)رژيم خودرا بصورت حضوري يا مشاوره تلفني ويااينترنتي تغييردهيد. ": ""]

    var dietTitle: String{
        get{ standard.string(forKey: "DIETTITLEP") ?? String()  }
        set{ standard.set(newValue, forKey: "DIETTITLEP") }
    }
    var specialRecommendation: String{
        get{ standard.string(forKey: "SPECIALRECOMMENDATIONP") ?? String()  }
        set{ standard.set(newValue, forKey: "SPECIALRECOMMENDATIONP") }
    }
    var specialRecommendationCorrection: String{ specialRecommendation.htmlToStrong.replace(replaceString) }
    
    var activityTitle: String{
        get{ standard.string(forKey: "ACTIVITYTITLEP") ?? String() }
        set{ standard.set(newValue, forKey: "ACTIVITYTITLEP") }
    }
    var activityAmount: String{
        get{ standard.string(forKey: "ACTIVITYAMOUTP") ?? String() }
        set{ standard.set(newValue, forKey: "ACTIVITYAMOUTP") }
    }
    var activityDescription: String{
        get{ standard.string(forKey: "ACTIVITYDESCP") ?? String() }
        set{ standard.set(newValue, forKey: "ACTIVITYDESCP") }
    }
    var activityDescriptionCorrection: String{ activityDescription.htmlToStrong.replace(replaceString) }
    
    var dairyTitle: String{
        get{ standard.string(forKey: "DAIRYTITLEP") ?? String() }
        set{ standard.set(newValue, forKey: "DAIRYTITLEP") }
    }
    var dairyAmount: String{
        get{ standard.string(forKey: "DAIRYAMOUNTP") ?? String() }
        set{ standard.set(newValue, forKey: "DAIRYAMOUNTP") }
    }
    var dairyDescription: String{
        get{ standard.string(forKey: "DAIRYDESCP") ?? String() }
        set{ standard.set(newValue, forKey: "DAIRYDESCP") }
    }
    var dairyDescriptionCorrection: String{ dairyDescription.htmlToStrong.replace(replaceString) }
    
    var fruitTitle: String{
        get{ standard.string(forKey: "FRUITTITLEP") ?? String() }
        set{ standard.set(newValue, forKey: "FRUITTITLEP") }
    }
    var fruitAmount: String{
        get{ standard.string(forKey: "FRUITAMOUNTP") ?? String() }
        set{ standard.set(newValue, forKey: "FRUITAMOUNTP") }
    }
    var fruitDescription: String{
        get{ standard.string(forKey: "FRUITDESCP") ?? String() }
        set{ standard.set(newValue, forKey: "FRUITDESCP") }
    }
    var fruitDescriptionCorrection: String{ fruitDescription.htmlToStrong.replace(replaceString) }
    
    var sweetenerTitle: String{
        get{ standard.string(forKey: "SWEETENERTITLEP") ?? String() }
        set{ standard.set(newValue, forKey: "SWEETENERTITLEP") }
    }
    var sweetenerAmount: String{
        get{ standard.string(forKey: "SWEETENERAMOUNTP") ?? String() }
        set{ standard.set(newValue, forKey: "SWEETENERAMOUNTP") }
    }
    var sweetenerDescription: String{
        get{ standard.string(forKey: "SWEETENERDESCP") ?? String() }
        set{ standard.set(newValue, forKey: "SWEETENERDESCP") }
    }
    var sweetenerDescriptionCorrection: String{ sweetenerDescription.htmlToStrong.replace(replaceString) }
    
    func setPrescriptionsData(json: JSON){
        reset()
        dietTitle             = json[DIET][DIET_TITLE].stringValue
        specialRecommendation = json[DIET][SPECIAL_RECOMENDATION].stringValue
        activityTitle         = json[DIET][ACTIVITY_TITLE].stringValue
        activityAmount        = json[DIET][ACTIVITY_AMOUNT].stringValue
        activityDescription   = json[DIET][ACTIVITY_DESCRIPTION].stringValue
        sweetenerTitle        = json[DIET][SWEETENER_TITLE].stringValue
        sweetenerAmount       = json[DIET][SWEETENER_AMOUNT].stringValue
        sweetenerDescription  = json[DIET][SWEETENER_DESCRIPTION].stringValue
        fruitTitle            = json[DIET][FRUIT_TITLE].stringValue
        fruitAmount           = json[DIET][FRUIT_AMOUNT].stringValue
        fruitDescription      = json[DIET][FRUIT_DESCRIPTION].stringValue
        dairyTitle            = json[DIET][DAIRY_TITLE].stringValue
        dairyAmount           = json[DIET][DIARY_AMOUNT].stringValue
        dairyDescription      = json[DIET][DIARY_DESCRIPTION].stringValue
    }
    
    func reset(){
        dietTitle             =  String()
        specialRecommendation =  String()
        activityTitle         =  String()
        activityAmount        =  String()
        activityDescription   =  String()
        sweetenerTitle        =  String()
        sweetenerAmount       =  String()
        sweetenerDescription  =  String()
        fruitTitle            =  String()
        fruitAmount           =  String()
        fruitDescription      =  String()
        dairyTitle            =  String()
        dairyAmount           =  String()
        dairyDescription      =  String()
    }
}
