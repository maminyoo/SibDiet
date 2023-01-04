//
//  QuestionValues.swift
//  Sibdiet
//
//  Created by Amin on 5/21/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class QuestionValues{
    var subTitle:String{
        switch language {
        case EN: return "Question"
        default: return "سوال از دکتر"
        }
    }
    
    var subTitleFont: UIFont{
        switch language {
        case EN: return UIFont(AvenirNext_Regular, 17)!
        default: return UIFont(Traffic, 18)!
        }
    }
    
    var backButtonTitle: String{
        switch language {
        case EN: return "Back"
        default: return  "بازگشت"
        }
    }
    
    var holder: String{
        switch language {
        case EN: return "Please send your question in\none message"
        default: return "لطفا سوال خود را در قالب یک متن\nارسال کنید"
        }
    }
}
