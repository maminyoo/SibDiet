//
//  CATextLayerEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 10/25/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import Foundation
import UIKit

extension CATextLayer{
    
    func font(size: CGFloat,
              duration: CFTimeInterval,
              timingFunction: CAMediaTimingFunction,
              delay: CFTimeInterval){
        let animation = CABasicAnimation(keyPath: "fontSize")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = size
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    func foreground(color: UIColor,
                    duration: CFTimeInterval,
                    timingFunction: CAMediaTimingFunction,
                    delay: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "foregroundColor")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = timingFunction
        animation.toValue = color.cgColor
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    func animate(foregroundColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "foregroundColor")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = timingFunction
        animation.toValue = foregroundColor.cgColor
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    func foreground(color: UIColor,
                    toColor: UIColor,
                    duration: CFTimeInterval,
                    timingFunction: CAMediaTimingFunction,
                    repeatCount: Float,
                    delay: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "foregroundColor")
        animation.timingFunction = timingFunction
        animation.toValue = color.cgColor
        animation.fromValue = toColor
        animation.repeatCount = repeatCount
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    func string(_ string: String){
        self.string = string
    }
    
    func font(_ font: String){
        self.font = font as CFString
    }
    
    func font(_ font: String, _ size: CGFloat){
        self.font = font as CFString
        self.fontSize = size
    }
    
    func fontSize(_ size: CGFloat){
        fontSize = size
    }
    
    func foregroundColor(_ color: UIColor){
        foregroundColor = color.cgColor
    }
    
    func alignmentMode(_ alignment: CATextLayerAlignmentMode){
        alignmentMode = alignment
    }
    
    func contentsScale(){
        contentsScale = UIScreen.main.scale
    }
    
}
