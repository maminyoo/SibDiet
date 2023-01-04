//
//  ConnectionAlarmView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 6/20/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class AlarmView: UIView{
    
    var enable =  false
    
    //MARK: INIT VIEW
    func initView(){
        if !enable{
            setBg()
            showView()
        }
    }
    
    //MARK: BG
    var bg = UIView()
    func setBg(){
        bg.frame(bounds)
        bg.shadow(CGSize(0, 1), gray09, 1, 0.7)
        setGradient()
        setLabel()
        addSubview(bg)
    }
    
    //MARK: GRADIENT
    var gradient = CAGradientLayer()
    func setGradient(){
        gradient.frame(bg.bounds)
        gradient.colors([red01, red02])
        gradient.startPoint(0, 1)
        gradient.endPoint(0, 0)
        bg.addSublayer(gradient)
    }
    
    //MARK: LABEL
    var label = UILabel()
    func setLabel(){
        label.frame(10, bg.height - 40,width-20, 20)
        label.text = !isFA ? CONNECTION_ERROR_EN :  CONNECTION_ERROR_FA
        label.font = !isFA ? UIFont(HelveticaNeue,  20) : UIFont(Traffic, 20)
        label.textAlignment(.center)
        label.textColor(gray0)
        bg.addSubview(label)
    }
    
    //MARK: START VIEW
    func showView(){
        enable = true
        bg.transformY(-bg.height)
        bg.animate(transform: .identity, 0.7, curve)
        var _ = Timer.schedule(3) { _ in self.closeView() }
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        enable = false
        bg.animate(transformY: -bg.height, 0.7, curveEaseInOut05)
        var _ = Timer.schedule(1) {_ in self.remove() }
    }
}
