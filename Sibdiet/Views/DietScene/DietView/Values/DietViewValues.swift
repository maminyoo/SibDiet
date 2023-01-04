//
//  DietViewValues.swift
//  Sibdiet
//
//  Created by Amin on 5/30/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class DietViewValues{
    
    let diet = profile.diet

    var meals: [String]{
        switch language {
        case EN:
            var meals = [String]()
            meals.append(BREAKFAST)
            if diet.hasMorningSnack { meals.append("Morning") }
            meals.append(LUNCH)
            if diet.hasEveningSnack { meals.append("Evening") }
            meals.append(DINNER)
            return meals
        default:
            var meals = [String]()
            meals.append("صبحانه")
            if diet.hasMorningSnack { meals.append("میان وعده") }
            meals.append("ناهار")
            if diet.hasEveningSnack { meals.append("عصرانه") }
            meals.append("شام")
            return meals
        }
    }
    
    var beforeYesterday: String{
        return "پریروز"
    }
    var yesterday: String{
        switch language {
        case EN: return "Yesterday"
        default: return "دیروز"
        }
    }
    var today: String{
        switch language {
        case EN: return "Today"
        default: return "امروز"
        }
    }
    var tomorrow: String{
        switch language {
        case EN: return "Tomorrow"
        default: return "فردا"
        }
    }
    var afterTomorrow: String{
       return "پسفردا"
    }
    
    var breakfastBread: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.breakfastBread
            default: return diet.breakfastBread.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Bread " + amount + " gram"
            default: return " نان " + amount + " گرم  "
            }
        }
        return mutable(amount, string, breakfastColor)
    }
    
    var morningSnackBread: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.breakfastBread
            default: return diet.breakfastBread.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Bread " + amount + " gram"
            default: return " نان " + amount + " گرم  "
            }
        }
        return mutable(amount, string, morningSnackColor)
    }
    
    var eveningBread: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.breakfastBread
            default: return diet.breakfastBread.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Bread " + amount + " gram"
            default: return "نان " + amount + " گرم"
            }
        }
        return mutable(amount, string, eveningSnackColor)

    }
    
    var lunchBread: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.lunchBread
            default: return diet.lunchBread.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Bread " + amount + " gram"
            default: return " نان " + amount + " گرم  "
            }
        }
        return mutable(amount, string, turboColor)
    }
    
    var lunchRice: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.lunchRice
            default: return diet.lunchRice.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Rice " + amount + " spoons"
            default: return " برنج " + amount + " قاشق "
            }
        }
        return mutable(amount, string, turboColor)
    }
    
    var lunchMacaroni: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return String(Int(diet.lunchRice)!*20)
            default: return String(Int(diet.lunchRice)!*20).faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return amount + " gram"
            default: return  amount + " گرم  "
            }
        }
        return mutable(amount, string, turboColor)
    }
    
    var dinnerBread: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.dinnerBread
            default: return diet.dinnerBread.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Bread " + amount + " gram"
            default: return " نان " + amount + " گرم  "
            }
        }
        return mutable(amount, string, dinnerColor)

    }
    
    var dinnerRice: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return diet.dinnerRice
            default: return diet.dinnerRice.faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return "Rice " + amount + " spoons"
            default: return " برنج " + amount + " قاشق "
            }
        }
        return mutable(amount, string, dinnerColor)
    }
    
    var dinnerMacaroni: NSMutableAttributedString{
        var amount: String{
            switch language {
            case EN: return String(Int(diet.dinnerRice)!*20)
            default: return String(Int(diet.dinnerRice)!*20).faNumber
            }
        }
        var string: String{
            switch language {
            case EN: return amount + " gram"
            default: return  amount + " گرم  "
            }
        }
        return mutable(amount, string, dinnerColor)
    }
    
    func mutable(_ sString: String,
                 _ string: String,
                 _ color: UIColor) -> NSMutableAttributedString{
        let sFont = UIFont(Gandom, 22)!
        let font = UIFont(Sahel, 17)!
        return string.mutableString(specialString: sString,
                                    defaultFont: font,
                                    defaultColor: gray07,
                                    specialFont: sFont,
                                    specialColor: color,
                                    specialBackgroundColor: UIColor.clear)
    }
}
