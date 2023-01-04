//
//  Chart.swift
//  Sibdiet
//
//  Created by Amin on 5/27/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

class Chart: UIView{
    var standard = UserDefaults.standard

    let values = ChartValues()
    let ideal = profile.diet.idealWeight.substring(to: 1).int
    let weights = profile.diet.weights
    let days = profile.diet.days
    var differenceWeights = [Int]()
    var isBig = [Bool]()
    var maxDifference = Int()
    let barWidth: CGFloat = 55
    
    //MARK: INIT VIEW
    func initView(){
        for weight in weights{
            isBig.append(weight > ideal)
            differenceWeights.append((ideal - weight).string.replace(["-": ""]).int)
        }
        var d = differenceWeights[0]
        if differenceWeights.count>1{
            for difference in differenceWeights{ if difference>d{ d = difference } }
            maxDifference = d
        }
        else{ maxDifference = differenceWeights[0] }
        setBG()
        setOverView()
    }
    
    //MARK: BACKGROUND
    var bg = UIView()
    func setBG(){
        bg.frame(5, 5, width-10, height-20)
        setHelper()
        setWeight()
        setIdealBar()
        setVerticalLine()
        setKG()
        setChartView()
        addSubview(bg)
    }
    
    //MARK: HELPER LINE
    func setHelper(){
        let first = UIView()
        let secend = UIView()
        let third = UIView()
        let fourth = UIView()
        first.frame(60, 0, bg.width-120, bg.height/4)
        secend.frame(60, bg.height/4, bg.width-120, bg.height/4)
        third.frame(60, bg.height/2, bg.width-120, bg.height/4)
        fourth.frame(60, third.y+third.height/2, bg.width-120, bg.height/4)
        first.backgroundColor(gray01.opacity(0.3))
        secend.backgroundColor(white02.opacity(0.3))
        third.backgroundColor(gray01.opacity(0.3))
        fourth.backgroundColor(white02.opacity(0.3))
        bg.addSubview(first)
        bg.addSubview(secend)
        bg.addSubview(third)
        bg.addSubview(fourth)
    }
    
    //MARK: WEIGHT
    func setWeight(){
        let weight = UILabel()
        weight.frame(0, 0, barWidth, 20)
        weight.textColor(gray06)
        weight.text(values.weight)
        weight.textAlignment(.center)
        weight.font(UIFont(Sahel, 14)!)
        weight.backgroundColor(gray00)
        weight.cornerRadius(5)
        weight.clipsToBounds(true)
        bg.addSubview(weight)
    }
    
    //MARK: IDEAL BAR
    var idealBar = UIView()
    func setIdealBar(){
        idealBar.frame(0, bg.height/2, barWidth, bg.height/2)
        let shape = CAShapeLayer()
        let shape2 = CAShapeLayer()
        shape.frame(idealBar.bounds)
        shape2.frame(4, 4, idealBar.width-8, idealBar.height-4)
        shape.path(shape.roundCorner(rt: 15, lt: 15, lb: 0, rb: 0))
        shape2.path(shape2.roundCorner(rt: 12, lt: 12, lb: 0, rb: 0))
        shape.fillColor(mountainMeadowColor)
        shape2.fillColor(mountainMeadowColor)
        shape.opacity(0.4)
        shape2.opacity(0.6)
        idealBar.addSublayer(shape)
        idealBar.addSublayer(shape2)
        setIdealInt()
        setIdealtitle()
        bg.addSubview(idealBar)
    }
    
    //MARK: IDEAL NUMBER
    func setIdealInt(){
        let idealInt = UILabel()
        idealInt.frame(0, isRTL ? -27 : -25, idealBar.width, barWidth)
        idealInt.textColor(gray0)
        idealInt.text(values.idealInt)
        idealInt.font(UIFont(Sahel_Bold, 32)!)
        idealInt.textAlignment(.center)
        idealInt.shadow(.zero, gray08, 1, 1)
        idealBar.addSubview(idealInt)
    }
    
