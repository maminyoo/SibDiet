//
//  UIViewEventEX.swift
//  Sibdiet
//
//  Created by Me on 9/1/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

extension UIView {
    func onTap(_ target: Any, _ action: Selector, _ numberOfTaps: Int = 1){
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = numberOfTaps
        addGestureRecognizer(tap)
    }
    
    func onPinch(_ target: Any, _ action: Selector){
        isUserInteractionEnabled = true
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
    }
    
    func onPan(_ target: Any, _ action: Selector){
        isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
    }
    
    func onScreenEdgePan(_ target: Any, _ action: Selector, _ edge: UIRectEdge){
        isUserInteractionEnabled = true
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: action)
        edgePan.edges = edge
        addGestureRecognizer(edgePan)
    }
    
    func onSwipe(_ target: Any, _ action: Selector){
        isUserInteractionEnabled = true
        let swipe = UISwipeGestureRecognizer(target: self, action: action)
        addGestureRecognizer(swipe)
    }
    
    func onRotate(_ target: Any, _ action: Selector){
        isUserInteractionEnabled = true
        let rotate = UIRotationGestureRecognizer(target: self, action: action)
        addGestureRecognizer(rotate)
    }
    
    func onLongPress(_ target: Any, _ action: Selector){
        isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: action)
        addGestureRecognizer(longPress)
    }
}

