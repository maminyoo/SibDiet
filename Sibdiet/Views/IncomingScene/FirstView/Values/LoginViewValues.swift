//
//  LoginViewValues.swift
//  Sibdiet
//
//  Created by Amin on 3/18/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

struct LoginViewValues{
    
    var mobileGeterTitle: String{
        isEN ? "Mobile No" : "شماره همراه"
    }
    var mobileGeterHolder: String{
        isEN ? "+44 (77) 8866 1234" : inOtherBlud ? "+۴۴ (۷۷) ۸۸۶۶ ۱۲۳۴" : "+۹۸ (۹۱۲) ۳۴۵ ۶۷۸۹"
    }
    var fileNumberTitle: String{
        isEN ? "File No" : "شماره پرونده"
    }
    var fileNumberHolder: String{
        isEN ? "123456" : "۱۲۳۴۵۶"
    }
    var forgetTitle: String{
        isEN ? "Missing file number" : "فراموشی شماره پرونده"
    }
    var mobileError: String{
        isEN ? "This mobile number doesn't exist" : "پرونده ای با این شماره وجود ندارد"
    }
    var fileNumberError: String{
        isEN ? "This file number doesn't exist" : "پرونده ای با این مشخصات وجود ندارد"
    }
    var internetError:String{
        isEN ? CONNECTION_ERROR_EN : CONNECTION_ERROR_FA
    }
    var sendFileNumber: String{
        isEN ? "Your file number was sent" : "شماره پرونده شما ارسال گردید"
    }
    var forgetFont: String{
        isEN ? GillSans_Italic : Traffic
    }
    var registerTitle: String{
           isEN ? "REGISTER" : "ثبت نام"
    }
}
