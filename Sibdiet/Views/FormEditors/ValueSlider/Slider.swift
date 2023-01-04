//
//  Slider.swift
//  Sibdiet
//  Created by Me on 10/12/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol SliderDelegate {
    func slide(title: String , index: Int)
    func onRelease()
}

class Slider: UIView, SliderDelegate{
    
    var delegateSlider: SliderDelegate?
    func delegate(_ delegate: SliderDelegate){
        delegateSlider = delegate
    }
    
    var i = Int()
    var result = Int()
    func result(_ int: Int){
        result = int
    }
    var values = [Int]()
    func values(_ vals: [Int]){
        values = vals
    }
    var title = String()
    func title(_ string: String){
        title = string
    }
    
    var enable = true
    func enable(_ bool: Bool){
        enable = bool
    }
    
    var color = UIColor()
    func color(_ color: UIColor){
        self.color = color
    }
    
    var focusRuler   = false
    var focusPointer = false
        
    var slideRuler   : CGFloat{ values.count>10 ? 3 : 2 }
    var rulerHeight  : CGFloat{ height - 10 }
    var rulerWidth   : CGFloat{ values.count.toCGFloat*rulerHeight }
    var rulerRight   : CGFloat{ rulerHolder.width-ruler.width/2 }
    var rulerLeft    : CGFloat{ ruler.width/2 }
    var rulerX       : CGFloat!
    var pointerRight : CGFloat{ width - height/2 }
    var slidePoniter : CGFloat{ values.count<50 ? 1 : 2 }
    var pointerLeft  : CGFloat{ height/2 }
    var pointerX     : CGFloat!
    
    //MARK: INIT VIEW
    func initView(){
        setRulerHolder()
        setPointer()
        opacity(enable ? 1 : 0.4)
    }
    
