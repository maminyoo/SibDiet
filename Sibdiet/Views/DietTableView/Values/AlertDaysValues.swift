//
//  AlertDaysValues.swift
//  Sibdiet
//
//  Created by Amin on 5/27/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation

struct AlertDaysValues{
    
    var has: String{
        switch language {
        case EN: return "of your diet left."
        default: return  "از زمان رژیم شما باقی مانده است."
        }
    }
    var dietIsPassed: String{
        switch language {
        case EN: return "of your diet have passed."
        default: return  "از زمان رژیم شما میگذرد."
        }
    }
    
    var inWait: String{
        switch language {
        case EN: return "Waiting for new diet adjustment"
        default: return  "در حال انتظار برای دریافت رژیم جدید"
        }
    }
    
    var time: String{
        switch language {
        case EN: return "It may take several hours"
        default: return "این زمان ممکن است تا «چند ساعت» به طول بیانجامد"
        }
    }
}
