//
//  ChartBar.swift
//  Sibdiet
//
//  Created by freeman on 10/30/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class ChartBar: UIView{
    
    var weight = Int()
    func weight(_ int: Int){
        self.weight = int
    }
    
    var date = Date()
    func date(_ date: Date){
        self.date = date
    }
    
    let values = ChartValues()

    //MARK: INIT VIEW
    func initView(){
        setShape()
        setIdealInt()
        setDate()
        setYear()
    }
    
    //MARK: IDEAL INT
    func setIdealInt(){
        let idealInt = UILabel()
        idealInt.frame(0, isRTL ? -27 : -25, width, width)
        idealInt.textColor(white)
        idealInt.text(isRTL ? weight.string.faNumber : weight.string)
        idealInt.font(Sahel_Bold, 28)
        idealInt.textAlignment(.center)
        idealInt.shadow(.zero, gray08, 1, 1)
        addSubview(idealInt)
    }
    
    //MARK: SHAPE
    func setShape(){
        let shape = CAShapeLayer()
        let shape2 = CAShapeLayer()
        shape.frame(bounds)
        shape2.frame(4, 4, width-8, height-4)
        shape.path(shape.roundCorner(rt: 15, lt: 15, lb: 0, rb: 0))
        shape2.path(shape2.roundCorner(rt: 12, lt: 12, lb: 0, rb: 0))
        shape.fillColor(lime01)
        shape2.fillColor(lime01)
        shape.opacity(0.4)
        shape2.opacity(0.5)
        addSublayer(shape)
        addSublayer(shape2)
    }
    
    //MARK: DATE
    func setDate(){
        let date = UILabel()
        date.frame(0, height - 20, width, 20)
        date.text(isRTL ? self.date.shortPersianTime : self.date.shortTime)
        date.font(UIFont(Sahel, 14)!)
        date.textColor(white)
        date.textAlignment(.center)
        addSubview(date)
    }
    
    //MARK: YEAR
    func setYear(){
        let year = UILabel()
        year.frame(0, height, width, 17)
        year.text(isRTL ? self.date.persianYear : self.date.year)
        year.font(UIFont(Sahel, 14)!)
        year.textColor(gray06)
        year.textAlignment(.center)
        addSubview(year)
    }
}
