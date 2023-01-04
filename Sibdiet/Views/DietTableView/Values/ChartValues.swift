//
//  ChartValues.swift
//  Sibdiet
//
//  Created by Amin on 5/27/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation

struct ChartValues{
    
    var weight: String{
        switch language {
        case EN: return "Weight"
        default: return "وزن"
        }
    }
    
    var ideal: String{
        switch language {
        case EN: return "Ideal"
        default: return "ایدآل"
        }
    }
    
    var idealInt: String{
        let ideal = profile.diet.idealWeight.substring(to: 1)
        switch language {
        case EN: return ideal.enNumber
        default: return ideal.faNumber
        }
    }
    
    var over : String{
        let overWeight = String(profile.diet.overWeight).replace(["-": ""])
        switch language {
        case EN: return overWeight.enNumber
        default: return overWeight.faNumber
        }
    }
    
    var stateWeight: String{
        let isOver = profile.diet.overWeight>0
        switch language{
        case EN : return isOver ? "Over" : "Under"
        default : return isOver ? "اضافه" : "کمبود"
        }
    }
    
    let overWeightString = String(profile.diet.overWeight).replace(["-": ""])

    var overWeight: String{
        switch language{
        case EN : return overWeightString
        default : return overWeightString.faNumber
        }
    }
}
