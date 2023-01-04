//
//  MonthsView.swift
//  Sibdiet
//
//  Created by Amin on 4/3/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit

protocol MonthsViewDelegate {
    func selectedMonth(_ month: String, _ monthNumber: String)
}

class MonthsView: UIView, MonthsViewDelegate{
    
    var delegateMonthsView: MonthsViewDelegate?
    func delegate(_ delegate: MonthsViewDelegate){
        self.delegateMonthsView = delegate
    }
    
    var monthsHeight = CGFloat()
    func monthsHeight(_ height: CGFloat){
        self.monthsHeight = height
    }
    
    var closeHeight = CGFloat()
    func closeHeight(_ height: CGFloat){
        self.closeHeight = height
    }
    
    var corner = CGFloat()
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var monthsLabel = [String]()
    func monthsLabel(_ labels: [String]){
        self.monthsLabel = labels
    }
    
    var selectorFont = UIFont(Sahel, 17)!
    func selectorFont(_ font: UIFont){
        self.selectorFont = font
    }
    
    var monthResult = String()
    func monthResult(_ result: String){
        self.monthResult = result
    }
    
    //MARK: INIT VIEW
    func initView(){
        setMonths()
    }
    
    //MARK: MONTH'S
    let months = UIView()
    func setMonths(){
        months.frame(0, 0, width, 0)
        months.backgroundColor(gray01)
        months.cornerRadius(corner)
        months.border(gray00, 4)
        months.clipsToBounds(true)
        setMonthHolder()
        addSubview(months)
    }
    
    //MARK: MONTH HOLDER
    var monthsHolder = UIView()
    func setMonthHolder(){
        monthsHolder.frame(10, 0, width-30, monthsHeight)
        setMonthCells()
        months.addSubview(monthsHolder)
    }
    
    //MARK: CELL'S
    var monthCells = [Int: Button]()
    func setMonthCells(){
        var j = -1
        var i = 6
        var k = -1
        var y: CGFloat = 22
        
        for month in monthsLabel{
            j += 1
            i -= 1
            k += 1
            if i == -1 || k == 6{
                y += 60
                i = 5
                k = 0
            }
            monthCells[j] = Button()
            let width = month.width(height: 15, font: selectorFont) + 20
            let widthOfMonth = monthsHolder.width-10
            let x: CGFloat = widthOfMonth/6 * CGFloat(isRTL ? i : k) + widthOfMonth/12 - width/2 + (isRTL ? 10 : 5),
            w: CGFloat = width,
            h: CGFloat = 40
            monthCells[j]?.frame(x, y, w, h)
            monthCells[j]?.title(month)
            monthCells[j]?.font(selectorFont)
            monthCells[j]?.shadow(.zero, gray09, 0.7, 1)
            monthCells[j]?.transformR(-45)
            monthCells[j]?.tag(j)
            monthCells[j]?.initView()
            if month == monthResult {
                monthCells[j]?.select()
            }
            monthCells[j]?.onTap(self, #selector(tap(tap:)))
            monthsHolder.addSubview(monthCells[j]!)
        }
    }
    
    //MARK: TAP
    @objc func tap(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        let month = (monthCells[tag]?.title)!
        let intMonth = tag+1
        let number = intMonth<10 ? "0\(String(intMonth))" : String(intMonth)
        monthResult(month)
        selectedMonth(monthResult, number)
        for (i, cell) in monthCells{
            if i == tag{
                cell.select()
            }else{
                cell.deSelect()
            }
        }
    }
    
    //MARK: SELECTED MONTH
    func selectedMonth(_ month: String, _ monthNumber: String) {
        delegateMonthsView?.selectedMonth(month, monthNumber)
    }
    
    //MARK: OPEN MONTH
    let duration: CFTimeInterval = 0.5
    func openMonth(){
        let height = closeHeight+monthsHeight
        let holderY = closeHeight + monthsHeight/2
        months.animate(height: height, duration, curve)
        months.animate(y: height/2, duration, curve)
        monthsHolder.animate(y: holderY, duration, curve)
    }
    
    //MARK: CLOSE MONTH
    func closeMonth(){
        months.animate(height: closeHeight, duration, curve)
        months.animate(y: closeHeight/2, duration, curve)
        monthsHolder.animate(y: monthsHeight/2, duration, curve)
    }
    
    //MARK: CLOSE VIEW
    func closeView(_ delay: CFTimeInterval){
        let duration: CFTimeInterval = 0.8
        months.animate(width: 0, duration, curve, delay)
        months.animate(x: width/2, duration, curve, delay)
    }
    
    //MARK: START VIEW
    func startView(_ delay: CFTimeInterval){
        let duration: CFTimeInterval = 1.0
        months.animate(width: width, duration, curve, delay+0.1)
        months.animate(x: width/2, duration, curve, delay)
    }
}
