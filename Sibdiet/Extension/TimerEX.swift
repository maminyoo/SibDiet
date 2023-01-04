//
//  NSTimerEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 6/1/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import Foundation

extension Timer {
    
    class func schedule(_ delay: TimeInterval,
                        handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)!
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    
    func timer(_ delay: CFTimeInterval,
               _ target: Any,
               _ action: Selector){
        Timer.scheduledTimer(timeInterval: delay,
                             target: target,
                             selector: action,
                             userInfo: nil,
                             repeats: false)
    }
}
