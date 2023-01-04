//
//  FamilyView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/24/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

class FamilyView: UIView{
    
    var fullName = profile.fullName
    
    var enable = false
    func enable(_ bool: Bool){
        self.enable = bool
    }
    
    var root: Bool{ profile.fileNumber == "" }
    var title: String!
    let persons = users.defaultsPersons
    
    var count = 0
    let cellHeight: CGFloat = 50
    var fullHeight = CGFloat()
    var font = UIFont()
    
    var nameTitle: String{  SibDiet }
    var nameFont: UIFont{ UIFont(JosefinSans, 28)! }
    
    //MARK: INIT VIEW
    func initView(){
        if root || profile.dietCount == 0{
            backgroundColor(gray01)
            font = nameFont
            title = nameTitle
            count = users.defaultsPersons.count
        }else{
            font = UIFont(Sahel_Bold, 24)!
            title = profile.fullName
            count = users.defaultsPersons.count-1
        }
        fullHeight = cellHeight * CGFloat(count)
        setTopFrame()
        setFamilyCell()
        showView()
    }

   //MARK: TOP BAR
   var topBar = UIView()
   func setTopFrame(){
        topBar.frame(topFrame)
        topBar.shadow(CGSize(0, 1), gray09, 1, 0.7)
        topBar.backgroundColor(barBackgroundColor.opacity(0.9))
        setName()
        addSubview(topBar)
    }
    
    //MARK: NAME
    var name = UILabel()
    func setName(){
        name.frame(0, topBar.height-40, width, 35)
        name.text(title)
        name.shadow(CGSize(0, 1), gray06, 0.7, 0.6)
        name.font(font)
        name.textColor(gray07)
        name.textAlignment(.center)
        topBar.addSubview(name)
    }
    
    //MARK: CELL'S
    var personCell = [Int: PersonCell]()
    var i = -1
    func setFamilyCell(){
        for person in persons{
            if person[FILE_NUMBER] != profile.fileNumber{
                i += 1
                personCell[i] = PersonCell()
                personCell[i]?.frame(10,
                                     height/2 - fullHeight/2 + (CGFloat(i) * cellHeight),
                                     width-20,
                                     50)
                personCell[i]?.person(person)
                personCell[i]?.cornerRadius(10)
                personCell[i]?.opacity(0)
                personCell[i]?.shadow(.zero, gray11, 1.5, 0.8)
                personCell[i]?.animate(opacity: 1, 0.5, curve, delay[i])
                personCell[i]?.tag(i)
                personCell[i]?.onTap(self, #selector(loginFamily(tap:)), 1)
                personCell[i]?.initView()
                addSubview(personCell[i]!)
            }
        }
        var _ = Timer.schedule(0.7) { _ in self.enableClose() }
    }
        
    //MARK: LOGIN FAMILY
    @objc func loginFamily(tap: UITapGestureRecognizer){
        if isConnected{
            let tag: Int = (tap.view?.tag)!
            let mobile = personCell[tag]?.person[MOBILE]
            let fileNumber = personCell[tag]?.person[FILE_NUMBER]
            loginFamily()
            dietConnection.getData(mobile!, fileNumber!)
        }else{
            dietConnection.connectionError()
        }
    }
    
    
    func loginFamily(){
        closeFamilyView()
        dietConnection.loginFamily()
    }
    
    @objc func enableClose(){
        enable = true
    }
    
    //MARK: START VIEW
    func showView(){
        topBar.transformY(-topBar.height)
        topBar.animate(transform: .identity, 0.7, curve)
        backgroundColor(.clear)
        if iOS14{
            animate(backgroundColor: gray12.opacity(0.3), 1, curveEaseInOut05)
        }else{
            blurBack(4, 1)
        }
    }
    
    //MARK: TOUCHES BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     let maxY = self.height/2 + fullHeight/2
        if let point = touches.first?.location(in: self){
            if point.y > maxY{
                if enable && !root && profile.dietCount != 0 && profile.published != ZERO{
                    closeFamilyView()
                }
            }
        }
    }
    
    //MARK: CLOSE VIEW
    func closeFamilyView(){
        enable = false
        topBar.animate(transformY : -topBar.height, 0.7, curve)
        for (i, cell) in personCell{
            cell.animate(opacity: 0, 0.5, curveEaseOut, delay[i])
        }
        animate(backgroundColor: .clear, 0.7, curveEaseOut)
        unBlur(0.9)
        var _ = Timer.schedule(1) { _ in self.remove() }
    }
}
