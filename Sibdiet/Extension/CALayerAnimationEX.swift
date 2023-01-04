//
//  CALayerAnimationEX.swift
//  Sibdiet
//
//  Created by Me on 9/1/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

extension CALayer{
    
    //MARK: - transform3D
    func animate(transform3D: CATransform3D,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "transform")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = transform3D
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - scale
    func animate(scale: CGSize,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = scale
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - scaleX
    func animate(scaleX: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "transform.scale.x")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = scaleX
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - scaleY
    func animate(scaleY: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = scaleY
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - scaleZ
    func animate(scaleZ: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "transform.scale.z")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = scaleZ
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - size
    func animate(size: CGSize,
                 _ duration: CFTimeInterval,
                 _ timingFunction : CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "bounds.size")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = size
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - width
    func animate(width: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction : CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = width
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - height
    func animate(height: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = height
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - position
    func animate(position: CGPoint,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = position
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - x
    func animate(x : CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = x
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - y
    func animate(y: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = y
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - rotation
    func animate(rotation: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.timingFunction = timingFunction
        animation.toValue = degreesToRadians(rotation)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    //MARK: - rotationX
    func animate(rotationX: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.timingFunction = timingFunction
        animation.toValue = degreesToRadians(rotationX)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    //MARK: - rotationY
    func animate(rotationY: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.timingFunction = timingFunction
        animation.toValue = degreesToRadians(rotationY)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    //MARK: - rotationZ
    func animate(rotationZ: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.timingFunction = timingFunction
        animation.toValue = degreesToRadians(rotationZ)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    //MARK: - cornerRadius
    func animate(cornerRadius: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = cornerRadius
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - shadowOffset
    func animate(shadowOffset: CGSize,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "shadowOffset")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = shadowOffset
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - shadowColor
    func animate(shadowColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "shadowColor")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = shadowColor.cgColor
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - shadowPath
    func animate(shadowPath: CGPath,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "shadowPath")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = shadowPath
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - shadowRadius
    func animate(shadowRadius: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "shadowRadius")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = shadowRadius
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - shadowOpacity
    func animate(shadowOpacity: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction : CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = shadowOpacity
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - opacity
    func animate(opacity: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.timingFunction = timingFunction
        animation.duration = duration
        animation.toValue = opacity
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.beginTime = CACurrentMediaTime() + delay
        add(animation, forKey: nil)
    }
    
    //MARK: - backgroundColor
    func animate(backgroundColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = timingFunction
        animation.toValue = backgroundColor.cgColor
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    //MARK: - borderColor
    func animate(borderColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = timingFunction
        animation.toValue = borderColor.cgColor
        animation.duration = duration
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        add(animation, forKey: nil)
    }
    
    //MARK: - anchorPoint
      func animate(anchorPoint: CGPoint,
                   _ duration: CFTimeInterval,
                   _ timingFunction: CAMediaTimingFunction,
                   _ delay: CFTimeInterval = 0){
          let animation = CABasicAnimation(keyPath: "anchorPoint")
          animation.duration = duration
          animation.timingFunction = timingFunction
          animation.toValue = anchorPoint
          animation.beginTime = CACurrentMediaTime() + delay
          animation.isRemovedOnCompletion = false
          animation.fillMode = CAMediaTimingFillMode.forwards
          add(animation, forKey: nil)
      }
        
    //MARK: - strokeEnd
    func animate(strokeEnd: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.fromValue = 0
        animation.toValue = strokeEnd
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - strokeColor
    func animate(strokeColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "strokeColor")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.fromValue = 0
        animation.toValue = strokeColor.cgColor
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    
    //MARK: - lineWidth
    func animate(lineWidth: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "lineWidth")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.fromValue = 0
        animation.toValue = lineWidth
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - zPosition
    func animate(zPosition: CGFloat,
                 _ duration: CFTimeInterval,
                 _ timingFunction: CAMediaTimingFunction,
                 _ delay: CFTimeInterval = 0){
        let animation = CABasicAnimation(keyPath: "zPosition")
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.toValue = zPosition
        animation.beginTime = CACurrentMediaTime() + delay
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        add(animation, forKey: nil)
    }
    
    //MARK: - width
       func border(width: CGFloat,
                   duration: CFTimeInterval,
                   timingFunction: CAMediaTimingFunction,
                   delay: CFTimeInterval) {
           let animation = CABasicAnimation(keyPath: "borderWidth")
           animation.beginTime = CACurrentMediaTime() + delay
           animation.timingFunction = timingFunction
           animation.toValue = width
           animation.duration = duration
           animation.fillMode = CAMediaTimingFillMode.forwards
           animation.isRemovedOnCompletion = false
           add(animation, forKey: nil)
       }
}

//func springTransform3D(to: CATransform3D,
//                       duration: CFTimeInterval,
//                       damping: CGFloat,
//                       velocity: CGFloat,
//                       timingFunction : CAMediaTimingFunction,
//                       delay: CFTimeInterval){
//    let animation = CASpringAnimation(keyPath: "transform")
//    animation.duration = duration
//    animation.timingFunction = timingFunction
//    animation.damping = damping
//    animation.initialVelocity = velocity
//    animation.toValue = to
//    animation.beginTime = CACurrentMediaTime() + delay
//    animation.isRemovedOnCompletion = false
//    animation.fillMode = CAMediaTimingFillMode.forwards
//    add(animation, forKey: nil)
//}
