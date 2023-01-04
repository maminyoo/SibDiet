//
//  FirstViewValues.swift
//  Sibdiet
//
//  Created by Amin on 3/17/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class FirstViewValues{
    
    var backButtonTitle: String{
        isEN ? "Back" : "بازگشت"
    }
    var backButtonFont: UIFont{
        (isEN ? UIFont(GillSans, 16) : UIFont(Samim, 14))!
    }
    var aboutTitle: String{
        isEN ? "ABOUT US" : "درباره ما"
    }
   
    var copyRightTitle: NSAttributedString{
        let string = "تمام حقوق این برنامه متعلق به" + " SibDiet " + "می باشد." 
        let specialString  = "SibDiet"
        
        let font = UIFont(Sahel, 15)
        let specialFont = UIFont(JosefinSans, 23)
        
        let mutableStringFa = string.mutableString(specialString: specialString,
                                                 defaultFont: font!,
                                                 defaultColor: darkGray,
                                                 specialFont: specialFont!,
                                                 specialColor: green01,
                                                 specialBackgroundColor: UIColor.clear)
        
        let stringEn = "All rights reserved by SibDiet ltd."
        
        let fontEn = UIFont(AvenirNext_Regular, 16)
        let specialFontEn = UIFont(JosefinSans, 23)
        
        let mutableStringEn = stringEn.mutableString(specialString: specialString,
                                                   defaultFont: fontEn!,
                                                   defaultColor: darkGray,
                                                   specialFont: specialFontEn!,
                                                   specialColor: green01,
                                                   specialBackgroundColor: UIColor.clear)
        
        return isEN ? mutableStringEn : mutableStringFa

    }
}
