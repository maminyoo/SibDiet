//
//  SpecialInfoViewValues.swift
//  Sibdiet
//
//  Created by Amin on 5/13/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

struct SpecialInfoViewValues{
    
    var subTitle: String{
        switch language {
        case EN: return "Specialized Information"
        default: return "اطلاعات تخصصی"
        }
    }
    
    var subTitleFont: UIFont{
        switch language {
        case EN: return UIFont(AvenirNext_Regular, 17)!
        default: return UIFont(Traffic, 18)!
        }
    }
    
    var backButtonTitle: String{
        switch language {
        case EN: return "Back"
        default: return  "بازگشت"
        }
    }
    
    var newButtonTitle: String{
        switch language {
        case EN: return "New"
        default: return  "جدید"
        }
    }
    
    var bottomTitle: String{
        let p = extraConnection.p != "" ? extraConnection.p : "15 €"
        let t = extraConnection.t != "" ? extraConnection.t : "۴۵ هزار تومان"
        if isReviewer{
            return "Payment" + "\n" + "\(p)"
        }else{
            return "پرداخت" + "\n" + "\(t)"
        }
    }
    
    var backWebTitle: String{
        switch language {
        case EN: return "Cancel"
        default: return  "لغو پرداخت"
        }
    }
    
    var cancelPayment: String{
        switch language {
        case EN: return "Payment Canceled"
        default: return  "پرداخت لغو گردید."
        }
    }
    
    var trackingCode: NSMutableAttributedString{
        var code: String{
            switch language {
            case EN: return specialInformation.trackingCode
            default: return specialInformation.trackingCode.faNumber
            }
        }
        var fullString: String{
            let name = profile.fullName
            let fileNumber = profile.fileNumber

            switch language {
            case EN: return name + "\n" +  fileNumber + "\n" + "Payment completed successfully"
                + "\n" + "Tracking Code : " + code
            default: return name + "\n" +  fileNumber.faNumber + "\n" + "پرداخت شما با موفقیت انجام گردید"
                + "\n" + "کد رهگیری : " + code
            }
        }
        let font = UIFont(Sahel, 20)
        let specialFont = UIFont(Sahel, 24)
        return fullString.mutableString(specialString: code,
                                        defaultFont: font!,
                                        defaultColor: darkGray,
                                        specialFont: specialFont!,
                                        specialColor: green,
                                        specialBackgroundColor: .clear)
    }
    
    var sibDietTitle: String{ SibDiet }    
    var sibDietFont: String{ JosefinSans }
}
