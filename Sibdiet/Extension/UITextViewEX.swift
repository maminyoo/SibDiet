//
//  UITextViewEX.swift
//  Sibdiet
//
//  Created by Amin on 2/10/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit

extension UITextView{
    var paragraphHeight: CGFloat{
        let fixedWidth = width
        let newSize = sizeThatFits(CGSize(fixedWidth, CGFloat(MAXFLOAT)))
        var newFrame = frame
        newFrame.size = CGSize(CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), newSize.height)
        return newSize.height
    }
    
    func setJustifiedRight(_ title : String?, _ font: UIFont, _ color: UIColor) {
        if let desc = title {
            let text: NSMutableAttributedString = NSMutableAttributedString(string: desc)
            let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = NSTextAlignment.justified            
            paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
            paragraphStyle.baseWritingDirection = NSWritingDirection.rightToLeft
            text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
            let att = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor : color]
            text.addAttributes(att, range: NSMakeRange(0, text.length))
            self.attributedText = text
        }
    }
    
    func isEditable(_ bool : Bool){
        isEditable = bool
    }
    
    func font(_ font: UIFont){
        self.font = font
    }
    
    func font(_ name: String, _ size: CGFloat){
        self.font = UIFont(name, size)
    }
    
    func textAlignment(_ aligment: NSTextAlignment){
        textAlignment = aligment
    }
    
    func textColor(_ color: UIColor){
        textColor = color
    }
    
    func autocorrectionType(_ type: UITextAutocorrectionType){
        autocorrectionType = type
    }
    
    func text(_ text: String){
        self.text = text
    }
    
    func isMultipleTouchEnabled(_ bool: Bool){
        isMultipleTouchEnabled = bool
    }
    
    func delegate(_ delegate: UITextViewDelegate){
        self.delegate = delegate
    }
    
    func tintColor(_ color: UIColor){
        tintColor = color
    }
    
    func isScrollEnabled(_ bool: Bool){
        isScrollEnabled = bool
    }
    
    func isSelectable(_ bool: Bool){
        isSelectable = bool
    }
    
    func enablesReturnKeyAutomatically(_ bool: Bool){
        enablesReturnKeyAutomatically = bool
    }
    
    func lineBreakMode(_ breakMode: NSLineBreakMode){
        textContainer.lineBreakMode = breakMode
    }
}
