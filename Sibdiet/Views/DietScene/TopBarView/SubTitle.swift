//
//  SubTitle.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/16/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class SubTitle: UIView{
    
    var string: String!
    func string(_ string: String){
        self.string = string
    }
    var backColor = UIColor()
    func backColor(_ backColor: UIColor){
        self.backColor = backColor
    }
    
    var font = UIFont(Traffic, 18)
    func font(_ font: UIFont){
        self.font = font
    }
    
    //MARK: INIT VIEW
    func initView(){
        setTop()
        setBottom()
    }
    
    //MARK: TOP VIEW
    var top = UIView()
    func setTop(){
        top.frame(0, 0, width, height/2)
        top.clipsToBounds(true)
        setLayer()
        setTopMask()
        setTopLabel()
        top.mask = topMask
        addSubview(top)
    }
    
    //MARK: TOP LAYER
    var topLayer = CALayer()
    func setLayer(){
        topLayer.frame(top.bounds)
        topLayer.backgroundColor(backColor)
        top.addSublayer(topLayer)
    }
    
    //MARK: TOP MASK
    var topMask = UIView()
    func setTopMask(){
        topMask.frame(top.bounds)
        let topMaskShape = CAShapeLayer()
        topMaskShape.frame(topMask.bounds)
        topMaskShape.path(topMaskShape.roundCorner(rt: 5, lt: 5, lb: 0, rb: 0))
        topMaskShape.fillColor(red01)
        topMask.addSublayer(topMaskShape)
    }
    
    //MARK: TOP LABEL
    var topLabel = UILabel()
    var topLabelY = CGFloat()
    func setTopLabel(){
        topLabel.frame(bounds)
        let y = topLabel.y
        topLabel.y = y - 1
        topLabelY = topLabel.y
        topLabel.text(string)
        topLabel.font(font!)
        topLabel.textColor(gray0)
        topLabel.shadow(CGSize(0, -0.5), gray09, 0.6, 0.7)
        topLabel.textAlignment(.center)
        top.addSubview(topLabel)
    }
    
    //MARK: BOTTOM VIEW
    var bottom = UIView()
    func setBottom(){
        bottom.frame(0, height/2-1, width, height/2)
        bottom.clipsToBounds(true)
        setBottomLayer()
        setBottomMask()
        setBottomLabel()
        bottom.mask = bottomMask
        addSubview(bottom)
    }
    
    //MARK: BOTTOM LAYER
    var bottomLayer = CALayer()
    func setBottomLayer(){
        bottomLayer.frame(bottom.bounds)
        bottomLayer.backgroundColor(backColor)
        bottomLayer.opacity(0.75)
        bottom.addSublayer(bottomLayer)
    }
    
    //MARK: BOTTOM MASK
    var bottomMask = UIView()
    func setBottomMask(){
        bottomMask.frame(bottom.bounds)
        let bottomMaskShape = CAShapeLayer()
        bottomMaskShape.frame(topMask.bounds)
        bottomMaskShape.path(bottomMaskShape.roundCorner(rt: 0, lt: 0, lb: 5, rb: 5))
        bottomMaskShape.fillColor(red01)
        bottomMask.addSublayer(bottomMaskShape)
    }
    
    //MARK: BOTTOM LABEL
    var bottomLabel = UILabel()
    var bottomLabelY = CGFloat()
    func setBottomLabel(){
        bottomLabel.frame(bounds)
        let y = bottomLabel.y
        bottomLabel.y(y - bottom.height)
        bottomLabelY = bottomLabel.y
        bottomLabel.text(string)
        bottomLabel.font(font!)
        bottomLabel.textColor(gray0)
        bottomLabel.shadow(CGSize(0, 0.5), gray09, 0.6, 0.7)
        bottomLabel.textAlignment(.center)
        bottom.addSubview(bottomLabel)
    }
    
    //MARK: SELECTED COLOR
    func selected(color: UIColor){
        topLayer.animate(backgroundColor: color, 0.7, easeInOut05)
        bottomLayer.animate(backgroundColor: color, 0.7, easeInOut05)
    }
    
    //MARK: SUBTITLE
    func sub(title: String){
        if title != string {
            let h = bottomLabel.intrinsicContentSize.height
            string = title
            let topY = topLabelY + h
            topLabel.animate(y: topY, 0.28, curveEaseIn05)
            let bottomY = bottomLabelY - h
            bottomLabel.animate(y: bottomY, 0.28, curveEaseIn05)
            var _ = Timer.schedule(0.30) { _ in
                self.setTitle()
                self.topLabel.text(title)
                self.bottomLabel.text(title)
            }
        }
    }
    
    @objc func setTitle(){
        topLabel.animate(y: topLabelY, 0.28, curveEaseOut05, 0.01)
        bottomLabel.animate(y: bottomLabelY, 0.28, curveEaseOut05, 0.01)
    }
}
