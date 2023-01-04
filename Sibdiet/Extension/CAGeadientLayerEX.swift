//
//  CAGeadientLayerEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/17/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer{
    
    func animate(colors: [UIColor],
                 _ duration: CFTimeInterval,
                 _ timingFunction : CAMediaTimingFunction,
                 _ delay: CFTimeInterval  = 0){
        var color = [CGColor]()
        for c in colors{ color.append(c.cgColor) }
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = color
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    func animate(locations: [CGFloat],
                  _ duration: CFTimeInterval,
                  _ timingFunction: CAMediaTimingFunction,
                  _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "locations")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = locations
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    func animate(startPoint: CGPoint,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = startPoint
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    func animate(endPoint: CGPoint,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "endPoint")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = endPoint
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    func colors(_ colors: [UIColor]){
        var color = [CGColor]()
        for c in colors{ color.append(c.cgColor) }
        self.colors = color
    }
    
    func startPoint(_ x: CGFloat, _ y: CGFloat){
        startPoint = CGPoint(x, y)
    }
    
    func endPoint(_ x: CGFloat, _ y: CGFloat){
        endPoint = CGPoint(x, y)
    }
    
    func locations(_ locations: [NSNumber]){
        self.locations = locations
    }
}
