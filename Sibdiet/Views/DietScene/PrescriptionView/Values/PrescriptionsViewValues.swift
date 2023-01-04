//
//  PrescriptionsViewValues.swift
//  Sibdiet
//
//  Created by Amin on 6/8/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class PrescriptionsViewValues{
    let prescriptions = profile.prescriptions
    
    var baseTitles: [String] {
        switch language {
        case EN: return ["Special advice", "Activities", "Dairies", "Fruits", "Sweets"]
        default: return ["توصیه ویژه", "فعالیت" , "لبنیات" , "میوه" , "شیرینی"]
        }
    }

    var activityAmount: NSMutableAttributedString{
        let amount = NSMutableAttributedString()
        if prescriptions.activityAmount != "0"{
            var amount: String{
                switch language {
                case EN: return prescriptions.activityAmount
                default: return prescriptions.activityAmount.faNumber
                }
            }
            var string: String{
                switch language {
                case EN: return amount + " minutes"
                default: return amount + " دقیقه  "
                }
            }
            return mutable(amount, string, activityColor)
        }else{
            return amount
        }
    }
    
    var dairyAmount: NSMutableAttributedString{
        let amount = NSMutableAttributedString()
        if prescriptions.dairyAmount != "0"{
            var amount: String{
                switch language {
                case EN: return prescriptions.dairyAmount
                default: return prescriptions.dairyAmount.faNumber
                }
            }
            var string: String{
                switch language {
                case EN: return amount + " glass"
                default: return amount + " لیوان  "
                }
            }
            return mutable(amount, string, dairyColor)
        }else{
            return amount
        }
    }
    
    var fruitAmount: NSMutableAttributedString{
        let amount = NSMutableAttributedString()
        if prescriptions.fruitAmount != "0"{
            var amount: String{
                switch language {
                case EN: return prescriptions.fruitAmount
                default: return prescriptions.fruitAmount.faNumber
                }
            }
            var string: String{
                switch language {
                case EN: return amount + " grams"
                default: return amount + " گرم  "
                }
            }
            return mutable(amount, string, fruitColor)
        }else{
            return amount
        }
    }
    
    var sweetenerAmount: NSMutableAttributedString{
        let amount = NSMutableAttributedString()
        if prescriptions.sweetenerAmount != ZERO{
            var amount: String{
                switch language {
                case EN: return prescriptions.sweetenerAmount
                default: return prescriptions.sweetenerAmount.faNumber
                }
            }
            var string: String{
                switch language {
                case EN: return amount + " numbers"
                default: return amount + " عدد  "
                }
            }
            return mutable(amount, string, sweetenerColor)
        }else{
            return amount
        }
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
