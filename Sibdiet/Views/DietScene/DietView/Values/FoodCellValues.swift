//
//  FoodCellValues.swift
//  Sibdiet
//
//  Created by Amin on 6/5/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation

struct FoodCellValues{
    
    var weekDays: [String]{
        switch language {
        case EN: return [MON, TUE, WED, THU, FRI, SAT, SUN]
        default: return [SHANBE, YEKSHANBE, DOSHANBE, SESHANBE, CHARSHANBE, PANSHANBE, JOME].reversed
        }
    }
    
    var request: String{
        switch language {
        case EN: return "Request diet"
        default: return "درخواست رژیم"
        }
    }
    
    var description: String{
        switch language {
        case EN: return "Description"
        default: return "توضیحات"
        }
    }
}