    //MARK: IDEAL TITLE
    func setIdealtitle(){
        let idealTitle = UILabel()
        idealTitle.frame(0, idealBar.height-20, idealBar.width, 20)
        idealTitle.text(values.ideal)
        idealTitle.font(UIFont(Sahel, 16)!)
        idealTitle.textColor(white)
        idealTitle.textAlignment(.center)
        idealBar.addSubview(idealTitle)
    }
    
    //MARK: CHART VIEW
    let chartView = UIView()
    func setChartView(){
        chartView.frame(34, 0, bg.width-68, bg.height)
        setWeightsBars()
        bg.addSubview(chartView)
    }
    
    //MARK:  WEIGHT BARS
    func setWeightsBars(){
        var i = -1
        let div = bg.height/2/ideal.toCGFloat
        for weight in weights{
            i += 1
            let k: CGFloat = (i + 1).toCGFloat
            let chartBar = ChartBar()
            let heightFix = isBig[i] ? div*differenceWeights[i].toCGFloat : -(div*differenceWeights[i].toCGFloat)
            chartBar.frame((chartView.width/(weights.count+1).toCGFloat)*k-barWidth/2,
                           bg.height/2-heightFix,
                           barWidth,
                           bg.height/2+heightFix)
            chartBar.weight(weight)
            chartBar.date(days[i].date)
            chartBar.opacity(0.9)
            chartBar.initView()
            chartView.addSubview(chartBar)
        }
    }
    
    //MARK: VERTICAL LINE
    func setVerticalLine(){
        let verticalLine = UIView()
        verticalLine.frame(60, 0, 1, bg.height)
        verticalLine.backgroundColor(white02)
        verticalLine.opacity(0.3)
        bg.addSubview(verticalLine)
    }
    
    //MARK: KG
    func setKG(){
        let kg = UILabel()
        kg.frame(65, 1, 30, 20)
        kg.font(UIFont(Sahel_Bold, 14)!)
        kg.text("KG")
        kg.textAlignment(.left)
        kg.cornerRadius(5)
        kg.clipsToBounds(true)
        kg.textColor(gray06)
        bg.addSubview(kg)
    }
    
    //MARK: OVER WEIGHT VIEW
    let overView = UIView()
    func setOverView(){
        overView.frame(width-65, 12, 55, bg.height-20)
        setOverInt()
        setOverKg()
        setOverTitle()
        setOverWeight()
        overView.shadow(.zero, white, 2, 1)
        bg.addSubview(overView)
    }
    
    //MARK: OVER NUMBER
    let overInt = UILabel()
    func setOverInt(){
        overInt.frame(0, overView.height/2-45, barWidth, 30)
        overInt.textColor(orange01)
        overInt.textAlignment(.center)
        overInt.font(UIFont(Sahel_Bold, 32)!)
        overInt.text(values.overWeight)
        overView.addSubview(overInt)
    }
    
    //MARK: OVER KG
    func setOverKg(){
        let overKg = UILabel()
        overKg.frame(overView.width/2, overInt.y+overInt.height/2-3, overView.width/2, 20)
        overKg.font(UIFont(Sahel, 18)!)
        overKg.text("KG")
        overKg.textAlignment(.left)
        overKg.textColor(flatGray02)
        overView.addSubview(overKg)
    }
    
    //MARK: OVER TITLE
    func setOverTitle(){
        let overTitle = UILabel()
        overTitle.frame(0, overView.height/2+3, barWidth, 20)
        overTitle.text(values.stateWeight)
        overTitle.font(UIFont(Sahel_Bold, 16)!)
        overTitle.textAlignment(.center)
        overTitle.textColor(flatGray02)
        overView.addSubview(overTitle)
    }
    
    //MARK: OVER WEIGHT
    func setOverWeight(){
        let overWeight = UILabel()
        overWeight.frame(0, overView.height/2+20, barWidth, 20)
        overWeight.text(values.weight.lowercased)
        overWeight.textAlignment(.center)
        overWeight.textColor(flatGray02)
        overWeight.font(UIFont(Sahel_Bold, 16)!)
        overView.addSubview(overWeight)
    }
}

