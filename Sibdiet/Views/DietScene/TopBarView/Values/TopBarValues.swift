//
//  TopBarValues.swift
//  Sibdiet
//
//  Created by Amin on 5/20/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit

class TopBarValues{
    var week:[String]{
        switch language {
        case EN: return [MON, THU, WED, THU, FRI, SAT, SUN]
        default: return [SHANBE, YEKSHANBE, DOSHANBE, SESHANBE, CHARSHANBE, PANSHANBE, JOME]
        }
    }
    
    var profileTitle: String{
        switch language {
        case EN: return "Profile"
        default: return "شخصی"
        }
    }
    
    var new: String{
        switch language {
        case EN: return "New Prs"
        default: return "فرد جدید"
        }
    }
    
    var subTitleFont: UIFont{
        switch language {
        case EN: return UIFont(AvenirNext_Regular, 17)!
        default: return UIFont(Traffic, 18)!
        }
    }
    
    var diet: String{
        switch language {
        case EN: return "Diet"
        default: return "رژیم"
        }
    }
    
    var priscription: String{
        switch language {
        case EN: return "Recipe"
        default: return "تجویزات"
        }
    }
    
    var supplements: String{
        switch language {
        case EN: return "Supplements"
        default: return "مکمل ها"
        }
    }
}
