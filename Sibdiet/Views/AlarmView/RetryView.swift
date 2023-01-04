//
//  RetryView.swift
//  Sibdiet
//
//  Created by freeman on 6/14/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit
import QuartzCore

class RetryView: UIView, CloseRetryDelegate{
   
    var enable = false
    
    var title: String{
        switch language {
        case EN: return "Try again ⤻"
        default: return "⤻ تلاش مجدد"
        }
    }
    
    //MARK: INIT VIEW
    func initView(){
        if !enable{
            dietConnection.delegateCloseRetry = self
            enable = true
            setTitle()
            backgroundColor(mint01)
            transformY(-height)
            animate(transform: .identity, 0.7, curve)
            onTap(self, #selector(tap(tap:)))
        }
    }
    
    //MARK: TITLE
    func setTitle(){
        let label = UILabel()
        label.frame(0, height - 35, width, 30)
        label.font(Sahel, 22)
        label.textColor(white)
        label.text(title)
        label.textAlignment(.center)
        addSubview(label)
    }
    
    //MARK: TAP
    @objc func tap(tap: UITapGestureRecognizer){
        dietConnection.tryAgain()
        closeView()
    }
    
    func closeRetry() {
         closeView()
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        if enable{
            enable = false
            animate(transformY: -height, 0.7, curve)
            var _ = Timer.schedule(0.8) { _ in self.remove() }
        }
    }
}
