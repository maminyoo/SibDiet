//
//  WeekButton.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/3/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class Button: UIView{
    
    var selected = false
    func selected(_ bool: Bool){
        selected = bool
    }
    
    var title = String()
    func title(_ title: String){
        self.title = title
    }
    
    var newFont = UIFont(Sahel, 17)
    func font(_ font: UIFont){
        newFont = font
    }
    
    //MARK: INIT VIEW
    func initView(){
        setBackground()
        if selected{ select() }else{ deSelect() }
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackground(){
        background.frame(5, 7, width - 10, height - 12)
        background.clipsToBounds(true)
        setGradient()
        setGrayTitleText()
        setWhiteTitleText()
        addSubview(background)
    }
    
    //MARK: GRADIENT
    var gradient = CAGradientLayer()
    func setGradient(){
        gradient.frame(background.bounds)
        gradient.colors([gray01, gray02])
        gradient.startPoint(1, 0)
        gradient.endPoint(0, 1)
        gradient.border(white01, 1)
        gradient.cornerRadius(7)
        background.addSublayer(gradient)
    }
    
    //MARK: TITLE GRAY
    var grayTitleText = UILabel()
    func setGrayTitleText(){
        grayTitleText.frame(background.bounds)
        grayTitleText.font(newFont!)
        grayTitleText.text(title)
        grayTitleText.textColor(gray05)
        grayTitleText.textAlignment(.center)
        background.addSubview(grayTitleText)
    }
    
    //MARK: TITLE WHITE
    var whiteTitleText = UILabel()
    func setWhiteTitleText(){
        whiteTitleText.frame(background.bounds)
        whiteTitleText.font(newFont!)
        whiteTitleText.text(title)
        whiteTitleText.textColor(white)
        whiteTitleText.textAlignment(.center)
        background.addSubview(whiteTitleText)
    }

    var distance: CGFloat{ title.isNumber ? 0 : title.isPersianString ? 1 : -1 }
    
    //MARK: SELECT
    func select(){
        selected = true
        let c01 = UIColor(0x6dd5ed)
        let c02 = UIColor(0x2193b0)
        gradient.animate(colors: [c01, c02], 0.6, easeInOut05)
        grayTitleText.animate(y: -10, 0.35, curve)
        whiteTitleText.animate(y: background.height/2-distance, 0.35, 0.6, 0.1)
    }
    
    //MARK: DESELECT
    func deSelect(){
        selected = false
        grayTitleText.animate(y: background.height/2-distance, 0.35, 0.6, 0.2)
        whiteTitleText.animate(y: background.height/2+22, 0.35, curve)
        gradient.animate(colors: [gray01, gray02], 0.6, easeInOut05)
    }
}
