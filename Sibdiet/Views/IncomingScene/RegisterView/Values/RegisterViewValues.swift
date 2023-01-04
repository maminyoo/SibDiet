//
//  RegisterViewValues.swift
//  Sibdiet
//
//  Created by Amin Sadeghian on 3/24/19.
//  Copyright © 2019 aminsadeghian. All rights reserved.
//

import UIKit

class RegisterViewValues{
   

    var nameTitle: String{ SibDiet }
//    var nameFont: UIFont{
//         UIFont(JosefinSans, 28)!
//    }
    
    var subTitle: String{
        isEN ? "Resigter" : "ثبت نام"
    }
    var subTitleFont: UIFont{
        (isEN ? UIFont(AvenirNext_Regular, 17) : UIFont(Traffic, 18))!
    }
    
    var backButtonTitle: String{
        isEN ? "Back" : "بازگشت"
    }
    
    var newButtonTitle: String{
        switch language {
        case EN: return "New"
        default: return  "جدید"
        }
    }
    
    var fileNumberTitle: String{
        isEN ? "File Nu" : "شماره پرونده"
    }
    
    var sendSmsText: NSAttributedString{
        let mobile = isEN ?
            register.mobile : register.mobileResult.faNumber
        let message = isEN ?
           "File number sent to" + "\n" + mobile :
            "شماره پرونده به " + mobile + "\n" + "ارسال شد."
        let font = UIFont(Sahel, 18)
        let specialFont = UIFont(Sahel, 22)
        let mutableString = message.mutableString(specialString: mobile,
                                                  defaultFont: font!,
                                                  defaultColor: gray07,
                                                  specialFont: specialFont!,
                                                  specialColor: skyBlue01,
                                                  specialBackgroundColor: UIColor.clear)
        
        return mutableString
    }
}
