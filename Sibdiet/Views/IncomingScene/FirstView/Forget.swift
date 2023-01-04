//
//  buttonView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/27/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class Forget: UIView {
    
    var enable = true

    var forgetTitle = "فراموشی شماره پرونده"
    var mobileError = "پرونده ای با این شماره وجود ندارد"
    var fileNumberError = "پرونده ای با این مشخصات وجود ندارد"
    var internetError = "شما به اینترنت متصل نیستید"
    var sendFileNumber = "شماره پرونده شما ارسال گردید"
    var forgetFont = "XTraffic"
    
    //MARK: INIT VIEW
    func initView(){
        setTitle()
    }
    
    //MARK: TITLE
    var title = CATextLayer()
    func setTitle(){
        title.frame(bounds)
        title.string(forgetTitle)
        title.font(forgetFont, 16)
        title.foregroundColor(gray0)
        title.backgroundColor(forgetButtonColor)
        title.cornerRadius(5)
        title.alignmentMode(.center)
        title.contentsScale()
        setTitleMask()
        title.mask(titleMask)
        addSublayer(title)
    }
    
    var titleMask = CALayer()
    var titleMaskOrigin: CATransform3D!
    func setTitleMask(){
        titleMask.frame(title.bounds)
        titleMask.backgroundColor(white)
        titleMaskOrigin = titleMask.transform
        titleMask.cornerRadius(5)
    }
    
    //MARK: CLOSE
    func close(){
        enable = false
        let x = CATransform3DTranslate(titleMaskOrigin, -titleMask.width, 0, 0)
        titleMask.animate(transform3D: x, 0.6, easeInOut05)
    }
    
    //MARK: NOT FOUND PHONE
    func notFoundPhone(){
        dietConnection.closeLoading()
        var _ = Timer.schedule(0.7) { _ in self.notFoundPhoneListener() }
    }
    
    @objc func notFoundPhoneListener(){
        title.string = mobileError
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 0)
        title.animate(backgroundColor: gray01, 0.8, easeOut05)
        title.foreground(color: gray00, duration: 0.8, timingFunction: easeOut05, delay: 2)
        title.animate(backgroundColor: gray07, 0.8, easeOut05, 2)
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 3)
        title.animate(backgroundColor: gray01, 0.8, easeOut05, 3)
        title.foreground(color: gray00, duration: 0.8, timingFunction: easeOut05, delay: 4)
        title.animate(backgroundColor: gray07, 0.8, easeOut05, 4)
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 5)
        title.animate(backgroundColor: gray01, 0.8, easeOut05, 5)
        let titleMask01X = CATransform3DTranslate(titleMaskOrigin, -titleMask.width, 0, 0)
        titleMask.animate(transform3D: titleMaskOrigin, 0.6, easeInOut05)
        titleMask.animate(transform3D: titleMask01X, 0.6, easeInOut05, 6)
        var _ = Timer.schedule(7) { _ in self.reset() }
    }
    
    //MARK: NOT FOUND
    func notFound(){
        dietConnection.closeLoading()
        var _ = Timer.schedule(0.7) { _ in self.notFoundListener() }
    }
    
    @objc func notFoundListener(){
        title.string = fileNumberError
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 0)
        title.animate(backgroundColor: gray01, 0.8, easeOut05)
        title.foreground(color: gray00, duration: 0.8, timingFunction: easeOut05, delay: 2)
        title.animate(backgroundColor: gray07, 0.8, easeOut05, 2)
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 3)
        title.animate(backgroundColor: gray01, 0.8, easeOut05, 3)
        title.foreground(color: gray00, duration: 0.8, timingFunction: easeOut05, delay: 4)
        title.animate(backgroundColor: gray07, 0.8, easeOut05, 4)
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 5)
        title.animate(backgroundColor: gray01, 0.8, easeOut05, 5)
        let titleMask01X = CATransform3DTranslate(titleMaskOrigin, -titleMask.width, 0, 0)
        titleMask.animate(transform3D: titleMaskOrigin, 0.6, easeInOut05)
        titleMask.animate(transform3D: titleMask01X, 0.6, easeInOut05, 6)
        var _ = Timer.schedule(7) { _ in self.reset() }
    }
    
    func connectionError(){
        var _:Timer = Timer.schedule(0.7) { _ in
            self.notConnectionError()
        }
    }
    
    //MARK: NO CONNECTION
    @objc func notConnectionError(){
        title.string = internetError
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 0)
        title.animate(backgroundColor: gray01, 0.8, easeOut05)
        title.foreground(color: gray00, duration: 0.8, timingFunction: easeOut05, delay: 2)
        title.animate(backgroundColor: gray07, 0.8, easeOut05, 2)
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 3)
        title.animate(backgroundColor: gray01, 0.8, easeOut05, 3)
        title.foreground(color: gray00, duration: 0.8, timingFunction: easeOut05, delay: 4)
        title.animate(backgroundColor: gray07, 0.8, easeOut05, 4)
        title.foreground(color: red01, duration: 0.8, timingFunction: easeOut05, delay: 5)
        title.animate(backgroundColor: gray01, 0.8, easeOut05, 5)
        let titleMask01X = CATransform3DTranslate(titleMaskOrigin, -titleMask.width, 0, 0)
        titleMask.animate(transform3D: titleMaskOrigin, 0.6, easeInOut05)
        titleMask.animate(transform3D: titleMask01X, 0.6, easeInOut05, 6)
        var _ = Timer.schedule(7) { _ in self.reset() }
    }
    
    //MARK: FOUND
    func found(){
        var _ = Timer.schedule(0.7) { _ in self.foundListener() }
    }
    
    @objc func foundListener(){
        title.string = sendFileNumber
        title.foreground(color: forgetButtonColor, duration: 0.3, timingFunction: easeOut05, delay: 0)
        title.animate(backgroundColor: gray00, 0.3, easeOut05)
        let titleMask01X = CATransform3DTranslate(titleMaskOrigin, -titleMask.width, 0, 0)
        titleMask.animate(transform3D: titleMaskOrigin, 0.6, easeInOut05)
        titleMask.animate(transform3D: titleMask01X, 0.6, easeInOut05)
        var _ = Timer.schedule(7) { _ in self.reset() }
    }
    
    //MARK: RESET
    @objc func reset(){
        enable = true
        title.string = forgetTitle
        title.foreground(color: white, duration: 0, timingFunction: easeInOut, delay: 0)
        title.backgroundColor(skyBlue01)
        titleMask.animate(transform3D: titleMaskOrigin, 0.6, easeInOut05, 0)
    }
}
