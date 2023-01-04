//
//  PrescriptionCell.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/28/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class PrescriptionCell: UIView{
    var selected = false
    var enable = true
    
    let freeAmount = NSMutableAttributedString()
    
    var baseTitles: String!
    func baseTitle(_ title: String){
        self.baseTitles = title
    }
    
    var title = String()
    func title(_ title: String){
        self.title = title
    }

    var amount = NSMutableAttributedString()
    func amount (_ amount: NSMutableAttributedString){
        self.amount = amount
    }
    
    var descriptions = String()
    func descriptions(_ des: String){
        self.descriptions = des
    }
    
    var color = UIColor()
    func color(_ color: UIColor){
        self.color = color
    }
    
    var images = String()
    func image(_ image: String){
        self.images = image
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
        if amount != freeAmount{
            setLine()
            setAmountText()
        }
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
        setImage()
        background.addSubview(foreground)
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
    
    //MARK: IMAGE
    var image = UIImageView()
    func setImage(){
        let x: CGFloat = isRTL ? 10 : foreground.width - 60,
        y: CGFloat = is5 ? 13 : 12,
        w: CGFloat = is5 ? 35 : 45
        image.frame(x, y, w, w)
        image.image(UIImage(images)!)
        image.contentMode(.scaleAspectFill)
        image.shadow(.zero, gray08, 3, 0.5)
        image.opacity(0.5)
        foreground.addSubview(image)
    }
    
    //MARK: BASE TITLE
    var baseTitle = UILabel()
    func setBaseTitle(){
        let font = UIFont(Sahel_Bold, is5 ? 14 : 16)!
        let width = baseTitles.width(height: 20, font: font)+6
        baseTitle.frame(isRTL ? self.width-width-5 : backgroudPlusWidth+3, 0, width, 20)
        baseTitle.font(font)
        baseTitle.textColor(color)
        baseTitle.text(baseTitles)
        baseTitle.opacity(0.5)
        baseTitle.textAlignment(.center)
        baseTitle.shadow(.zero, gray07, 0.3, 0.8)
        baseTitle.clipsToBounds(true)
        background.addSubview(baseTitle)
    }
    
    //MARK: TITLE
    var titleText = UILabel()
    func setTitleText(){
        let ttl = !isRTL && title == "کاهش  وزن" ? "Weight lose" : title
        let font = UIFont(Sahel, is5 ? 17 : 21)!
        let y: CGFloat = is5 ? 18 : 20
        var width = title.width(height: 26, font: font) + 10
        if width>betweenView.width/5*3{
            width = betweenView.width/5*3
        }
        let x: CGFloat = isRTL ?
            background.width/2 - width/2 - backgroudPlusWidth/2 :
            background.width/2 - width/2 + backgroudPlusWidth/2 ,
        height: CGFloat = !is5 ? 29 : 22
        titleText.frame(x, y, width, height)
        titleText.font(font)
        titleText.textColor(gray07)
        titleText.textAlignment(.center)
        titleText.adjustsFontSizeToFitWidth(true)
        titleText.text(ttl)
        titleText.opacity(0.5)
        background.addSubview(titleText)
    }
    
    //MARK: LINE
    var line = CAGradientLayer()
    func setLine(){
        let width: CGFloat =  titleText.width + 100
        line.frame(titleText.x - width/2, minHeight/2, width, 0.5)
        line.colors([UIColor.clear, gray04, UIColor.clear])
        line.locations([0.499, 0.5, 0.501])
        line.startPoint(0, 0)
        line.endPoint(1, 0)
        line.opacity(0)
        background.addSublayer(line)
    }
    
    //MARK: AMOUNT
    var amountText = UILabel()
    func setAmountText(){
        amountText.frame(line.x-(line.width*2)/2, titleText.y + 2, line.width*2, 28)
        amountText.attributedText(amount)
        amountText.textAlignment(.center)
        background.addSubview(amountText)
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
        foreground.addSubview(betweenView)
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
        foreground.animate(transformX:  isRTL ? 5 : -5, duration, curve)
        upView.animate(backgroundColor: gray0, duration, curve)
        betweenView.animate(height: maxHeight, duration, curve)
        betweenView.animate(y: background.height/2, duration, curve)
        baseTitle.animate(opacity: 1, 0.6, curve)
        baseTitle.animate(transform: CGAffineTransform(isRTL ? -2 : 2 , 2), duration, curve)
        image.animate(opacity: 1, duration, curve)
        titleText.animate(opacity: 1, duration, curve)
        titleText.animate(transform: amount != freeAmount ? CGAffineTransform(y: -(titleText.height/2+3)) : .identity, duration, curve)
        line.animate(locations: [0.15, 0.5, 0.85], duration, easeInOut05, 0.2)
        line.animate(opacity: 1, 0.2, easeInOut05)
        amountText.animate(opacity: 1, duration, curve)
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
        baseTitle.animate(opacity: 0.6, duration, curve)
        baseTitle.animate(transformX: isRTL ? -10 : 11, duration, curve)
        upView.animate(backgroundColor: gray01, duration, curve)
        betweenView.animate(height: height, duration, curve)
        betweenView.animate(y: height/2, duration, curve)
        image.animate(opacity: 0.5, duration, curve)
        titleText.animate(opacity: 0.5, duration, curve)
        titleText.animate(transform: .identity, duration, curve)
        line.animate(locations: [0.499, 0.5, 0.501], duration, easeInOut05)
        line.animate(opacity: 0, duration,  easeInOut05)
        amountText.animate(opacity: 0, duration, curve)
    }
}
