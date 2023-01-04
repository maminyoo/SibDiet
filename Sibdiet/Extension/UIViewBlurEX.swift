//
//  UIViewBlurEX.swift
//  Sibdiet
//
//  Created by Me on 9/1/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

extension UIView {
    
    func blur(_ radius: CGFloat , _ duration: CFTimeInterval, _ delay: CFTimeInterval = 0) {
        let blurEffectView = VisualEffectView(frame: self.bounds)
        blurEffectView.blurRadius = 0
        self.addSubview(blurEffectView)
        UIView.animate(withDuration: duration, delay: delay, options: [UIView.AnimationOptions.curveEaseInOut], animations: {
            blurEffectView.blurRadius = radius
        }, completion: nil)
    }
    
    func blurBack(_ radius: CGFloat , _ duration: CFTimeInterval, _ delay: CFTimeInterval = 0) {
        let blurEffectView = VisualEffectView(frame: self.bounds)
        blurEffectView.blurRadius = 0
        self.insertSubview(blurEffectView, at: 0)
        UIView.animate(withDuration: duration, delay: delay, options: [UIView.AnimationOptions.curveEaseInOut], animations: {
            blurEffectView.blurRadius = radius
        }, completion: nil)
    }
    
    func blurFullBack(_ radius : CGFloat , _ duration : CFTimeInterval,  _ delay : CFTimeInterval = 0) {
        let blurEffectView = VisualEffectView(frame: UIScreen.main.bounds)
        blurEffectView.blurRadius = 0
        self.insertSubview(blurEffectView, at: 0)
        UIView.animate(withDuration: duration, delay: delay, options: [UIView.AnimationOptions.curveEaseInOut], animations: {
            blurEffectView.blurRadius = radius
        }, completion: nil)
    }
    
    func unBlur(_ duration : CFTimeInterval, _ delay : CFTimeInterval = 0) {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                UIView.animate(withDuration: duration, delay: delay, options: [UIView.AnimationOptions.curveEaseOut], animations: {
                    subview.alpha = 0
                }, completion:{ (true) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
}
