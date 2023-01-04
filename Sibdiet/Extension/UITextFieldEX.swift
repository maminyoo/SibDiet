//
//  UITextFieldEX.swift
//  Sibdiet
//
//  Created by Amin on 4/1/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit

extension UITextField: UITextFieldDelegate{
    
    func font(_ font: UIFont){
        self.font = font
    }
    
    func font(_ string: String, _ size: CGFloat){
        self.font = UIFont(string, size)
    }
    
    func placeholder(_ holder: String){
        placeholder = holder
    }
    
    func textColor(_ color: UIColor){
        textColor = color
    }
    
    func textAlignment(_ aligment: NSTextAlignment){
        textAlignment = aligment
    }
    
    func autocorrectionType(_ type: UITextAutocorrectionType){
        autocorrectionType = type
    }
    
    func preservesSuperviewLayoutMargins(_ bool: Bool){
        preservesSuperviewLayoutMargins = bool
    }
    
    func delegate(_ delegate: UITextFieldDelegate){
        self.delegate = delegate
    }
    
    func tintColor(_ color: UIColor){
        tintColor = color
    }
    
    func adjustsFontSizeToFitWidth(_ bool: Bool){
        adjustsFontSizeToFitWidth = bool
    }
    
    func text(_ string: String){
        text = string
    }
    
    func keyboardType(_ type: UIKeyboardType){
        keyboardType = type
    }
    
    func editingChanged(_ target: Any, _ action: Selector){
        addTarget(target, action: action, for: .editingChanged)
    }
    
    func editingDidBegin(_ target: Any,_ action: Selector){
        addTarget(target, action: action, for: .editingDidBegin)
    }
    
    func editingDidEnd(_ target: Any,_ action: Selector){
        addTarget(target, action: action, for: .editingDidEnd)
    }
    
    func isUserInteractionEnabled(_ bool: Bool){
        isUserInteractionEnabled = bool
    }
}
