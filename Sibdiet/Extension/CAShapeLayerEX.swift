//
//  CAShapeLayerEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 9/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//
import UIKit

extension CAShapeLayer {
    
    func roundCorner(rt: CGFloat, lt: CGFloat, lb: CGFloat, rb: CGFloat) -> CGPath{
        let path = UIBezierPath()
        
        path.move(to: CGPoint(0 + lt ,0))
        
        path.addLine(to: CGPoint(width - rt , 0))
        path.addQuadCurve(to: CGPoint(width , rt), controlPoint: CGPoint(width, 0))
        
        path.addLine(to: CGPoint(width , height - rb))
        path.addQuadCurve(to: CGPoint(width - rb ,height), controlPoint: CGPoint(width, height))
        
        path.addLine(to: CGPoint(lb , height))
        path.addQuadCurve(to: CGPoint(0 , height - lb),controlPoint: CGPoint(0,  height))
        
        path.addLine(to: CGPoint( 0 , lt))
        path.addQuadCurve(to: CGPoint(0 + lt , 0),controlPoint: CGPoint(0, 0))
        
        path.close()
        return path.cgPath
    }
    
    func animate(fillColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "fillColor")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = timingFunction
        animation.toValue = fillColor.cgColor
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    func animate(path: CGPath,
              _ duration: CFTimeInterval,
              _ timingFunction: CAMediaTimingFunction,
              _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = timingFunction
        animation.toValue = path
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    func path(_ cgpath: CGPath){
        path = cgpath
    }
    
    func fillColor(_ color: UIColor){
        fillColor = color.cgColor
    }
    func strokeColor(_ color: UIColor){
        strokeColor = color.cgColor
    }
    
    func lineWidth(_ width: CGFloat){
        lineWidth = width
    }
}
