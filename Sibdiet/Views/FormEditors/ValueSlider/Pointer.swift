//
//  Pointer.swift
//  Sibdiet
//
//  Created by Me on 10/12/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class Pointer: UIView{
    
    var result = Int()
    func result(_ int: Int){
        result = int
    }
    var values = [Int]()
    func values(_ vals: [Int]){
        values = vals
    }
    
    var color = UIColor()
    func color(_ color: UIColor){
        self.color = color
    }
    var cellHeight : CGFloat{ height-10 }
    var rulerWidth : CGFloat{ height*values.count.toCGFloat }
    var rulerRight : CGFloat{ rulerHolder.width-rulerWidth/2-2 }
    var rulerLeft  : CGFloat{ rulerWidth/2+2 }
    
    //MARK: INIT VIEW
    func initView(){
        setRulerHolder()
        setBackground()
    }
    
    //MARK: RULER
    var rulerHolder = UIView()
    func setRulerHolder(){
        rulerHolder.frame(3, 3, width-6, width-6)
        rulerHolder.clipsToBounds(true)
        rulerHolder.cornerRadius(15)
        setRuler()
        addSubview(rulerHolder)
    }
    
    lazy var ruler = UIView()
    func setRuler(){
        let font = isRTL ? Gandom : Sahel
        var index = -1
        for number in values{
            index += 1
            let label = UILabel()
            let string = isRTL ? number.string.faNumber : number.string
            let x = isRTL ? rulerWidth-cellHeight-(cellHeight*index.toCGFloat) : cellHeight*index.toCGFloat
            label.frame(x, 1, cellHeight, cellHeight)
            label.font(font, cellHeight - 24)
            label.backgroundColor(index%2==0 ? oddColor : evenColor)
            label.textColor(color)
            label.textAlignment(.center)
            label.text(string)
            ruler.addSubview(label)
        }
        ruler.frame(isRTL ? width-rulerWidth-7 : 3, 1, rulerWidth, cellHeight)
        rulerHolder.addSubview(ruler)
    }
    
    //MARK: MOVE RULER
    func moveRuler(index: Int, _ duration: CFTimeInterval = 0.4){
        let x = isRTL ?
            rulerRight + cellHeight*index.toCGFloat :
            rulerLeft - cellHeight*index.toCGFloat
        ruler.animate(x: x, duration, curve)
    }
    
    //MARK: POINTER
    var background = UIView()
    func setBackground(){
        background.frame(2, 2, width-4, height-4)
        let maskView = UIView()
        maskView.frame(background.bounds)
        let gradient = CAGradientLayer()
        gradient.frame(background.bounds)
        gradient.colors([white, gray00])
        gradient.startPoint(0, 0)
        gradient.endPoint(1, 1)
        let shape = CAShapeLayer()
        shape.frame(background.bounds)
        shape.path(pointerPath)
        shape.fillColor(gray0)
        background.addSublayer(gradient)
        maskView.addSublayer(shape)
        background.mask(maskView)
        addSubview(background)
    }
    
    var pointerPath: CGPath{
        let clipPath = UIBezierPath()
        clipPath.move(13.2, 0)
        clipPath.addCurve(CGPoint(0, 13.2), CGPoint(5.91, 0), CGPoint(0, 5.91))
        clipPath.addLine(0, 13.2)
        clipPath.addLine(0, 41.8)
        clipPath.addCurve(CGPoint(13.2, 55), CGPoint(0, 49.09), CGPoint(5.91, 55))
        clipPath.addLine(13.2, 55)
        clipPath.addLine(41.8, 55)
        clipPath.addCurve(CGPoint(55, 41.8), CGPoint(49.09, 55), CGPoint(55, 49.09))
        clipPath.addLine(55, 41.8)
        clipPath.addLine(55, 13.2)
        clipPath.addCurve(CGPoint(41.8, 0), CGPoint(55, 5.91), CGPoint(49.09, 0))
        clipPath.addLine(41.8, 0)
        clipPath.addLine(13.2, 0)
        clipPath.close()
        clipPath.move(5.67, 40.28)
        clipPath.addLine(5.67, 14.72)
        clipPath.addCurve(CGPoint(14.72, 5.66), CGPoint(5.67, 9.72), CGPoint(9.72, 5.66))
        clipPath.addLine(14.72, 5.66)
        clipPath.addLine(40.28, 5.66)
        clipPath.addCurve(CGPoint(49.34, 14.72), CGPoint(45.28, 5.66), CGPoint(49.34, 9.72))
        clipPath.addLine(49.34, 14.72)
        clipPath.addLine(49.34, 40.28)
        clipPath.addCurve(CGPoint(40.28, 49.33), CGPoint(49.34, 45.28), CGPoint(45.28, 49.33))
        clipPath.addLine(40.28, 49.33)
        clipPath.addLine(14.72, 49.33)
        clipPath.addCurve(CGPoint(5.67, 40.28), CGPoint(9.72, 49.33), CGPoint(5.67, 45.28))
        clipPath.close()
        clipPath.addClip()

        let bezierPath = UIBezierPath()
        bezierPath.move(13.2,  0)
        bezierPath.addCurve(CGPoint(0, 13.2), CGPoint(5.91, 0), CGPoint(0, 5.91))
        bezierPath.addLine(0, 13.2)
        bezierPath.addLine(0, 41.8)
        bezierPath.addCurve(CGPoint(13.2, 55), CGPoint(0, 49.09), CGPoint(5.91, 55))
        bezierPath.addLine(13.2, 55)
        bezierPath.addLine(41.8, 55)
        bezierPath.addCurve(CGPoint(55, 41.8), CGPoint(49.09, 55), CGPoint(55, 49.09))
        bezierPath.addLine(55, 41.8)
        bezierPath.addLine(55, 13.2)
        bezierPath.addCurve(CGPoint(41.8, 0), CGPoint(55, 5.91), CGPoint(49.09, 0))
        bezierPath.addLine(41.8, 0)
        bezierPath.addLine(13.2, 0)
        bezierPath.close()
        bezierPath.move(5.67, 40.28)
        bezierPath.addLine(5.67, 14.72)
        bezierPath.addCurve(CGPoint(14.72, 5.66), CGPoint(5.67, 9.72), CGPoint(9.72, 5.66))
        bezierPath.addLine(14.72, 5.66)
        bezierPath.addLine(40.28, 5.66)
        bezierPath.addCurve(CGPoint(49.34, 14.72), CGPoint(45.28, 5.66), CGPoint(49.34, 9.72))
        bezierPath.addLine(49.34, 14.72)
        bezierPath.addLine(49.34, 40.28)
        bezierPath.addCurve(CGPoint(40.28, 49.33), CGPoint(49.34, 45.28), CGPoint(45.28, 49.33))
        bezierPath.addLine(40.28, 49.33)
        bezierPath.addLine(14.72, 49.33)
        bezierPath.addCurve(CGPoint(5.67, 40.28), CGPoint(x: 9.72, y: 49.33), CGPoint(5.67, 45.28))
        bezierPath.close()
        bezierPath.addClip()
        return clipPath.cgPath
    }
}
