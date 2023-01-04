//
//  CoreGraphicEX.swift
//  Sibdiet
//
//  Created by Amin on 3/31/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

//MARK: CGPoint
extension CGPoint {
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
  var cgSize: CGSize {
    return CGSize(width: x, height: y)
  }
  
  func absolutePoint(in rect: CGRect) -> CGPoint {
    return CGPoint(x: x * rect.size.width, y: y * rect.size.height) + rect.origin
  }
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}


//MARK: CGRect
extension CGRect{
    
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat){
        self.init(x: x, y: y, width: width, height: height)
    }
    
    var minXminY: CGPoint { CGPoint(minX, minY) }
    var minXmidY: CGPoint { CGPoint(minX, midY) }
    var minXmaxY: CGPoint { CGPoint(minX, maxY) }
    var midXminY: CGPoint { CGPoint(midX, minY) }
    var midXmidY: CGPoint { CGPoint(midX, midY) }
    var midXmaxY: CGPoint { CGPoint(midX, maxY) }
    var maxXminY: CGPoint { CGPoint(maxX, minY) }
    var maxXmidY: CGPoint { CGPoint(maxX, midY) }
    var maxXmaxY: CGPoint { CGPoint(maxX, maxY) }
}

//MARK: UICubicTimingParameters
extension UICubicTimingParameters{
    convenience init(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        self.init(CGPoint(x1, y1), CGPoint(x2, y2))
    }
    convenience init(_ point1: CGPoint, _ point2: CGPoint) {
        self.init(controlPoint1: point1, controlPoint2: point2)
    }
}

//MARK: CAMediaTimingFunction
extension CAMediaTimingFunction{
    convenience init(_ x1: Float, _ y1: Float, _ x2: Float, _ y2: Float) {
        self.init(controlPoints: x1, y1, x2, y2)
    }
}

//MARK: CGSize
extension CGSize{
    var cgPoint: CGPoint {
        return CGPoint(x: width, y: height)
    }
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}

//MARK: UIFont
extension UIFont{
    convenience init?(_ name: String, _ size: CGFloat) {
        self.init(name: name, size: size)
    }
}

//MARK: CGAffineTransform
extension CGAffineTransform{
    init(_ x: CGFloat,_ y: CGFloat){
        self.init(translationX: x, y: y)
    }
    
    init(rotationDegrees: CGFloat){
        self.init(rotationAngle: degreesToRadians(rotationDegrees))
    }
    
    init(x: CGFloat){
        self.init(translationX: x, y: 0)
    }
    
    init(y: CGFloat){
        self.init(translationX: 0, y: y)
    }
}


func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    CGFloat(Double(degrees) * Double.pi / 180.0)
}

func radiansToDegrees(_ radians: CGFloat) -> CGFloat {
    CGFloat(Double(radians) / Double.pi * 180.0)
}


let delay:[CFTimeInterval] = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,
                              0.9, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7,
                              1.8, 1.9, 2.0,2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7,
                              2.8, 2.9, 3.0, 3.1, 3.2, 3.3, 3.4]
let oddDelay:[CFTimeInterval] = [0, 0.1, 0, 0.1, 0.2, 0.3, 0.2, 0.3, 0.4, 0.5,
                                 0.4, 0.5, 0.6, 0.7, 0.6, 0.7, 0.8, 0.9, 0.8,
                                 0.9, 1.0, 1.1, 1.0, 1.1, 1.2, 1.3, 1.2, 1.3, 1.4, 1.5, 1.4]
