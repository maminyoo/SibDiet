//
//  PersonCell.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class PersonCell: UIView{
    
    var person = [String: String]()
    func person(_ person: [String: String]){
        self.person = person
    }
    
    //MARK: NAME
    func initView(){
        setBack()
        setLine()
        setName()
        setFamily()
    }
    
    //MARK: BACKGROUND
    var back = CAGradientLayer()
    func setBack(){
        back.frame(bounds)
        back.colors([gray0, gray01])
        back.cornerRadius(10)
        addSublayer(back)
    }
    
    //MARK: LINE
    var line = CAGradientLayer()
    func setLine(){
        line.frame(isRTL ? width - width/3 : width/3,
                   0,
                   1.6,
                   height)
        line.colors([gray02, white])
        line.locations([0, 1])
        line.startPoint(0, 0)
        line.endPoint(1, 0)
        addSublayer(line)
    }
    
    //MARK: NAME
    var name = CATextLayer()
    func setName(){
        name.frame(isRTL ? width - width/3 + 10 : 10,
                   7,
                   width/3 - 20,
                   height)
        name.string(person[F_NAME]!)
        name.foregroundColor(gray06)
        name.font(Sahel_Bold, 21)
        name.alignmentMode(.center)
        name.contentsScale()
        addSublayer(name)
    }
    
    //MARK: FAMILY
    var family = UILabel()
    func setFamily(){
        family.frame(isRTL ? 10 : width/3 + 10,
                     0,
                     width/3 * 2 - 20,
                     height)
        family.text(person[L_NAME]!)
        family.textColor(gray06)
        family.font(Sahel_Bold, 21)
        family.textAlignment(.center)
        family.adjustsFontSizeToFitWidth(true)
        addSubview(family)
    }
}
