//
//  DietCell.swift
//  Sibdiet
//
//  Created by amin sadeghian on 10/28/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import QuartzCore
import UIKit

class DietCell: UIView{
    
    var newY = CGFloat()
    var colors = [CGColor]()
    var title = String()
    var font = Sahel as CFString
    
    func initView(){
        setTextTitle()
        setGradient()
    }
    
    var textTitle = CATextLayer()
    func setTextTitle(){
        textTitle.frame(10, newY, WIDTH - 20, 24)
        textTitle.foregroundColor(gray07)
        textTitle.font = font
        textTitle.string(title)
        textTitle.fontSize = isRTL ? 17 : 18
        textTitle.alignmentMode(.center)
        textTitle.contentsScale()
        layer.insertSublayer(textTitle, at: 1)
    }
    
    var gradient = CAGradientLayer()
    func setGradient(){
        gradient.frame(10, textTitle.y - textTitle.height, WIDTH-20, 46)
        gradient.colors = colors
        gradient.startPoint(0, 0)
        gradient.endPoint(0, 1)
        gradient.locations([0, 1])
        gradient.cornerRadius(7)
        gradient.opacity(0.9)
        gradient.shadow(CGSize(0, 0.5), gray08, 1, 0.7)
        layer.insertSublayer(gradient, at: 0)
    }
}

