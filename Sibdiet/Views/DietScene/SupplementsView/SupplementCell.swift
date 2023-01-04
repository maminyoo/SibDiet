//
//  SupplementCell.swift
//  Sibdiet
//
//  Created by amin sadeghian on 1/1/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class SupplementCell: UIView {
    var enable = true
    var selected = false
    
    var baseTitles = String()
    func baseTitle(_ title: String){
        self.baseTitles = title
    }
    
    var title = String()
    func title(_ title: String){
        self.title = title
    }
    
    var titleInP = String()
    func titleInP(_ title: String){
        self.titleInP = title
    }
    
    var descriptions: String!
    func descriptions(_ des: String){
        self.descriptions = des
    }
    
    var color = UIColor()
    func color(_ color: UIColor){
        self.color = color
    }
    
    var corner = CGFloat()
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var minHeight = CGFloat()
    func minHeight(_ minHeight : CGFloat){
        self.minHeight = minHeight
    }
    
    var maxHeight: CGFloat!
    func maxHeight(_ maxHeight: CGFloat){
        self.maxHeight = maxHeight
    }
    
    let backgroudPlusWidth: CGFloat = 55
    let duration : CFTimeInterval = 0.6
    
    //MARK: INIT VIEW
    func initView(){
        maxHeight = maxHeight - 6
        setBackground()
        deSelect()
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackground(){
        background.frame(isRTL ? 5 : -(backgroudPlusWidth+5), 1, width+backgroudPlusWidth, minHeight-2)
        background.backgroundColor(color)
        background.shadow(CGSize(isRTL ? -2 : 2, 0), gray15, 3, 0)
        background.cornerRadius(corner)
        setForeground()
        setBaseTitle()
        setTitleText()
        addSubview(background)
    }
    
    //MARK: FOREGROUND
    var foreground = UIView()
    func setForeground(){
        foreground.frame(isRTL ? 2 : -2, 0, background.width, background.height)
        foreground.backgroundColor(gray00)
        foreground.shadow(CGSize(isRTL ? -1 : 1, 0), gray08, 0.3, 1)
        foreground.cornerRadius(corner)
        setBetweenView()
        setUpView()
        background.addSubview(foreground)
    }
    
    //MARK: BETWEEN VIEW
    var betweenView = UIView()
    func setBetweenView(){
        betweenView.frame(isRTL ? 0 : backgroudPlusWidth+11,
                          0,
                          background.width-backgroudPlusWidth-12,
                          background.height)
        betweenView.cornerRadius(corner)
        betweenView.clipsToBounds(true)
        setDescriptionText()
        settitleInP()
        foreground.addSubview(betweenView)
    }
    
    //MARK: UP VIEW
    var upView = UIView()
    func setUpView(){
        upView.frame(0, 0, foreground.width, foreground.height+1)
        upView.cornerRadius(corner)
        upView.backgroundColor(gray01)
        upView.shadow(CGSize(isRTL ? 1 : -1, 1), gray08, 1, 0.6)
        foreground.addSubview(upView)
    }
    
    //MARK: BASE TITLE
    var baseTitle = UILabel()
    func setBaseTitle(){
        let ttl = baseTitles.replace(["(تست است)" : ""])
        let font = UIFont(Sahel_Bold, is5 ? 14 : 16)!
        let width = ttl.width(height: 20, font: font)+6
        baseTitle.frame(isRTL ? self.width-width-5 : backgroudPlusWidth+3, 0, width, 20)
        baseTitle.font(font)
        baseTitle.textColor(color)
        baseTitle.text(ttl)
        baseTitle.opacity(0.5)
        baseTitle.textAlignment(.center)
        baseTitle.shadow(.zero, gray07, 0.3, 0.8)
        baseTitle.clipsToBounds(true)
        background.addSubview(baseTitle)
    }
    
    //MARK: TITLE
    var titleText = UILabel()
    func setTitleText(){
        let font = UIFont(Sahel, is5 ? 17 : 21)!
        let y: CGFloat = is5 ? 18 : 20
        let width = betweenView.width-20
        let x: CGFloat = isRTL ?
            background.width/2 - width/2 - backgroudPlusWidth/2 :
            background.width/2 - width/2 + backgroudPlusWidth/2 ,
        height: CGFloat = !is5 ? 29 : 22
        titleText.frame(x, y, width, height)
        titleText.font(font)
        titleText.textColor(gray07)
        titleText.textAlignment(.center)
        titleText.adjustsFontSizeToFitWidth(true)
        titleText.text(title)
        titleText.opacity(0.5)
        background.addSubview(titleText)
    }
    
    //MARK: EN TITLE
    var titleInPText = UILabel()
    func settitleInP(){
        let font = UIFont(Actor_Regular, 17)!
        let width = titleInP.width(height: 20, font: font)
        titleInPText.frame = CGRect(isRTL ? 25 : betweenView.width - width - 25, maxHeight-20, width, 20)
        titleInPText.text(titleInP)
        titleInPText.font(font)
        titleInPText.textColor(gray07)
        titleInPText.textAlignment(.center)
        betweenView.addSubview(titleInPText)
    }
    
    //MARK: DESCRIPTION
    var descriptionText = UITextView()
    func setDescriptionText(){
        let isPersian = descriptions.isPersianString
        descriptionText.frame(isRTL ? 20 : 5,
                              minHeight-1,
                              betweenView.width-25,
                              maxHeight-minHeight+2)
        descriptionText.isEditable(false)
        descriptionText.isSelectable(false)
        descriptionText.backgroundColor(.clear)
        descriptionText.text(descriptions)
        descriptionText.font(Sahel, 18)
        descriptionText.textColor(gray07)
        descriptionText.textAlignment(isPersian ? .right : .left)
        betweenView.addSubview(descriptionText)
    }
    
    //MARK: SELECT
    func select(){
        selected = true
        enable = false
        background.layer.animate(shadowOpacity: 1, duration, easeInOut05)
        background.animate(transform: .identity, duration, curve)
        background.animate(height: maxHeight, duration, curve)
        background.animate(y: maxHeight/2 + 3, duration, curve)
        foreground.animate(height: maxHeight, duration, curve)
        foreground.animate(y: background.height/2, duration, curve)
        foreground.animate(transformX: isRTL ? 5 : -5, duration, curve)
        upView.animate(backgroundColor: gray0, duration, curve)
        baseTitle.animate(opacity: 1, 0.6, curve)
        baseTitle.animate(transform: CGAffineTransform(isRTL ? -2 : 2 , 2) , duration, curve)
        betweenView.animate(height: maxHeight, duration, curve)
        betweenView.animate(y: background.height/2, duration, curve)
        titleText.animate(opacity: 1, duration, curve)
        titleInPText.animate(opacity: 1, duration, curve)
    }
    
    //MARK: DESELECT
    func deSelect(){
        selected = false
        let height = minHeight - 1
        background.layer.animate(shadowOpacity: 0, duration, easeInOut05)
        background.animate(transformX: isRTL ? 10 : -10, duration, curve)
        background.animate(height: height , duration, curve)
        background.animate(y: minHeight/2 , duration, curve)
        foreground.animate(height: height, duration, curve)
        foreground.animate(y: height/2, duration, curve)
        foreground.animate(transform: .identity, duration, curve)
        upView.animate(backgroundColor: gray01, duration, curve)
        baseTitle.animate(opacity: 0.6, duration, curve)
        baseTitle.animate(transformX: isRTL ? -10 : 11, duration, curve)
        betweenView.animate(height: height, duration, curve)
        betweenView.animate(y: height/2, duration, curve)
        titleText.animate(opacity: 0.5, duration, curve)
    }
}
