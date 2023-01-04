//
//  UIViewEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 9/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

extension UIView {
    var position: CGPoint{ get{ layer.position } set{ layer.position = newValue } }
    func position(_ point: CGPoint){
        layer.position = point
    }
    
    func position(_ x: CGFloat, _ y: CGFloat){
        layer.position = CGPoint(x, y)
    }
    
    var minY: CGFloat { frame.minY }
    var maxY: CGFloat { frame.maxY }
    var midY: CGFloat { frame.midY }
    var maxX: CGFloat { frame.maxX }
    var minX: CGFloat { frame.minX }
    var midX: CGFloat { frame.midX }
        
    var x: CGFloat{ get{ position.x } set{position.x = newValue} }
    func x(_ x: CGFloat){
        self.x = x
    }
    
    var y: CGFloat{ get{ position.y } set{ position.y = newValue } }
    func y(_ y: CGFloat){
        self.y = y
    }
    
    var z: CGFloat{ get{ layer.zPosition } set{ layer.zPosition = newValue } }
    func z(_ z: CGFloat){
        self.z = z
    }
    
    var size: CGSize{ get{ bounds.size } set{ bounds.size = newValue } }
    func size(_ size: CGSize){
        self.size = size
    }
    
    var width: CGFloat{ get{ size.width } set{ size.width = newValue } }
    func width(_ width: CGFloat){
        self.width = width
    }
    
    var height: CGFloat{ get{ size.height } set{ size.height = newValue } }
    func height(_ height: CGFloat){
        self.height = height
    }
    
    func isHidden(_ bool: Bool){
        isHidden = bool
    }
    
    var opacity: CGFloat{ get{ alpha } set{ alpha = newValue } }
    func opacity(_ alpha: CGFloat){
        opacity = alpha
    }
    
    func tag(_ int: Int){
        tag = int
    }
    
    func transform(_ transform: CGAffineTransform){
        self.transform = transform
    }
    
    func transformR(_ r: CGFloat){
        self.transform = CGAffineTransform(rotationDegrees: r)
    }
    
    func transformP(_ x: CGFloat, _ y: CGFloat){
        self.transform = CGAffineTransform(x, y)
    }
    
    func transformY(_ y: CGFloat){
        self.transform = CGAffineTransform(y: y)
    }
    
    func transformX(_ x: CGFloat){
        self.transform = CGAffineTransform(x: x)
    }
    
    func backgroundColor(_ color: UIColor){
        backgroundColor = color
    }
    
    func clipsToBounds(_ bool: Bool){
        clipsToBounds = bool
    }
    
    func frame(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat){
        frame = CGRect(x, y, width, height)
    }
    
    func frame(_ frame: CGRect){
        self.frame = frame
    }
    
    convenience init(_ frame: CGRect){
        self.init(frame: frame)
    }
    
    var shadowColor: CGColor{ get{ layer.shadowColor! } set{ layer.shadowColor = newValue } }
    var shadowRadius: CGFloat{ get{ layer.shadowRadius } set{ layer.shadowRadius = newValue } }
    var shadowOpacity: Float{ get{ layer.shadowOpacity } set{ layer.shadowOpacity = newValue } }
    var shadowOffset: CGSize{ get{ layer.shadowOffset } set{ layer.shadowOffset = newValue } }
    var shadowPath: CGPath{ get{ layer.shadowPath! } set{ layer.shadowPath = newValue } }
    func shadow(_ offset: CGSize,_ color: UIColor,_ radius: CGFloat,_ opacity: CGFloat){
        shadowOffset = offset
        shadowColor = color.cgColor
        shadowRadius = radius
        shadowOpacity = Float(opacity)
    }
    
    var transform3D: CATransform3D{ get{ layer.transform } set{ layer.transform = newValue } }
    func transform3D(_ transform3D: CATransform3D){
        self.transform3D = transform3D
    }
    
    var borderWidth: CGFloat{ get{ layer.borderWidth } set{ layer.borderWidth = newValue } }
    var borderColor: CGColor{ get{ layer.borderColor! } set{ layer.borderColor = newValue } }
    func border(_ color: UIColor, _ width: CGFloat){
        borderColor = color.cgColor
        borderWidth = width
    }
    
    var cornerRadius: CGFloat{ get{ layer.cornerRadius } set{ layer.cornerRadius = newValue } }
    func cornerRadius(_ radius: CGFloat){
        cornerRadius = radius
    }
    
    var anchorPoint: CGPoint{ get{ layer.anchorPoint } set{ layer.anchorPoint = newValue } }
    func anchorPoint(_ point: CGPoint){
        anchorPoint = point
    }
    
    func mask(_ mask: UIView){
        self.mask = mask
    }
    
    func addSublayer(_ layer: CALayer){
        self.layer.addSublayer(layer)
    }
    
    func addSublayer(_ layer: CALayer, _ at: UInt32){
        self.layer.insertSublayer(layer, at: at)
    }
    
    func addSubview(_ view: UIView, _ at: Int = 0){
        insertSubview(view, at: at)
    }
    
    func addSubview(_ view: UIView, below: UIView){
        insertSubview(view, belowSubview: below)
    }
    
    func addSubview(_ view: UIView, above: UIView){
        insertSubview(view, aboveSubview: above)
    }
    
    func remove(){
        removeFromSuperview()
    }
    
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(width * point.x, height * point.y)
        var oldPoint = CGPoint(width * anchorPoint.x, height * anchorPoint.y);
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        var position = layer.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        layer.position = position
        anchorPoint = point
    }
    
    func CGPointDistanceSquared(_ to: CGPoint) -> CGFloat {
        (x - to.x) * (x - to.x) + (y - to.y) * (y - to.y)
    }
    
    var CGPointDistance: CGFloat {
        sqrt(CGPointDistanceSquared(position))
    }

}
