//
//  CALayerEX.swift
//  .Studio extension
//
//  Created by amin sadeghian on 9/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

extension CALayer{
    var x:CGFloat{ get{position.x} set{position.x = newValue} }
    func x(_ x: CGFloat){
        self.x = x
    }
    
    var y:CGFloat{ get{position.y} set{position.y = newValue} }
    func y(_ y: CGFloat){
        self.y = y
    }
    
    var height: CGFloat { get{bounds.size.height} set{bounds.size.height = newValue} }
    func height(_ height: CGFloat){
        self.height = height
    }
    
    var width: CGFloat{ get{bounds.size.width} set{bounds.size.width = newValue} }
    func width(_ width: CGFloat){
        self.width = width
    }
    
    func frame(_ x: CGFloat,_ y: CGFloat, _ width: CGFloat, _ height: CGFloat){
        frame = CGRect(x, y, width, height)
    }
    
    func frame(_ frame: CGRect){
        self.frame = frame
    }
    
    func cornerRadius(_ radius: CGFloat){
        cornerRadius = radius
    }
    
    func shadow(_ offset: CGSize,_ color: UIColor,_ radius: CGFloat,_ opacity: CGFloat){
        shadowOffset = offset
        shadowColor = color.cgColor
        shadowRadius = radius
        shadowOpacity = Float(opacity)
    }
    
    func backgroundColor(_ color: UIColor){
        backgroundColor = color.cgColor
    }
    
    func border(_ color: UIColor, _ width: CGFloat){
        borderColor = color.cgColor
        borderWidth = width
    }
    
    func opacity(_ alpha: CGFloat){
        opacity = Float(alpha)
    }
    
    func isHidden(_ bool: Bool){
        isHidden = bool
    }
    
    func mask(_ mask: CALayer){
        self.mask = mask
    }
    
    func contents(_ image: UIImage){
        contents = image.cgImage
    }
    
    func image(_ image: UIImage){
        contents = image.cgImage
    }
    
    func contentsGravity(_ gravity: CALayerContentsGravity){
        contentsGravity = gravity
    }
    
    func CGPointDistanceSquared(_ to: CGPoint) -> CGFloat {
        (x - to.x) * (x - to.x) + (y - to.y) * (y - to.y)
    }
    
    func CGPointDistance(_ to: CGPoint) -> CGFloat {
        sqrt(CGPointDistanceSquared(to))
    }
    
    func transform(_ transform : CATransform3D){
        self.transform  = transform
    }
    
    func masksToBounds(_ bool : Bool){
        masksToBounds = bool
    }
}
