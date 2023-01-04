//
//  UIViewAnimationEX.swift
//  Sibdiet
//
//  Created by Me on 9/1/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

extension UIView {
    
    //MARK: - frame
    func animate(frame: CGRect,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.frame(frame) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - x
    func animate(x: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        if x != self.x{
            let animation = UIViewPropertyAnimator(duration: duration,
                                                   timingParameters: curve)
            animation.addAnimations { self.x(x) }
            animation.startAnimation(afterDelay: delay)
        }
    }
    
    //MARK: - y
    func animate(y: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        if y != self.y{
            let animation = UIViewPropertyAnimator(duration: duration,
                                                   timingParameters: curve)
            animation.addAnimations { self.y(y) }
            animation.startAnimation(afterDelay: delay)
        }
    }
    
    //MARK: - width
    func animate(width: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        if width != self.width{
            
            let animation = UIViewPropertyAnimator(duration: duration,
                                                   timingParameters: curve)
            animation.addAnimations { self.width(width) }
            animation.startAnimation(afterDelay: delay)
        }
    }
    
    //MARK: - height
    func animate(height: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration,
                                               timingParameters: curve)
        if height != self.height{
            animation.addAnimations { self.height(height) }
            animation.startAnimation(afterDelay: delay)
        }
    }
    
    //MARK: - position
    func animate(position: CGPoint,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration,
                                               timingParameters: curve)
        animation.addAnimations { self.position(position) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - transform
    func animate(transform: CGAffineTransform,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration,
                                               timingParameters: curve)
        animation.addAnimations { self.transform(transform) }
        animation.startAnimation(afterDelay: delay)
    }
    
    func animate(width: CGFloat,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.width(width)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    func animate(x: CGFloat,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.x(x)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    func animate(y: CGFloat,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.y(y)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    func animate(height: CGFloat,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.height(height)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    func animate(position: CGPoint,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.position(position)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - transform3D
    func animate(transform3D: CATransform3D,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.transform3D(transform3D) }
        animation.startAnimation(afterDelay: delay)
    }
    func animate(transform3D: CATransform3D,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.transform3D(transform3D)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - transformX
    func animate(transformX: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let transform = CGAffineTransform(x: transformX)
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.transform(transform) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - transformY
    func animate(transformY: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let transform = CGAffineTransform(y: transformY)
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.transform(transform) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - transform
    func animate(transform: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let transform = CGAffineTransform(y: transform)
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.transform(transform) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - transformPoint
    func animate(transformPoint: CGPoint,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let transform = CGAffineTransform(transformPoint.x, transformPoint.y)
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.transform(transform) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - size
    func animate(size: CGSize,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.size(size) }
        animation.startAnimation(afterDelay: delay)
    }
    func animate(size: CGSize,
                 _ duration: CFTimeInterval,
                 _ ratio: CGFloat,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
            self.size(size)
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - opacity
    func animate(opacity: CGFloat,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.opacity(opacity) }
        animation.startAnimation(afterDelay: delay)
    }
    
    //MARK: - backgroundColor
    func animate(backgroundColor: UIColor,
                 _ duration: CFTimeInterval,
                 _ curve: UITimingCurveProvider,
                 _ delay: CFTimeInterval = 0){
        let animation = UIViewPropertyAnimator(duration: duration, timingParameters: curve)
        animation.addAnimations { self.backgroundColor(backgroundColor) }
        animation.startAnimation(afterDelay: delay)
    }
    
    
    //MARK: - Transition
    //    .TransitionFlipFromLeft
    //    .TransitionFlipFromRight
    //    .TransitionCurlUp
    //    .TransitionCurlDown
    //    .TransitionCrossDissolve
    //    .TransitionFlipFromTop
    //    .TransitionFlipFromBottom
    func flip(_ toView: UIView, _ duration: CFTimeInterval) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: self, duration: duration, options: transitionOptions, animations: {
            self.isHidden = true
        })
        UIView.transition(with: toView, duration: duration, options: transitionOptions, animations: {
            self.isHidden = false
        })
    }
    
    //    func animate(transform: CGAffineTransform,
    //                 _ duration: CFTimeInterval,
    //                 _ ratio: CGFloat,
    //                 _ delay: CFTimeInterval = 0){
    //        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: ratio) {
    //            self.transform(transform)
    //        }
    //        animation.startAnimation(afterDelay: delay)
    //    }
    
    
}
