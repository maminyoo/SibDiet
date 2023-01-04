//
//  LoadingView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/25/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class LoadingView: UIView, LoadingDelegate{

    var enable = false

    func initView(_ inRoot: Bool = false){
        dietConnection.delegateLoading  = self
        opacity(0)
        enable = true
        setCircles()
        if inRoot{ setSibDiet() }
        animate(opacity: 1, 1, curve)
    }
    
    var circles = Circles()
    func setCircles(){
        let circleWidth: CGFloat = width/4
        circles.frame(width/2 - circleWidth/2,
                      height/2 - circleWidth/2,
                      circleWidth,
                      circleWidth)
        circles.colors([green01, green01, green, green])
        circles.opacity(0.7)
        circles.initView()
        addSubview(circles)
    }
    
    var sibDiet = SibDietView()
    func setSibDiet(){
        sibDiet = SibDietView(CGRect(0, HEIGHT/4, WIDTH, 35))
        sibDiet.initView()
        sibDiet.startView()
        addSubview(sibDiet)
    }
    
    func blurBack() {
        backgroundColor(.clear)
        if iOS14{
            animate(backgroundColor: gray02.opacity(0.3), 1, curveEaseInOut05)
        }else{
            blurBack(2, 1)
        }
    }
    
    func closeLoading() {
        closeView()
    }
    
    func closeView(){
        if enable{
            enable = false
            animate(opacity: 0, 1, curve)
            sibDiet.closeView()
            var _ = Timer.schedule(1) { _ in self.remove() }
        }
    }
}
