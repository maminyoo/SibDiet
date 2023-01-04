//
//  BottomBarValues.swift
//  Sibdiet
//
//  Created by Amin on 5/20/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation

struct BottomBarValues{
   var question: String{
        switch language {
        case EN: return "Ask"
        default: return "سوال"
        }
    }
    
    var answer: String{
        switch language {
        case EN: return "Answer"
        default: return "جواب"
        }
    }
    var prescription:String{
        switch language {
        case EN: return "Recipe"
        default: return "تجویزات"
        }
    }
    
    var diet: String{
        switch language {
        case EN: return "Diet"
        default: return "رژیم"
        }
    }
    
    var supplements: String{
        switch language {
        case EN: return "Supp"
        default: return "مکمل ها"
        }
    }
    
    var family: String{
        switch language {
        case EN: return "Family"
        default: return "خانواده"
        }
    }
}
