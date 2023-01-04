//
//  AboutViewValues.swift
//  Sibdiet
//
//  Created by Amin on 3/19/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class AboutViewValues{
    
    var nameTitle: String{ "SibDiet" }
    var nameFont: UIFont{ UIFont(JosefinSans, 28)! }
    var subTitle: String{ isEN ? "About Us" : "درباره ما" }
    
    var subTitleFont: UIFont{ (isEN ? UIFont(AvenirNext_Regular, 17) : UIFont(Traffic, 18))! }
    var subTitleCFStringFont: CFString{ isEN ? AvenirNext_Regular as CFString: Traffic as CFString }
    
    var backButtonTitle: String{
        isEN ? "Back" : "بازگشت"
    }
    var shareButtonTitle: String{
        isEN ? "Share" : "اشتراک"
    }
    
    var backButtonFont: UIFont{
        (isEN ? UIFont(GillSans, 16) : UIFont(Samim, 14))!
    }
    var drTitle: String{
        isEN ? "Hamid Reza Sh.Roshandel" : "حميد رضا روشندل"
    }
    var drTitleFont: UIFont{
        (isEN ? UIFont(HelveticaNeue_Medium, 18) : UIFont(Traffic, 20))!
    }
    var drInfos: String{
//        isEN ?
            "PhD at Holistic Health" + "\n" + "Professor of Nutrition and" + "\n" + "Regimen in Alternative Medicine"
//            :  "متخصص تغذیه"
    }
    var drInfosFont: UIFont{ UIFont(Sahel, 16)! }
    
    var description: (NSAttributedString, CGFloat){
        let descriptions = "سیب دایت ارائه کننده رژیم غذایی (٢١ روزه) براساس مزاج و متابولیسم با عملكرد درمانی به کمک تلفيق علوم تغذيه نوين و سنتی، از شروع ماه هفتم نوزادی تا كهنسالی، با بیش از ۷۰۰ نوع رژیم برای حالت ها و بیماری ها مختلف"
        let fiveHundredDiet = "۷۰۰ نوع رژیم"
        
        let descriptionsEn = "SibDiet is a diet app which provides over 700 types of diet plans based on body temperament and metabolism, through the combination of modern and traditional nutrition science with therapeutic effects for various diseases and conditions. The diet plans are suitable for all from seven-month-old infants to elderlies"
        let fiveHundredDietEn = "700 types of diet"
        
        let font = UIFont(Samim, 16)
        let specialFont = UIFont(Samim, 17)
        let fontsize: CGFloat = is5 ? 14 : 15
        let fontEn = UIFont(AppleSDGothicNeo_Light, fontsize)
        let specialFontEn = UIFont(AppleSDGothicNeo_Bold, 16)
        
        let string = isEN ? descriptionsEn : descriptions
        let stringSp = isEN ? fiveHundredDietEn : fiveHundredDiet
        let fontOrigin = isEN ? fontEn : font
        let fontSpecial = isEN ? specialFontEn : specialFont
        
        let mutableString = string.mutableString(specialString: stringSp,
                                                 defaultFont: fontOrigin!,
                                                 defaultColor: gray07,
                                                 specialFont: fontSpecial!,
                                                 specialColor: green,
                                                 specialBackgroundColor: UIColor.clear)
        let t = UITextView()
        t.frame(0, 0, WIDTH-40, 39)
        t.font(fontOrigin!)
        t.text(string)
        return (mutableString, isEN ? t.paragraphHeight-5 : t.paragraphHeight)
    }
    
    var address: NSAttributedString{
        let addressString = "تهران، بلوار اشرفی اصفهانی، بلوار مرزداران نبش خیابان حضرت ابوالفضل (ع)، پلاک ٢، واحد ٢ \n٥٠ الی ٠٢١٤٤٢٥٤٧٤٧"
        let phone = "٥٠ الی ٠٢١٤٤٢٥٤٧٤٧"
        let fontAddress = UIFont(Yekan, 15)!
        let fontPhone = UIFont(Yekan, 16)!
        let addressStringEn = "Berkeley Square House, Berkeley  Square, Greater London, United Kingdom W1J 6BD \n+44 (20) 7078 3956"
        let phoneEn = "+44 (20) 7078 3956"
        let fontAddressEn = UIFont(AppleSDGothicNeo_Regular, 12)!
        let fontPhoneEn = UIFont(AppleSDGothicNeo_Light, 16)!
        
        let string = inUnvar ? addressStringEn : addressString
        let stringSp = inUnvar ? phoneEn : phone
        let fontOrgin = inUnvar ? fontAddressEn : fontAddress
        let fontSpecial = inUnvar ? fontPhoneEn : fontPhone
        
        let mutableString = string.mutableString(specialString: stringSp,
                                                 defaultFont: fontOrgin,
                                                 defaultColor: gray07,
                                                 specialFont: fontSpecial,
                                                 specialColor: phoneColor,
                                                 specialBackgroundColor: UIColor.clear)
        return mutableString
    }
    
    var license: String{
        let title = "دارای مجوز مشاوره تغذيه از سازمان نظام پزشكی"
        let titleEn = "Authorized in Nutrition Expert Advisor office from the Medical Organization"
        return inUnvar ? titleEn : title
    }
    var licenseFont: UIFont{
        return (inUnvar  ? UIFont(Palatino_Roman, 14) : UIFont(Roya, 15))!
    }
    
    var create: String{
        return isEN ? "DESIGN & CODE" : "طراحی و ساخت"
    }
    var createFont: CFString{
        return isEN ? AvenirNext_Regular as CFString : Traffic as CFString
    }
    var dietList:[String]{
        let listFa = ["رژيم دوران بارداری",
                  "رژیم دوران شیردهی"
            ,"رژیم دوران نوزادی و نوپایی"
            ,"رژیم چاقی"
            ,"رژیم لاغری"
            ,"رژیم چاقی موضعی"
            ,"رژیم دیابت"
            ,"رژیم سردرد"
            ,"رژیم هنرمندان پرکار"
            ,"رژیم سردردهای مزمن"
            ,"رژیم غذایی ماه مبارک رمضان"
            ,"رژیم مشکلات کلیوی"
            ,"رژیم های تعادل پوست و مو"
            ,"رژیم انتخاب جنسيت جنين قبل بارداری"
            ,"رژیم های بیماران سرطانی"
            ,"رژیم های بیماران قلبی و عروقی"
            ,"رژیم های دوران سالمندی"
            ,"رژیم دوره های اضطراب و امتحانات"
            ,"رژیم آرتروز و پوکی استخوان"
            ,"رژیم بیماری ام اس"
            ,"رژیم مشکلات گوارشی"
            ,"رژیم کنترل اسید اوریک بالا"
            ,"رژیم گیاه خواران"
            ,"رژیم های غذایی ورزشکاران"
            ,"و…"]
        let listEn = [
            "Athletes diets",
            "Anxiety and Exams periods diets",
            "Arthritis and osteoporosis diets",
            "Cancer Patients diets",
            "Cardiovascular diseases diets",
            "Diabetes diet",
            "Digestive problems diets",
            "Elderlies diets",
            "Holy Ramadan diet",
            "High uric acid control diet",
            "Infants, Kids, Teens diets",
            "Lactation diet",
            "Migraine diet",
            "Metabolic disorders diet",
            "MS diseases diets",
            "Obesity diet",
            "Pregnancy diet",
            "Prolific artists diets",
            "Skin and hair balance diets",
            "Slimming diet",
            "Topical obesity diet",
            "Terrible headaches diet",
            "The diet of kidney problems",
            "Vegetarian diet",
            "And, etc."
        ]
        return isEN ? listEn : listFa
    }
}
