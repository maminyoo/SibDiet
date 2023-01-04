//
//  CalendarView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/9/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol DietTableDelegate {
    func requestDiet()
}

class DietTable: UIView, DietTableDelegate{
    
    var delegateDietTable: DietTableDelegate?
    func delegate(_ delegate: DietTableDelegate){
        self.delegateDietTable = delegate
    }
    
    let diet = profile.diet
    
    var values = DietTableValues()
    
    //MARK: INIT VIEW
    func initView(){
        setTopGradient()
        setName()
        setBmiText()
        setGoals()
        setChart()
        days()
    }
    
    //MARK: DAYS
    func days(){
        if diet.lastDay.toString == Date().toString{
            setUpdateDiet()
            setAlert(days: 1, have: true)
        }else if diet.dontHaveDiet && !isWaiting {
            setUpdateDiet()
            setAlert(days: diet.lastToNow, have: false)
        }else if diet.date.date.toString == Date().toString{
            setAlert(days: diet.period, have: true)
            setBtn()
        }else if !isWaiting{
            let dietDays = Date().getDays(after: diet.leftDay)
            setAlert(days: dietDays.count, have: true)
            setBtn()
        }else{
            setAlert(days: 0, have: true)
            setBtn()
        }
    }
    
    func setBtn(){
        setBottomGradient()
        setDietCountPeriod()
        setHorizontalLineBottom()
    }
    
    //MARK: TOP GRADIENT
    let topGradient = CALayer()
    func setTopGradient(){
        topGradient.frame(0, 0, width, 50)
        topGradient.backgroundColor(gray01)
        let topGradientMask = CAShapeLayer()
        topGradientMask.frame(topGradient.bounds)
        topGradientMask.path(topGradientMask.roundCorner(rt: 45, lt: 45, lb: 0, rb: 0))
        topGradient.mask(topGradientMask)
        let overGradient = CAGradientLayer()
        overGradient.frame(4, 4, width-8, 46)
        overGradient.colors([green01, green02])
        let overMask = CAShapeLayer()
        overMask.frame(overGradient.bounds)
        overMask.path(overMask.roundCorner(rt: 40, lt: 40, lb: 0, rb: 0))
        overGradient.mask(overMask)
        topGradient.addSublayer(overGradient)
        addSublayer(topGradient)
    }
    
    //MARK: NAME
    var name = UILabel()
    func setName(){
        let isPersian = profile.fullName.isPersianString
        name.frame(20, isPersian ? 0 : 2, width-40, 50)
        name.text(profile.fullName)
        name.textColor(gray0)
        name.adjustsFontSizeToFitWidth(true)
        name.font(Sahel_Bold, 28)
        name.textAlignment(.center)
        name.shadow(CGSize(0, 0.5), gray07, 1, 0.7)
        addSubview(name)
    }
    
    //MARK: BMI
    let bmiView = UIView()
    func setBmiText(){
        let string = "BMI : \(diet.bmi)"
        let font = UIFont(GillSans, 17)!
        let width = string.width(height: 18, font: font) + 14
        bmiView.frame(-2, topGradient.y + topGradient.height/2 - 10, width, 20)
        bmiView.clipsToBounds(true)
        bmiView.backgroundColor(gray01.opacity(0.8))
        bmiView.cornerRadius(5)
        
        let mask = UIView()
        mask.frame(bmiView.bounds)
        mask.backgroundColor(sand01)
        mask.transformX(6)
        bmiView.mask(mask)
        
        let half = UIView()
        half.frame(bmiView.bounds)
        half.backgroundColor(gray02.opacity(0.8))
        half.transformY(bmiView.height/2)
        bmiView.addSubview(half)
        
        let bmiText = UILabel()
        bmiText.frame(bmiView.bounds)
        bmiText.x(bmiView.width/2+2)
        bmiText.text(string)
        bmiText.font(font)
        bmiText.textColor(green)
        bmiText.textAlignment(.center)
        bmiView.addSubview(bmiText)
        addSubview(bmiView)
    }
    
    //MARK: GOALS
    var goals = UILabel()
    func setGoals(){
        goals.frame(5, topGradient.height - 2, width-10, 55)
        goals.text(values.goals)
        goals.textColor(gray07)
        goals.font(Sahel_Bold, 18)
        goals.adjustsFontSizeToFitWidth(true)
        goals.numberOfLines(0)
        goals.textAlignment(.center)
        addSubview(goals)
    }
    
