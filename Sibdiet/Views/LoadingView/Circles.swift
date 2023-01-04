//
//  Circles.swift
//  Sibdiet
//
//  Created by Amin on 9/29/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class Circles: UIView {
    
    var colors = [UIColor]()
    func colors(_ colors: [UIColor]){
        self.colors = colors
    }
    
    var duration: CFTimeInterval = 1
    func duration(_ duration: CFTimeInterval){
        self.duration = duration
    }
    
    var timingFunction = easeInOut02
    func timingFunction(_ timingFunction: CAMediaTimingFunction){
        self.timingFunction = timingFunction
    }
    
    func initView(){
        setCircleLayer()
        setUpAnimation()
    }
    
    let shape = CAShapeLayer()
    func setCircleLayer(){
        shape.frame(bounds)
        addSublayer(shape)
    }
    
    func setUpAnimation() {
        let beginTime = CACurrentMediaTime()
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        let beginTimes = [0, 0.2, 0.4, 0.6]
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = duration
        opacityAnimation.keyTimes = [0, 0.05, 1, 1.5]
        opacityAnimation.values = [0, 1, 0, 1]
        
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimation]
        animation.timingFunction = timingFunction
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        for i in 0 ..< 4 {
            let circle = Shapes.ring.layerWith(size: size, color: colors[i])
            let frame = CGRect((width - width) / 2,
                               (height - height) / 2,
                               width,
                               height)
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.opacity = 0
            circle.add(animation, forKey: "animation")
            shape.addSublayer(circle)
        }
    }
}
