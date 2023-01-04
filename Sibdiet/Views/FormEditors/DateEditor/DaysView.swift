//
//  DaysView.swift
//  Sibdiet
//
//  Created by Amin on 4/2/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit
import QuartzCore

protocol DaysViewDelegate {
    func selectedDay(_ dayNumber: String)
}

class DaysView: UIView, DaysViewDelegate{
    
    var delegateDaysView: DaysViewDelegate?
    func delegate(_ delegate: DaysViewDelegate){
        self.delegateDaysView = delegate
    }
    
    var daysHeight = CGFloat()
    func daysHeight(_ height: CGFloat){
        self.daysHeight = height
    }
    
    var closeHeight = CGFloat()
    func closeHeight(_ height: CGFloat){
        self.closeHeight = height
    }
    
    var corner = CGFloat()
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var daysLabel = [String]()
    func daysLabel(_ labels: [String]){
        self.daysLabel = labels
    }
    
    var selectorFont = UIFont(Sahel, 17)!
    func selectorFont(_ font: UIFont){
        self.selectorFont = font
    }
    
    var dayResult = String()
    func dayResult(_ result: String){
        self.dayResult = result
    }
    
    //MARK: INIT VIEW
    func initView(){
        setDays()
    }
    
    //MARK: DAYS
    let days = UIView()
    func setDays(){
        days.frame(0, 0, width, 0)
        days.backgroundColor(gray01)
        days.cornerRadius(corner)
        days.border(gray00, 4)
        days.clipsToBounds(true)
        setDayHolder()
        addSubview(days)
    }
    
    //MARK: DAYS HOLDER
    let daysHolder = UIView()
    func setDayHolder(){
        daysHolder.frame(0, 0, width, daysHeight)
        setDayCells()
        days.addSubview(daysHolder)
    }
    
    //MARK: CELL'S
    var dayCells = [Int: Button]()
    func setDayCells(){
        var j = -1
        var i = 7
        var k = -1
        var y: CGFloat = 5
        for day in daysLabel{
            j += 1
            i -= 1
            k += 1
            if i == -1 || k == 7{
                y += 40
                i = 6
                k = 0
            }
            dayCells[j] = Button()
            let widthOfDays = days.width-10
            let width = day.width(height: 20, font: selectorFont) + 20
            let index = isRTL ? i : k
            let x: CGFloat = widthOfDays/7 * CGFloat(index) + widthOfDays/14 - width/2 + 5,
            w: CGFloat = width,
            h: CGFloat = 40
            dayCells[j]?.frame(x, y, w, h)
            dayCells[j]?.title(day)
            dayCells[j]?.font(selectorFont)
            dayCells[j]?.shadow(.zero, gray09, 0.7, 1)
            dayCells[j]?.transformR(-45)
            dayCells[j]?.tag(j)
            dayCells[j]?.initView()
            if day == dayResult{
                dayCells[j]?.select()
            }
            dayCells[j]?.onTap(self, #selector(tap(tap:)))
            daysHolder.addSubview(dayCells[j]!)
        }
    }
    
    //MARK: TAP
    @objc func tap(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        let day = (dayCells[tag]?.title)!
        dayResult(day)
        selectedDay(dayResult)
        for (i, cell) in dayCells{
            if i == tag{
                cell.select()
            }else{
                cell.deSelect()
            }
        }
    }
    
    //MARK: SELECT DAY
    func selectedDay(_ dayNumber: String) {
        delegateDaysView?.selectedDay(dayNumber)
    }
    
    //MARK: OPEN DAY
    let duration: CFTimeInterval = 0.5
    func openDay() {
        let holderY = closeHeight + daysHeight/2
        days.animate(height: height, duration, curve)
        days.animate(y: height/2, duration, curve)
        daysHolder.animate(y: holderY, duration, curve)
    }
    
    //MARK: CLOSE DAY
    func closeDay() {
        days.animate(height: closeHeight, duration, curve)
        days.animate(y: closeHeight/2, duration, curve)
        daysHolder.animate(y: daysHeight/2, duration, curve)
    }
    
    //MARK: CLOSE VIEW
    func closeView(_ delay: CFTimeInterval){
        let duration: CFTimeInterval = 0.8
        days.animate(width: 0, duration, curve, delay)
        days.animate(x: width/2, duration, curve, delay)
    }
    
    //MARK: START VIEW
    func startView(_ delay: CFTimeInterval){
        let duration: CFTimeInterval = 1.0
        days.animate(width: width, duration, curve, delay+0.1)
        days.animate(x: width/2, duration, curve, delay)
    }
}
