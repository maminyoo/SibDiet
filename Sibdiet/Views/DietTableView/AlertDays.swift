//
//  AlertDays.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/13/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class AlertDays: UIView{
    
    var days: Int!
    func days(_ days: Int){
        self.days = days
    }
    
    var have: Bool!
    func have(_ bool: Bool){
        self.have = bool
    }
        
    let values = AlertDaysValues()
    
    //MARK: INIT VIEW
    func initView(){
        setPastTime()
        setSubAlert()
        if isWaiting{
            pasTime.text(values.inWait)
            subAlert.width(self.width)
            subAlert.text(values.time)
            setCircles()
        }
    }
    
    //MARK: CIRCLES
    var circles = Circles()
    func setCircles(){
        circles.frame(10, 5, 25, 25)
        circles.colors([mint02, mint01, mint02, mint01])
        circles.duration(2)
        circles.opacity(0.7)
        circles.initView()
        addSubview(circles)
    }
    
    //MARK: PAS TIME
    var pasTime = UILabel()
    func setPastTime(){
        let day = days != 1 ? days.string + " days" : days.string + " day"
        let string = isEN ? day : days.string.faNumber + " روز"

        pasTime.frame(10, (isRTL ? -4 : -2), width-20, 28)
        pasTime.text(string)
        pasTime.textColor(have ? lime02 : skyBlue01)
        pasTime.font(Sahel, 20)
        pasTime.adjustsFontSizeToFitWidth(true)
        pasTime.cornerRadius(5)
        pasTime.textAlignment(.center)
        addSubview(pasTime)
    }
    
    //MARK: SUB ALERT
    var subAlert = UILabel()
    func setSubAlert(){
        subAlert.frame(0, 20, width, 28)
        subAlert.text(have ? values.has : values.dietIsPassed)
        subAlert.textColor(gray07)
        subAlert.font(Sahel, 16)
        subAlert.textAlignment(.center)
        addSubview(subAlert)
    }
}