    //MARK: RULER
    var rulerHolder = UIView()
    func setRulerHolder(){
        rulerHolder.frame(5, 5, width-10, rulerHeight)
        rulerHolder.clipsToBounds(true)
        rulerHolder.onPan(self, #selector(panRuler(pan:)))
        rulerHolder.cornerRadius(10)
        setRuler()
        addSubview(rulerHolder)
    }
    
    lazy var ruler = UIView()
    lazy var labels = [Int: UILabel]()
    func setRuler(){
        let font = isRTL ? Gandom : Sahel
        var index = -1
        for number in values{
            index += 1
            labels[index] = UILabel()
            let string = isRTL ? number.string.faNumber : number.string
            let x = isRTL ? rulerWidth-rulerHeight-(rulerHeight*index.toCGFloat) : rulerHeight*index.toCGFloat
            labels[index]?.frame(x, 0, rulerHeight, rulerHeight)
            labels[index]?.font(font, rulerHeight - 35)
            labels[index]?.textColor(white02)
            labels[index]?.backgroundColor(index%2==0 ? oddColor : evenColor)
            labels[index]?.textAlignment(.center)
            labels[index]?.text(string)
            labels[index]?.tag(index)
            labels[index]?.onTap(self, #selector(tapRuler(tap:)))
            ruler.addSubview(labels[index]!)
        }
        ruler.frame(isRTL ? rulerHolder.width-rulerWidth : 0, 0, rulerWidth, rulerHeight)
        rulerHolder.addSubview(ruler)
    }
    
    //MARK: TAP RULER
    @objc func tapRuler(tap: UITapGestureRecognizer){
        if enable{
            let tag: Int = (tap.view?.tag)!
            moveRuler(index: tag, 0.6)
            movePointer(index: tag, 0.6)
            pointer.moveRuler(index: tag, 0.6)
            slide(title: title, index: tag)
            onRelease()
        }
    }
    
    //MARK: PAN RULER
    @objc func panRuler(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: ruler).x
        if !focusPointer && enable{
            switch pan.state {
            case .began:
                rulerX = ruler.x
                focusRuler = true
            case .changed:
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                if ruler.x == rulerRight ||
                   ruler.x == rulerLeft ||
                   ruler.x > rulerRight &&
                   ruler.x < rulerLeft  { ruler.x(rulerX+(translation*slideRuler)) }
                if ruler.x < rulerRight { ruler.x(rulerRight) }
                if ruler.x > rulerLeft  { ruler.x(rulerLeft) }
                CATransaction.commit()
                moveRuler(x: ruler.x)
            case .ended :
                onRelease()
                springRuler(index: i)
                focusRuler = false
            default: break }
        }
    }
    
    //MARK: MOVE RULER
    func moveRuler(x: CGFloat){
        let width        = rulerLeft-rulerRight
        let distance     = isRTL ? x-rulerRight : x-rulerLeft
        let count        = values.count.toCGFloat-1
        let index        = abs((distance/width*count).int)
        i = index > values.count-1 ? values.count-1 : index < 0 ? 0 : index
        pointer.layer.animate(shadowRadius: 3, 0.3, easeInOut05)
        movePointer(index: i)
        pointer.moveRuler(index: i)
        slide(title: title, index: i)
    }
        
    //MARK: MOVE POINTER INDEX
    func movePointer(index: Int, _ duration: CFTimeInterval = 0.4){
        pointer.animate(x: pointerX(index), duration, curve)
    }
    
    func springPointer(index: Int){
        pointer.animate(x: pointerX(index), 0.4, 0.7)
    }
    
    func pointerX(_ index: Int) -> CGFloat{
        let distance = pointerRight - pointerLeft
        let slide = distance / (values.count-1).toCGFloat
        return isRTL ?
            pointerRight - slide*index.toCGFloat :
            pointerLeft + slide*index.toCGFloat
    }

    //MARK: POINTER
    var pointer = Pointer()
    func setPointer(){
        pointer.frame(isRTL ? width-height : 0, 0, height, height)
        pointer.shadow(.zero, color, 1.2, 0.6)
        pointer.values(values)
        pointer.result(result)
        pointer.color(color)
        pointer.onPan(self, #selector(panPointer(pan:)))
        pointer.initView()
        addSubview(pointer)
    }
    
    //MARK: PAN POINTER
    @objc func panPointer(pan : UIPanGestureRecognizer){
        let translationX = pan.translation(in: pointer).x
        if !focusRuler && enable{
            switch pan.state {
            case .began:
                pointerX = pointer.x
                focusPointer = true
            case .changed:
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                if pointer.x == pointerRight ||
                   pointer.x == pointerLeft ||
                   pointer.x < pointerRight &&
                    pointer.x > pointerLeft { pointer.x(pointerX+(translationX/slidePoniter)) }
                if pointer.x > pointerRight { pointer.x(pointerRight) }
                if pointer.x < pointerLeft  { pointer.x(pointerLeft) }
                CATransaction.commit()
                movePointer(x: pointer.x)
            case .ended:
                onRelease()
                springPointer(index: i)
                focusPointer = false
            default: break }
        }
    }
    
    //MARK: MOVE POINTER X
    func movePointer(x: CGFloat){
        let fullDistance = pointerLeft-pointerRight
        let distance     = isRTL ? x-pointerRight : x-pointerLeft
        let count        = values.count.toCGFloat
        let index        = abs((distance/fullDistance*count).int)
        i = index > values.count-1 ? values.count-1 : index < 0 ? 0 : index
        pointer.layer.animate(shadowRadius: 3, 0.3, easeInOut05)
        moveRuler(index: i)
        pointer.moveRuler(index: i)
        slide(title: title, index: i)
    }
    
    //MARK: MOVE RULER INDEX
    func moveRuler(index: Int, _ duration: CFTimeInterval = 0.4){
        ruler.animate(x: rulerX(index), duration, curve)
    }
    
    func springRuler(index: Int){
        ruler.animate(x: rulerX(index), 0.4, 0.7)
    }
    
    func rulerX(_ index: Int)->CGFloat{
        let distance = rulerRight-rulerLeft
        let slide = distance/(values.count-1).toCGFloat
        return isRTL ?
            rulerRight - slide*index.toCGFloat :
            rulerLeft + slide*index.toCGFloat
    }
    
    func slide(title: String , index: Int){
        delegateSlider?.slide(title: title, index: index)
    }
    
    func onRelease(){
        pointer.layer.animate(shadowRadius: 1.2, 0.6, easeInOut05)
        delegateSlider?.onRelease()
    }
}
