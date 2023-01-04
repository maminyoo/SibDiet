//
//  ProfileViewValues.swift
//  Sibdiet
//
//  Created by Amin Sadeghian on 4/22/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class ProfileViewValues{
    
    var subTitle: String{
        let fileNumber = profile.fileNumber
        return isEN ?
            "File Number : " + fileNumber :  "پرونده : " + fileNumber.faNumber
    }
    var subTitleFont: UIFont{
        switch language {
        case EN: return UIFont(AvenirNext_Regular, 17)!
        default: return UIFont(Traffic, 18)!
        }
    }
    
    var supportButtonTitle: String{
        isEN ? "Support" : "پشتیبانی"
    }
    
    var backButtonTitle: String{
        switch language {
        case EN: return "Back"
        default: return "بازگشت"
        }
    }
    
    var versionTitle: NSAttributedString{
        let str = "ver "
        let ver = str + appVersion.ver
        let font = UIFont(Sahel, 17)!
        return ver.mutableString(specialString: str,
                                 defaultFont: font,
                                 defaultColor: green,
                                 specialFont: font,
                                 specialColor: gray06,
                                 specialBackgroundColor: gray01)
    }
    
    var bottomTitle: String{
        if isWaiting{
            return isEN ?
                "Waiting for diet adjustment" + "\n" + "This may take several hours" :
            "انتظار برای دریافت رژیم"  + "\n" + "این زمان ممکن است تا «چند ساعت» به طول بیانجامد"
        }else{
            return isEN ?
                "  ▾  "  + "Request diet" + "  ▾  "
                :  "  ▾  "  + "درخواست رژیم" + "  ▾  "
        }
    }
    
    var doYouWantToLogOutTitle: String{
        isEN ?
            "Do you want to logout?" :
    "آیا می خواهید از برنامه رژیم خود خارج شوید؟"
    }
    
    var yesTitle: String{
        isEN ? "Yes" : "بلی"
    }
    
    var noTitle: String{
        isEN ? "No" : "خیر"
    }
    
    var logoutButtonTitle: String{
        isEN ? "Logout" : "خروج"
    }
}
