//
//  BodyFormV2.swift
//  Sibdiet

//  Created by Me on 10/3/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol BodyFormDelegate{
    func open(color: UIColor)
    func enableSpecial()
    func closeForm()
}

class BodyForm: UIView, ValueSliderDelegate, BodyFormDelegate{
    
    var delegateBodyForm: BodyFormDelegate?
    func delegate( _ delegate: BodyFormDelegate){
        delegateBodyForm = delegate
    }
    
    //MARK: FORM INDEX'S
    let statureIndex: Int = 0
    let weightIndex: Int = 1
    let birthStatureIndex: Int = 2
    let birthWeightIndex: Int = 3
    let fatherStatureIndex: Int = 4
    let motherStatureIndex: Int = 5
    let wristIndex: Int = isBaby ? 6 : 2
    let abdominalIndex: Int = isBaby ? 7 : 3
    let hipIndex: Int = isBaby ? 8 : 4
    let thighIndex: Int = isBaby ? 9 : 5
    let chestIndex: Int = isBaby ? 10 : 6
    let shouldersIndex: Int = isBaby ? 11 : 7
    
    let duration: CFTimeInterval = 0.6
    let values = BodyFormValues()
    let cellHeight: CGFloat = 70
        
    //MARK: INIT VIEW
    func initView(){
        setForm()
        startView()
    }
    
    var formHeight: CGFloat {
        var result: CGFloat = 10
        for b in bodyForm { if b.enable { result += b.cellHeight+10 } }
        return result
    }
    
    var isScrollable: Bool { formHeight>height }
    var btmForm:   CGFloat { height-formHeight/2 }
    var topForm:   CGFloat { formHeight/2 }

