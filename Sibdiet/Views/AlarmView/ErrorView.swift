//
//  ErrorView.swift
//  Sibdiet
//
//  Created by Amin on 2/17/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class ErrorView: UIView {
    
    var enable = false
    
    var title: String{
        switch language {
        case EN: return "Server is being updated" + "\n" + "Please try again" + "\n" + "in a few minutes"
        default: return "سرور در حال بروزرسانی است" + "\n" + "لطفاً دقایقی دیگر تلاش کنید"
        }
    }
    
    //MARK: INIT VIEW
    func initView(){
        if !enable && !dietConnection.inBackground{
            enable = true
            setTitle()
            transformY(-height/2)
            opacity(0)
            animate(transform: .identity, 0.9, curve)
            animate(opacity: 1, 0.9, curve)
            onTap(self, #selector(tap(tap:)))
        }
    }
    
    //MARK: TITLE
    func setTitle(){
        let label = UILabel()
        label.frame(bounds)
        label.font(Sahel_Bold, 22)
        label.textColor(white02)
        label.text(title)
        label.numberOfLines(0)
        label.textAlignment(.center)
        addSubview(label)
    }
    
    //MARK: TAP
    @objc func tap(tap: UITapGestureRecognizer){
        if isConnected{
            enable = false
            dietConnection.tryAgain()
            closeView()
        }else{
            dietConnection.connectionError()
        }
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        enable = false
        animate(transformY: -height/2, 0.9, curve)
        animate(opacity: 0, 0.9, curve)
        var _ = Timer.schedule(0.8) { _ in self.remove() }
    }
}
