//
//  RadioCheckCell.swift
//  Sibdiet
//
//  Created by amin sadeghian on 3/17/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class RadioCheckCell: UIView{
    
    var title = String()
    func title(_ title: String){
        self.title = title
    }
    
    var mode = String()
    func mode(_ mode: String){
        self.mode = mode
    }
    
    var isRadio: Bool{ mode == RADIO || mode == RADIO_DES }
    var image1: UIImage{ isRadio ? UIImage(RADIO_01_IMG)! : UIImage(CHECK_01_IMG)! }
    var image2: UIImage{ isRadio ? UIImage(RADIO_02_IMG)! : UIImage(CHECK_02_IMG)! }
    
    var selected: Bool = false
    
    //MARK: INIT VIEW
    func initView(){
        setBackgroud()
        setTitleText()
        setTitleText02()
        setImage01()
        setImage02()
        deSelect()
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackgroud(){
        background.frame(2, 2, width-4, height-4)
        background.cornerRadius(8)
        addSubview(background)
    }
    
    //MARK: TITLE
    var titleText = UILabel()
    func setTitleText(){
        titleText.frame(5, 2, width-10, background.height)
        titleText.font(Sahel, 18)
        titleText.textColor(gray06)
        titleText.text(title)
        titleText.opacity(0.7)
        titleText.textAlignment(.center)
        titleText.adjustsFontSizeToFitWidth(true)
        addSubview(titleText)
    }
    
    //MARK: TITLE
    var titleText02 = UILabel()
    func setTitleText02(){
        titleText02.frame(5, 2, width-10, background.height)
        titleText02.font(Sahel_Bold, 18)
        titleText02.textColor(gray06)
        titleText02.text(title)
        titleText02.opacity(0)
        titleText02.textAlignment(.center)
        titleText02.adjustsFontSizeToFitWidth(true)
        addSubview(titleText02)
    }
    //MARK: IMAGE 01
    var image01 = UIImageView()    
    func setImage01(){
        image01.frame(isRTL ? 5 : width-18, 5, 12, 12)
        image01.opacity(0.5)
        image01.image(image1)
        addSubview(image01)
    }
    
    //MARK: IMAGE 02
    var image02 = UIImageView()
    func setImage02(){
        image02.frame(image01.frame)
        image02.image(image2)
        image02.opacity(0)
        addSubview(image02)
    }
    
    //MARK: SELECT
    func select(){
        selected = true
        image01.animate(opacity: 0, 0.7, curve)
        image02.animate(opacity: 1, 0.7, curve)
        background.animate(backgroundColor: white.opacity(0.7), 0.7, curve)
        titleText02.animate(opacity: 1, 0.7, curve)
        titleText.animate(opacity: 0, 0.7, curve)
    }
    
    //MARK: DESELECT
    func deSelect(){
        selected = false
        image01.animate(opacity: 1, 0.5, curve)
        image02.animate(opacity: 0, 0.5, curve)
        background.animate(backgroundColor: gray0.opacity(0.4), 0.7, curve)
        titleText02.animate(opacity: 0, 0.7, curve)
        titleText.animate(opacity: 0.7, 0.7, curve)
    }
}
