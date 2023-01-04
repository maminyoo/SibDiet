//
//  BodySliderHelpView.swift
//  Sibdiet
//
//  Created by freeman on 11/29/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class BodySliderHelpView: UIView{
    
    var title = String()
    func setTitle(_ string: String){
        title = string
    }
    
    func initView(){
        setHelp()
        startView()
    }
    
    let label = UILabel()
    let labelView = UIView()
    func setHelp() {
        labelView.frame(15, height/2-25, width-30, 64)
        label.frame(labelView.bounds)
        label.text(title)
        label.font(Sahel_Bold, 18)
        label.textColor(gray06)
        label.backgroundColor(white.opacity(0.5))
        label.border(white, 2)
        label.textAlignment(.center)
        label.cornerRadius(15)
        label.clipsToBounds(true)
        labelView.opacity(0)
        labelView.transformY(120)
        labelView.addSubview(label)
        labelView.shadow(.zero, gray07, 9, 0.5)
        addSubview(labelView)
    }
    
    let duration: CFTimeInterval = 1
    func startView(){
        let delay: CFTimeInterval = 0.5
        labelView.animate(opacity: 1, duration, curve, duration+delay)
        labelView.animate(transform: .identity, duration, curve, duration+delay)
        backgroundColor(white.opacity(0.2))
        opacity(0)
        animate(opacity: 1, duration, curve, duration+delay)
        backgroundColor(.clear)
        if iOS14{
            animate(backgroundColor: gray12.opacity(0.3), 1, curveEaseInOut05)
        }else{
            blurBack(2, duration, duration+delay)
        }
    }
    
    @objc func closeView(){
        label.animate(transformY: -120, duration, curve)
        animate(opacity: 0, duration, curve)
        unBlur(duration)
    }
    
}
