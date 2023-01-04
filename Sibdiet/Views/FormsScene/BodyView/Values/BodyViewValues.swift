//
//  BodyViewV2Values.swift
//  Sibdiet
//
//  Created by Me on 10/14/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

struct BodyViewValues{
    var subTitle: String{
        switch language {
        case EN: return "Body Information"
        default: return "مشخصات بدنی"
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
        switch language {
        case EN: return "  ▾  " + "General Information" + "  ▾  "
        default: return "  ▾  " + "اطلاعات عمومی" + "  ▾  "
        }
    }
    
    var help: String{
        switch language {
        case EN: return "Numbers can be choose & moved!"
        default: return "اعداد قابل انتخاب و جابجایی هستند!"
        }
    }
}
