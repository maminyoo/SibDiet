//
//  BarButton.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/16/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class BarButton: UIView{
    
    var selected = false
    func selected(_ bool: Bool){
        self.selected = bool
    }
    
    var enable = true
    func enable(_ bool: Bool){
        self.enable = bool
    }
    
    var text = String()
    func text(_ string: String){
        self.text = string
    }
    
    var font = UIFont(Samim,  14)
    func font(_ font: UIFont){
      self.font = font
    }
    
    var image01 = UIImage()
    func image01(_ string: String){
        self.image01 = UIImage(string)!
    }
    
    var image02 = UIImage()
    func image02(_ string: String){
        self.image02 = UIImage(string)!
    }
    
    //MARK: INIT VIEW
    func initView(){
        setImageOne()
        setImageTwo()
        setTitle()
        if selected{ selectedButton() }
    }
    
    //MARK: IMEGE ONE
    var imageOne = CALayer()
    func setImageOne(){
        imageOne.frame(width/2 - 16, 2, 32, 32)
        imageOne.contents(image01)
        imageOne.contentsGravity(.resizeAspect)
        addSublayer(imageOne, 2)
    }
    
    //MARK: IMEGE TWO
    var imageTwo = CALayer()
    func setImageTwo(){
        imageTwo.frame(width/2 - 16, 2, 32, 32)
        imageTwo.contents(image02)
        imageTwo.opacity(0)
        imageTwo.contentsGravity(.resizeAspect)
        addSublayer(imageTwo, 2)
    }
    
    //MARK: TITLE
    var title = UILabel()
    func setTitle(){
        let width = text.width(height: 16, font: font!) + 5
        title.frame(self.width/2 - width/2, height-17, width, 18)
        title.text(text)
        title.textColor(barButtonTitleColor)
        title.font(font!)
        title.textAlignment(.center)
        addSubview(title)
    }
    
    //MARK: SELECTED
    func selectedButton(){
        enable(false)
        title.textColor(green)
        imageOne.animate(opacity: 0, 0.7, easeInOut05)
        imageTwo.animate(opacity: 1, 0.7, easeInOut05)
        var _ = Timer.schedule(1) { _ in self.enable(true) }
    }
    
    //MARK: DESELECTED
    func deSelectButton(){
        selected = false
        enable(true)
        title.textColor(barButtonTitleColor)
        imageOne.animate(opacity: 1, 0.7, easeInOut05)
        imageTwo.animate(opacity: 0, 0.7, easeInOut05)
    }
}
