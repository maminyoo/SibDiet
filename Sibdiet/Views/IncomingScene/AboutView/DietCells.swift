//
//  DietCel.swift
//  Sibdiet
//
//  Created by amin sadeghian on 10/28/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import QuartzCore
import UIKit

class DietCells: UIView {
    
    var lists = [String]()
        
    var h: CGFloat!
    var font = Sahel as CFString
    func initView(){
        var i = -1
        let firstY: CGFloat = -26
        var y: CGFloat = firstY
        let height: CGFloat = 45
        h = height * CGFloat(lists.count)
        
        let colors01 = [gray00.cgColor, gray03.cgColor]
        let colors02 = [gray03.cgColor, gray00.cgColor]
        
        for title in lists{
            y += height
            i += 1
            
            let dietCellView = DietCell()
            dietCellView.title = title
            dietCellView.newY = y
            dietCellView.font = font
            if i%2 == 0 {
                dietCellView.colors = colors01
            }else{
                dietCellView.colors = colors02
            }
            dietCellView.initView()
            dietCellView.frame = self.bounds
            let dietCellOrigin = dietCellView.transform3D
            dietCellView.alpha = 0
            addSubview(dietCellView)
            
            let dietCell01X = CATransform3DTranslate(dietCellOrigin, 0, (dietCellView.height+500), 0)
            dietCellView.transform3D = dietCell01X
            dietCellView.animate(transform3D: dietCellOrigin, 0.9, curveEaseOut05, delay[i])
            dietCellView.animate(opacity: 1, 0.5, curveEaseIn05, delay[i])
        }
    }
}
