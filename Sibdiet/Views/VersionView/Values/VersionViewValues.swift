//
//  VersionViewValues.swift
//  Sibdiet
//
//  Created by Amin on 5/22/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit

class VersionViewValues{
   
    var cancel:String{
        switch language {
        case EN: return "Cancel"
        default: return "لغو"
        }
    }
    
    var title:NSMutableAttributedString{
        var string: String{
            switch language {
            case EN: return "New version"
            default: return "نسخه جدید"
            }
        }
        let sp = "SibDiet"
        let font = UIFont(Sahel, 18)!
        let specialFont = UIFont(Sahel_Bold, 22)!
        return string.mutableString(specialString: sp,
                                                 defaultFont: font,
                                                 defaultColor: gray07,
                                                 specialFont: specialFont,
                                                 specialColor: green,
                                                 specialBackgroundColor: UIColor.clear)
    }
    
    var update: String{
        switch language {
        case EN: return "Get new version"
        default: return "دریافت نسخه جدید"

        }
    }
    
    var version: NSAttributedString{
        let str = "ver "
        let ver = "ver " + appVersion.newVersion
        let font = UIFont(Sahel, 17)!
        return ver.mutableString(specialString: str,
                                 defaultFont: font,
                                 defaultColor: green,
                                 specialFont: font,
                                 specialColor: gray06,
                                 specialBackgroundColor: gray01)
    }
}
