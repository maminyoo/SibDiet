//
//  SibClinicDietView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 6/1/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class SibDietView : UIView{
    
    var textColor = gray06
    func textColor(_ color: UIColor){
        self.textColor = color
    }
    
    let font = JosefinSans
    let fontSize: CGFloat = 34
    
    //MARK: INIT VIEW
    func initView(){
        setLine()
        setText()
        startView()
    }
    
    //MARK: LINE
    var line = CAGradientLayer()
    let overGradient = CAGradientLayer()
    var horizontalLineOriginY: CGFloat!
    func setLine(){
        line.frame(0, height, width, 2)
        line.colors([gray01, gray04, gray01])
        line.locations([0, 0.5, 1])
        line.startPoint(0, 0)
        line.endPoint(1, 0)
        line.opacity(0)
        horizontalLineOriginY = line.y
        overGradient.frame(0, 1, width, 1)
        overGradient.colors([gray01, white01, gray01])
        overGradient.locations([0.20, 0.5, 0.80])
        overGradient.startPoint(0, 0)
        overGradient.endPoint(1, 0)
        line.addSublayer(overGradient)
        addSublayer(line, 1)
    }
    
    //MARK: BACK TEXT
    var backText = CATextLayer()
    func setText(){
        backText.frame(20, -4, width-40, 37)
        backText.string(SibDiet)
        backText.font(font, fontSize)
        backText.foregroundColor(gray0)
        backText.alignmentMode(.center)
        backText.contentsScale()
        backText.shadow(CGSize(0.5, 0.5), gray13, 0.5, 1)
        setTextMask()
        backText.mask(textMask)
        addSublayer(backText, 3)
        setOverText()
    }
    
    //MARK: OVER TEXT
    var overText = CATextLayer()
    func setOverText(){
        overText.frame(backText.bounds)
        overText.font(font, fontSize)
        overText.string(SibDiet)
        overText.foregroundColor(white)
        overText.contentsScale()
        overText.alignmentMode(.center)
        let mask = CALayer()
        mask.backgroundColor(sand01)
        mask.frame(overText.bounds)
        let y = mask.y
        mask.y(y+height/2+2)
        overText.mask(mask)
        backText.addSublayer(overText)
    }
    
    var textMask = CAShapeLayer()
    var sibClinicDietMaskOrigin: CATransform3D!
    func setTextMask(){
        textMask.frame(backText.bounds)
        textMask.masksToBounds(true)
        sibClinicDietMaskOrigin = textMask.transform
        textMask.backgroundColor(blue)
    }
    
    //MARK: START VIEW
    var enable = false
    func startView(){
        enable = true
        line.y(horizontalLineOriginY - backText.height)
        line.animate(scale: CGSize(0, 1), 0, easeOut06)
        line.animate(scale: CGSize(1, 1), 1.3, easeInOut05)
        line.animate(opacity: 1, 1, easeOut05)
        line.animate(y: horizontalLineOriginY - 2, 0.9, easeIn04, 1.5)
        line.animate(y: horizontalLineOriginY, 0.4, easeOut02, 2.4)
        line.animate(locations: [0.20, 0.5, 0.80], 1.1, easeInOut04, 1.5)
        line.animate(colors: [gray01, gray05, gray01], 2, easeInOut05, 1.5)
        backText.animate(foregroundColor: green01, 5, easeOut05, 3)
        overText.animate(foregroundColor: green01, 5, easeOut05, 3)
        textMask.transform(CATransform3DTranslate(sibClinicDietMaskOrigin, 0, -textMask.height, 0))
        textMask.animate(transform3D: sibClinicDietMaskOrigin, 0.9, easeIn04, 1.5)
    }
   
    //MARK: CLOSE VIEW
    func closeView(){
        if enable{
            enable = false
            line.animate(y: horizontalLineOriginY - 7, 0.2, easeIn04)
            line.animate(y: horizontalLineOriginY - backText.height, 0.4, easeOut04, 0.2)
            line.animate(locations: [0, 0.5, 1], 0.6, easeInOut05)
            line.animate(locations: [0.47, 0.5, 0.53], 0.9, easeInOut05, 0.6)
            line.animate(opacity: 0, 0.5,  easeIn04, 0.6)
            line.animate(scale: CGSize(0.4, 1), 0.6, easeIn04, 0.6)
            line.animate(colors: [gray01, gray01, gray01], 0.6, easeInOut05, 0.6)
            line.animate(opacity: 0, 0.5, easeInOut, 0.3)
            let sibDietClinicY = CATransform3DTranslate(sibClinicDietMaskOrigin, 0, -textMask.height, 0)
            textMask.animate(transform3D: sibDietClinicY, 0.4, easeOut04, 0.2)
            var _ = Timer.schedule(1.5) { _ in self.remove() }
        }
    }
}