    //MARK: BODY FORM
    lazy var bodyForm = [ValueSlider]()
    var bodyHolder = UIView()
    func setForm(){
        var index = -1
        for body in values.body{
            index += 1
            let valueSlider = ValueSlider()
            valueSlider.frame(10,
                              10 + (cellHeight+10)*index.toCGFloat,
                              width-20,
                              cellHeight)
            valueSlider.model(body)
            valueSlider.result(updateBody.body[index])
            valueSlider.tag(index)
            valueSlider.duration(duration)
            valueSlider.delegate(self)
            valueSlider.shadow(.zero, gray07, 1, 0.7)
            valueSlider.maxTitle(values.maxTitle)
            valueSlider.transformY(btmFrame.height)
            valueSlider.opacity(0)
            valueSlider.initView()
            bodyForm.append(valueSlider)
            bodyHolder.addSubview(bodyForm[index])
        }
        bodyHolder.frame(0, 0, width, formHeight)
        bodyHolder.onPan(self, #selector(panForm(pan:)))
        addSubview(bodyHolder)
    }
    
    //MARK: PAN FORM
    var formY  : CGFloat!
    @objc func panForm(pan: UIPanGestureRecognizer){
        let translationY = pan.translation(in: bodyHolder).y
        switch pan.state {
        case .began:
            formY = bodyHolder.y
        case .changed:
            bodyHolder.y(isScrollable ? formY+translationY : formY+translationY/5)
        case .ended:
            let velocity = pan.velocity(in: bodyHolder)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 300
            let slideFactor = 0.1 * slideMultiplier
            let y = bodyHolder.y + (velocity.y * slideFactor)
            let time = CFTimeInterval(slideFactor * 2)
            if isScrollable{
                if y < btmForm{ bodyHolder.animate(y: btmForm, 0.8, 0.8) }
                else if y > topForm{ bodyHolder.animate(y: topForm, 0.8, 0.8) }
                else{ bodyHolder.animate(y: y, time,  curveEaseOut03) }
            }else { bodyHolder.animate(y: height/2 , 0.8, 0.8) }
        default: break }
    }
    
    func closeForm(){
        delegateBodyForm?.closeForm()
    }
    
    //MARK: OPEN SLIDER
    func openSlider(_ tag: Int, color: UIColor) {
        open(color: color)
        for body in bodyForm{
            if tag != body.tag {body.closeSlider(body.tag)}
            bodyForm[body.tag].animate(height: body.cellHeight, duration, curve)
            let y = body.tag == 0 ?
                body.cellHeight/2 + 10 :
                bodyForm[body.tag-1].y + bodyForm[body.tag-1].height/2 + body.cellHeight/2 + 10
            bodyForm[body.tag].animate(y: y, duration, curve)
        }
        bodyHolder.animate(height: formHeight, duration, curve)
        if isScrollable{
            switch tag {
            case statureIndex, weightIndex: bodyHolder.animate(y: topForm, duration, curve)
            case thighIndex, chestIndex, shouldersIndex: bodyHolder.animate(y: btmForm, duration, curve)
            default: break
            }
        }
    }
    
    func open(color: UIColor) {
        delegateBodyForm?.open(color: color)
    }
    
    //MARK: CLOSE SLIDER
    func closeSlider(_ tag: Int) {
        for body in bodyForm{
            bodyForm[body.tag].animate(height: body.cellHeight, duration, curve)
            let y = body.tag == 0 ?
                body.cellHeight/2 + 10 :
                bodyForm[body.tag-1].y + bodyForm[body.tag-1].height/2 + body.cellHeight/2 + 10
            bodyForm[body.tag].animate(y: y, duration, curve)
        }
        bodyHolder.animate(height: formHeight, duration, curve)
        if isScrollable{
            if bodyHolder.y < btmForm{ bodyHolder.animate(y: btmForm, duration, curve) }
            else if bodyHolder.y > topForm{ bodyHolder.animate(y: topForm, duration, curve) }
        }else { bodyHolder.animate(y: height/2, duration, curve) }
    }
    
    //MARK: START VIEW
    func startView(){
        let delay: CFTimeInterval = 0.5
        startSlider(statureIndex, delay)
        if updateBody.stature.hasResult { startSlider(weightIndex, delay+0.1)
            if updateBody.weight.hasResult {
                if isBaby{
                    startSlider(birthStatureIndex, delay+0.2)
                    if updateBody.birthStature.hasResult{
                        startSlider(birthWeightIndex, delay+0.3)
                        if updateBody.birthWeight.hasResult{
                            startSlider(fatherStatureIndex, delay+0.4)
                            if updateBody.fatherStature.hasResult{
                                startSlider(motherStatureIndex, delay+0.5)
                                if updateBody.motherStature.hasResult{
                                    startSlider(wristIndex, delay+0.6)
                                    if updateBody.wrist.hasResult{
                                        startSlider(abdominalIndex, delay+0.7)
                                        startSlider(hipIndex, delay+0.8)
                                        startSlider(thighIndex, delay+0.9)
                                        startSlider(chestIndex, delay+1.1)
                                        startSlider(shouldersIndex, delay+1.2)
                                    }else{ openValueSlider(wristIndex, delay+0.7) }
                                }else{ openValueSlider(motherStatureIndex, delay+0.6) }
                            }else{ openValueSlider(fatherStatureIndex, delay+0.5) }
                        }else{ openValueSlider(birthWeightIndex, delay+0.4) }
                    }else{ openValueSlider(birthStatureIndex, delay+0.3) }
                }else{
                    startSlider(wristIndex, delay+0.2)
                    if updateBody.wrist.hasResult {
                        startSlider(abdominalIndex, delay+0.3)
                        startSlider(hipIndex, delay+0.4)
                        startSlider(thighIndex, delay+0.5)
                        startSlider(chestIndex, delay+0.6)
                        startSlider(shouldersIndex, delay+0.7)
                    }else{ openValueSlider(wristIndex, delay+0.2) }
                }
            }else{ openValueSlider(weightIndex, delay+0.1) }
        }else{ openValueSlider(statureIndex, delay) }
        bodyHolder.animate(height: formHeight, 0.6, curve)
        bodyHolder.animate(y: height/2 , 0.6, curve)
    }
    
    func openValueSlider(_ index: Int,_ delay: CFTimeInterval){
        var _ = Timer.schedule(delay) {_ in
            self.bodyForm[index].tap()
            self.bodyHolder.animate(y: self.height/2 , self.duration, curve)
        }
    }
    
    //MARK: ON RELEASE
    func onRelease(){
        save()
        if updateBody.stature.hasResult {
            startSlider(weightIndex)
            fixPosition()
        }
        if updateBody.weight.hasResult{
            if isBaby{
                startSlider(birthStatureIndex)
                fixPosition()
                if updateBody.birthStature.hasResult{
                    startSlider(birthWeightIndex)
                    fixPosition()
                }
                if updateBody.birthWeight.hasResult{
                    startSlider(fatherStatureIndex)
                    if !updateBody.fatherStature.hasResult{ fixPosition(true) }
                }
                if updateBody.fatherStature.hasResult{
                    startSlider(motherStatureIndex)
                    if !updateBody.motherStature.hasResult{ fixPosition(true) }
                }
                if updateBody.motherStature.hasResult{
                    startSlider(wristIndex)
                    if !updateBody.wrist.hasResult{ fixPosition(true) }
                }
                if updateBody.wrist.hasResult{
                    startSlider(abdominalIndex, 0.1)
                    startSlider(hipIndex, 0.2)
                    startSlider(thighIndex, 0.3)
                    startSlider(chestIndex, 0.4)
                    startSlider(shouldersIndex, 0.5)
                    fixPosition()
                }
            }else{
                startSlider(wristIndex)
                fixPosition()
                if updateBody.wrist.hasResult{
                    startSlider(abdominalIndex, 0.1)
                    startSlider(hipIndex, 0.2)
                    startSlider(thighIndex, 0.3)
                    startSlider(chestIndex, 0.4)
                    startSlider(shouldersIndex, 0.5)
                    fixPosition()
                }
            }
        }
    }
    
    //MARK: FIX POSITION
    func fixPosition(_ inBottom: Bool = false){
        bodyHolder.animate(height: formHeight, duration, curve)
        if inBottom && isScrollable{ bodyHolder.animate(y: btmForm, duration, curve) }
    }
    
    //MARK: SAVE FORM
    func save(){
        bodyForm[statureIndex].result = updateBody.stature
        bodyForm[weightIndex].result  = updateBody.weight
        if isBaby{
            bodyForm[birthStatureIndex].result  = updateBody.birthStature
            bodyForm[birthWeightIndex].result   = updateBody.birthWeight
            bodyForm[fatherStatureIndex].result = updateBody.fatherStature
            bodyForm[motherStatureIndex].result = updateBody.motherStature
        }else{
            updateBody.birthStature.reset()
            updateBody.birthWeight.reset()
            updateBody.fatherStature.reset()
            updateBody.motherStature.reset()
        }
        bodyForm[wristIndex].result     = updateBody.wrist
        bodyForm[abdominalIndex].result = updateBody.abdominal
        bodyForm[hipIndex].result       = updateBody.hip
        bodyForm[thighIndex].result     = updateBody.thigh
        bodyForm[chestIndex].result     = updateBody.chest
        bodyForm[shouldersIndex].result = updateBody.shoulders
        if isBaby && !updateBody.birthStature.hasResult{
            updateBody.birthWeight.reset()
            updateBody.fatherStature.reset()
            updateBody.motherStature.reset()
            updateBody.wrist.reset()
        }
        if updateBody.wrist.hasResult{ enableSpecial() }
        else{
            updateBody.abdominal.reset()
            updateBody.hip.reset()
            updateBody.thigh.reset()
            updateBody.chest.reset()
            updateBody.shoulders.reset()
        }
    }
    
    func enableSpecial() {
        delegateBodyForm?.enableSpecial()
    }
    
    //MARK: START SLIDER
    func startSlider(_ index: Int, _ delay: CFTimeInterval = 0){
        bodyForm[index].startView()
        bodyForm[index].animate(transform: .identity, 0.6, curve, delay)
        bodyForm[index].animate(opacity: 1, 0.6, curve, delay)
    }
    
    //MARK: COLSE VIEW
    func closeView(){
        for slider in bodyForm{ if slider.isOpen { slider.closeSlider(slider.tag)} }
        bodyHolder.animate(y: height+btmFrame.height+bodyHolder.height/2, 1.0, curve)
    }
}
