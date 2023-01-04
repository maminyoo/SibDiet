//
//  SwitchLangs.swift
//  Sibdiet
//
//  Created by amin sadeghian on 8/21/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
protocol SwitchLangsDelegate {
    func changeLang()
    func openSwitchLangs()
    func closeSwitchLangs()
}

class SwitchLangs: UIView, SwitchLangsDelegate{
    
    var delegateSwitchLangs: SwitchLangsDelegate?
    func delegate(_ delegate: SwitchLangsDelegate){
        self.delegateSwitchLangs  = delegate
    }
    
    var lng = settings.language
    var language : String { settings.language }

    var isOpen = false
    func isOpen(_ bool: Bool){
        self.isOpen = bool
    }
    
    var openHeight: CGFloat{ settings.languages.count.toCGFloat*45 + backgroundWidth }
    
    //MARK: INIT VIEW
    func initView(){
        setBg()
    }
       
    //MARK: BACKGROUND
    var background = UIView()
    let backgroundWidth: CGFloat = 45
    func setBg(){
        background.frame(width/2-backgroundWidth/2, 0, backgroundWidth, backgroundWidth)
        background.backgroundColor(barBackgroundColor)
        background.cornerRadius(backgroundWidth/2)
        background.clipsToBounds(true)
        setForeground()
        setLangs()
        addSubview(background)
    }
    
    //MARK: FOREGROUND
    let foreground = UIView()
    func setForeground(){
        let space: CGFloat = 4
        foreground.frame(space, space, background.width-space*2, background.width-space*2)
        foreground.cornerRadius(foreground.width/2)
        foreground.backgroundColor(gray01)
        let image = UIImage(WORLD_IMG)!
        let imageView = UIImageView()
        imageView.image(image)
        imageView.frame(space*1.5, space*1.5, foreground.width-space*3, foreground.width-space*3)
        foreground.addSubview(imageView)
        foreground.onTap(self, #selector(tapWorld(tap:)))
        background.addSubview(foreground)
    }
    
    @objc func tapWorld(tap: UITapGestureRecognizer){
       openClose()
    }
    
    //MARK: OPEN CLOSE
    func openClose(){
        if !isOpen{
            isOpen(true)
            background.animate(height: openHeight, 0.4, curve)
            background.animate(y: openHeight/2, 0.4, curve)
            openSwitchLangs()
        }else{
            isOpen(false)
            background.animate(height: backgroundWidth, 0.4, curve)
            background.animate(y: backgroundWidth/2, 0.4, curve)
            closeSwitchLangs()
        }
    }
    
    func openSwitchLangs() {
        delegateSwitchLangs?.openSwitchLangs()
    }
    
    func closeSwitchLangs() {
        delegateSwitchLangs?.closeSwitchLangs()
    }
    
    //MARK: LANGUAGE BUTTON
    var langs = [Int: Button]()
    func setLangs(){
        let font = UIFont(Sahel, 17)!
        var i = -1
        for lng in settings.languages{
            i+=1
            langs[i] = Button()
            let width = lng.width(height: 20, font: font) + 20
            langs[i]?.frame(background.width/2-width/2,
                            backgroundWidth+40*i.toCGFloat,
                            width,
                            40)
            langs[i]?.title(lng)
            langs[i]?.font(font)
            langs[i]?.shadow(.zero, gray09, 0.7, 1)
            langs[i]?.tag(i)
            langs[i]?.initView()
            langs[i]?.opacity(0)
            langs[i]?.animate(opacity: 1, 1, curveEaseOut05, delay[i+1])
            if lng ==  language{ langs[i]?.select() }
            langs[i]?.onTap(self, #selector(tap(tap:)))
            background.addSubview(langs[i]!)
        }
    }
    
    //MARK: TAP
    @objc func tap(tap: UITapGestureRecognizer){
        let tag: Int = (tap.view?.tag)!
        let lang = (langs[tag]?.title)!
        if language != lang { settings.language = lang }
        openClose()
        for (i, cell) in langs{
            if i == tag { cell.select() }
            else{ cell.deSelect() }
        }
        changeLang()
    }
    
    func changeLang(){
        if lng != language{
            lng = language
            delegateSwitchLangs?.changeLang()
        }
    }
}