    //MARK: CHART
    var chart = Chart()
    func setChart(){
        chart.frame(0, goals.y + goals.height/2, width, 155)
        chart.backgroundColor(gray02)
        chart.shadow(CGSize(0, 1), gray08, 1, 0.7)
        chart.initView()
        addSubview(chart)
    }
    
    //MARK: REQUEST DIET
    @objc func requestDiet() {
        gradient.animate(colors: [skyBlue01, skyBlue02], 0.3, easeOut)
        gradient.animate(colors: [skyBlue02, skyBlue01], 0.3, easeOut, 0.3)
        delegateDietTable?.requestDiet()
    }
    
    //MARK: BOTTOM LINE
    func setHorizontalLineBottom(){
        let line1 = UIView()
        line1.frame(0, height-51, width, 1)
        line1.backgroundColor(gray04)
        addSubview(line1)
        let line2 = UIView()
        line2.frame(0, height-50, width, 1)
        line2.backgroundColor(white)
        addSubview(line2)
    }
    
    //MARK: BOTTOM GRADIENT
    var bottomGradient = CAGradientLayer()
    func setBottomGradient(){
        bottomGradient.frame(0, height-50, width, 50)
        bottomGradient.colors([gray01, gray03])
        bottomGradient.locations([0, 1])
        bottomGradient.startPoint(0, 0)
        bottomGradient.endPoint(0, 1)
        setBottomGradientMask()
        bottomGradient.mask(bottomGradientMask)
        addSublayer(bottomGradient)
    }
    
    var bottomGradientMask = CAShapeLayer()
    func setBottomGradientMask(){
        bottomGradientMask.frame(bottomGradient.bounds)
        bottomGradientMask.path(bottomGradientMask.roundCorner(rt: 0, lt: 0, lb: 40, rb: 40))
        bottomGradientMask.fillColor(red01)
    }
    
    //MARK: DIET PERIOD
    var dietCountPeriod = UILabel()
    func setDietCountPeriod(){
        let string = isWaiting ? values.dietCount : values.dietCount + " / " + values.period
        dietCountPeriod.frame(0, height-52, width, 50)
        dietCountPeriod.text(string)
        dietCountPeriod.font(Sahel_Bold, 18)
        dietCountPeriod.adjustsFontSizeToFitWidth(true)
        dietCountPeriod.textColor(teal01)
        dietCountPeriod.textAlignment(.center)
        addSubview(dietCountPeriod)
    }
    
    //MARK: ALERT DAYS
    var alertDays = AlertDays()
    func setAlert(days: Int, have: Bool){
        alertDays.frame(0, height-100, width, 45)
        alertDays.have(have)
        alertDays.days(days)
        alertDays.initView()
        addSubview(alertDays)
    }
    
    //MARK: UPDATE DIET
    var updateDiet = UIView()
    func setUpdateDiet(){
        updateDiet.frame(0, height-50, width, 50)
        updateDiet.onTap(self, #selector(requestDiet), 1)
        updateDiet.backgroundColor(gray01)
        let mask = UIView()
        mask.frame(updateDiet.bounds)
        let maskShape = CAShapeLayer()
        maskShape.frame(mask.bounds)
        maskShape.path(maskShape.roundCorner(rt: 0, lt: 0, lb: 45, rb: 45))
        mask.addSublayer(maskShape)
        updateDiet.mask(mask)
        setGradient()
        setUp()
        addSubview(updateDiet)
    }
    
    var up = UILabel()
    func setUp(){
        up.frame(0, isRTL ? -3 : -2, width, 50)
        up.text(values.requestDiet)
        up.font(Sahel_Bold, 18)
        up.textAlignment(.center)
        up.textColor(gray0)
        updateDiet.addSubview(up)
    }
    
    //MARK: REQUEST GRADIET
    var gradient = CAGradientLayer()
    func setGradient(){
        gradient.frame(4, 0, width-8, 46)
        gradient.colors([skyBlue02, skyBlue01])
        gradient.startPoint(0, 1)
        gradient.endPoint(0, 0)
        let gradientMask = CAShapeLayer()
        gradientMask.frame(gradient.bounds)
        gradientMask.path(gradientMask.roundCorner(rt: 0, lt: 0, lb: 40, rb: 40))
        gradient.mask(gradientMask)
        updateDiet.addSublayer(gradient)
    }
}
