//
//  DietList.swift
//  Sibdiet
//
//  Created by amin sadeghian on 10/26/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import QuartzCore
import UIKit

class DietsList: UIView{
    
    var h: CGFloat!
    var list = [String]()
    let dietsCells = DietCells()
    var font = Sahel as CFString
    func setDietCells(){
        dietsCells.frame = self.bounds
        dietsCells.lists = list
        dietsCells.font = font
        dietsCells.initView()
        addSubview(dietsCells)
    }
    
    func move(to: CGFloat, duration: CFTimeInterval){
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
            self.dietsCells.y = to
        },completion: nil)
    }
}
