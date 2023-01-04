//
//  DietTableValues.swift
//  Sibdiet
//
//  Created by Amin on 5/27/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import Foundation

struct DietTableValues{
    
    let diet = profile.diet
    
    var goals: String{
        let goals = diet.goals
        if goals.count == 2{
            return goals[0] + "\n" + goals[1]
        }else if goals.count == 3{
            return goals[0] + "\n" + goals[1] + "، " + goals[2]
        }else if goals.count == 4{
            return goals[0] + "، " + goals[1] + "\n" + goals[2] + "، " + goals[3]
        }else if goals.count == 1{
            return goals[0]
        }else if goals.count == 5{
            return goals[0] + "، " + goals[1] + "\n" + goals[2] + "، " + goals[3] + "، " + goals[4]
        }else if goals.count == 6{
            return goals[0] + "، " + goals[1] + "، " + goals[2] + "\n"  + goals[3] + "، " + goals[4] + "، " + goals[5]
        }else if goals.count == 7{
            return goals[0] + "، " + goals[1] + "\n" + goals[2] + "، "  + goals[3] + "، " + goals[4] + "\n" + goals[5] +  "، " + goals[6]
        }else{
            return isFA ? "سالم" : "Healthy"
        }
    }
    
    var dietCount: String{
        let dietCount = profile.dietCount
        switch language {
        case EN: return dietCount.th + " Plan"
        default: return "دوره " + dietCount.persianThString
        }
    }
    
    var period:String{
        let period = diet.period
        switch language {
        case EN: return period.periodString
        default: return period.persianPeriodString
        }
    }
    
    var requestDiet: String{
        switch language {
        case EN: return "Request diet"
        default: return "درخواست رژیم"
        }
    }
}
