//
//  UILabelEX.swift
//  Sibdiet
//
//  Created by Amin on 3/31/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

extension UILabel{
    func text(_ string: String){
        text = string
    }
    
    func textColor(_ color: UIColor){
        textColor = color
    }
    
    func textAlignment(_ aligment: NSTextAlignment){
        textAlignment = aligment
    }
    
    func font(_ font: String, _ size: CGFloat){
        self.font = UIFont(font, size)
    }
    
    func font(_ font: UIFont){
        self.font = font
    }
    
    func adjustsFontSizeToFitWidth(_ bool: Bool){
        adjustsFontSizeToFitWidth = bool
    }
    
    func attributedText(_ attributedText: NSAttributedString){
        self.attributedText = attributedText
    }
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode){
        self.lineBreakMode = lineBreakMode
    }
    
    func numberOfLines(_ number: Int){
        numberOfLines = number
    }
}
