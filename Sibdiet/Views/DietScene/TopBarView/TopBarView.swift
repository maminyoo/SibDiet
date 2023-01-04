//
//  TopBarView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/16/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol TopBarDelegate {
    func onProfile()
    func onAdd()
    func onCalender()
}

class TopBarView: UIView, TopBarDelegate{
    
    var delegateTopBar: TopBarDelegate?
    func delegate(_ delegate: TopBarDelegate){
        self.delegateTopBar = delegate
    }
    
    let fullName: String = profile.fullName
    let gender: String = profile.gender
    let now = Date()
    
    var weekDay = String()
    func weekDay(_ day: String){
        self.weekDay = day
    }

    var canClose = true
    var enable = false

    let values = TopBarValues()
    
    //MARK: INIT VIEW
    func initView(){
        setBackground()
        showView()
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackground(){
        background.frame(bounds)
        background.backgroundColor(barBackgroundColor)
        background.shadow(CGSize(0, 1), gray09, 1, 0.7)
        setProfileButton()
        setAddButton()
        setWdGusture()
        setSubTitle()
        addSubview(background)
    }
    
    //MARK: PROFILE BUTTON
    var profileButton = BarButton()
    func setProfileButton(){
        let image = gender == MALE ? MAN_IMG :
            gender == FEMALE ? WOMAN_IMG : CHILD_IMG
        profileButton.frame(width - 63, height - (hasSafeArea ? 58 :  54), 60, 52)
        profileButton.image01(image)
        profileButton.text(values.profileTitle)
        profileButton.onTap(self, #selector(onProfile))
        profileButton.initView()
        background.addSubview(profileButton)
    }
    
    @objc func onProfile(){
        if canClose{
            canClose = false
            delegateTopBar?.onProfile()
        }
    }
    
    //MARK: ADD BUTTON
    var addButton = BarButton()
    func setAddButton(){
        addButton.frame(3, height - (hasSafeArea ? 58 :  54), 60, 52)
        addButton.image01(ADD_IMG)
        addButton.text(values.new)
        addButton.onTap(self, #selector(onAdd))
        addButton.initView()
        background.addSubview(addButton)
    }
    
    @objc func onAdd(){
        if canClose{
            canClose = false
            delegateTopBar?.onAdd()
        }
    }
    
    //MARK: WEEK
    var wdGesture = UIView()
    func setWdGusture(){
        let font = UIFont(Sahel_Bold, 24)!
        var width = fullName.width(height: 35, font: font) + 20
        width = width > self.width-130 ? self.width-160 : width
        wdGesture.frame(self.width/2 - width/2,
                        height - width,
                        width,
                        width)
        wdGesture.cornerRadius(10)
        wdGesture.clipsToBounds(true)
        wdGesture.border(dairyColor, 1.4)
        wdGesture.backgroundColor(white01)
        wdGesture.onTap(self, #selector(onCalender))
//        setWeeks()
        setName()
        background.addSubview(wdGesture)
    }
    
    var cells = [Int: Button]()
    func setWeeks(){
        var j = -1
        var i = 7
        for wk in values.week{
            i -= 1
            j += 1
            cells[j] = Button()
            let font = UIFont(Sahel, 17)!
            let width = wk.width(height: 15, font: font) + 20
            cells[j]?.frame(wdGesture.width/7 * CGFloat(i) + wdGesture.width/14 - width/2,
                            wdGesture.height - 30,
                            width,
                            35)
            cells[j]?.title(wk)
            cells[j]?.opacity(0.55)
            cells[j]?.transformR(-45)
            cells[j]?.initView()
            wdGesture.addSubview(cells[j]!)
        }
    }
    
    @objc func onCalender(){
        if canClose{
            canClose = false
            delegateTopBar?.onCalender()
        }
    }
    
    //MARK: NAME
    var name = CATextLayer()
    func setName(){
        let font = UIFont(Sahel_Bold, 25)!
        var width = fullName.width(height: 35, font: font)
        width = width > self.width-130 ? self.width-160 : width
        name.frame(wdGesture.width/2 - width/2,
                   wdGesture.height - (hasSafeArea ? 62 : 59),
                   width,
                   35)
        name.string(fullName)
        name.font(Sahel_Bold, 25)
        name.foregroundColor(gray06)
        name.shadow(.zero, white, 1.5, 1)
        name.alignmentMode(.center)
        name.contentsScale()
        wdGesture.addSublayer(name)
    }
    
    //MARK: SUBTITLE
    var subTitle = SubTitle()
    func setSubTitle(){
        let string = weekDay
        let font = values.subTitleFont
        let width: CGFloat = isRTL ? 70 : 110
        subTitle.frame(background.width/2 - width/2,
                       background.height - 23,
                       width,
                       20)
        subTitle.string(string)
        subTitle.backColor(registerColor)
        subTitle.shadow(.zero, white, 0.6, 1)
        subTitle.font(font)
        subTitle.backColor(sand01)
        subTitle.initView()
        background.addSubview(subTitle)
    }
    
    func showDiet(){
        subTitle.sub(title: values.diet)
    }
    
    func showPrescriptions(){
        subTitle.sub(title: values.priscription)
    }
    
    func showSupplement(){
        subTitle.sub(title: values.supplements)
    }
    
    //MARK: SELECT COLOR
    func selected(color: UIColor){
        name.animate(foregroundColor: color, 0.7, easeInOut05)
        wdGesture.layer.animate(borderColor: color, 0.7, easeInOut05)
        subTitle.selected(color: color)
    }
    
    //MARK: START VIEW
    func showView(){
        enable = true
        background.transformY(-background.height)
        background.animate(transform: .identity, 0.7, curve, 0.1)
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        enable = false
        background.animate(transformY: -background.height-2, 0.7, curve)
        var _ = Timer.schedule(1.5) { _ in self.remove() }
    }
}
