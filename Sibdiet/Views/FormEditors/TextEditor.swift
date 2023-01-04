//
//  TextGeter.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/14/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol TextEditorDelegate {
    func onFocus()
    func endEditing()
    func textEditorSelected(cell: String)
    func onReturn()
}

class TextEditor: UIView, TextEditorDelegate, UITextFieldDelegate{
    
    var enable = false
    var enableClean = false
    var focus = false

    var delegateTextEditor: TextEditorDelegate?
    func delegate(_ delegate: TextEditorDelegate){
        self.delegateTextEditor = delegate
    }
    
    var isCharactersCheck = true
    func isCharactersCheck(_ bool: Bool){
        self.isCharactersCheck = bool
    }
    
    var title = String()
    func title(_ title: String){
        self.title = title
    }
    
    var placeholder = String()
    func placeholder(_ holder: String){
        self.placeholder = holder
    }
    
    var enableCharacters = String()
    func enableCharacters(_ characters: String){
            self.enableCharacters = characters
    }
    
    var corner: CGFloat = 15
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var font = UIFont(Traffic, 20)!
    func font(_ font: UIFont){
        self.font = font
    }
    func font(_ string: String, _ size: CGFloat){
        self.font = UIFont(string, size)!
    }
    
    var text: String{ get{inputText.text!} set{inputText.text = newValue} }
    func text(_ text: String){
        self.text = text
    }
    
    func keyboardType(_ type: UIKeyboardType){
        self.inputText.keyboardType = type
    }
    
    var isEnable = true
    func isEnable(_ bool: Bool){
        isEnable = bool
    }
    
    var dir = String()
    
    //MARK: INIT VIEW
    func initView(){
        dir = direction
        setRightView()
        setLeftView()
        setStopView()
        inputText.transform(text.isPersianString ? CGAffineTransform(y: -2) : .identity)
    }
    
    //MARK: RIGHT VIEW
    var rightView = UIView()
    func setRightView(){
        rightView.frame(isRTL ? width/3 * 2 : 0,
                        0,
                        width/3,
                        height-4)
        rightView.onTap(self, #selector(tapRight))
        setRightGradient()
        setRightMask()
        setTextTitle()
        addSubview(rightView)
    }
    
    //MARK: RIGHT GRADIENT
    var rightGradient = CAGradientLayer()
    func setRightGradient(){
        rightGradient.frame(rightView.bounds)
        rightGradient.colors([gray01, gray02])
        rightGradient.startPoint(0, 0)
        rightGradient.endPoint(0, 1)
        rightView.addSublayer(rightGradient)
    }
    
    //MARK: TAP RIGHT
    @objc func tapRight(){
        if !focus && canFocus{
            inputText.becomeFirstResponder()
        }
    }
    
    //MARK: RIGHT MASK
    var rightMask = UIView()
    func setRightMask(){
        rightMask.frame(rightView.bounds)
        let rightShape = CAShapeLayer()
        rightShape.frame(rightMask.bounds)
        let path = isRTL ?
            rightShape.roundCorner(rt: corner, lt: 0, lb: 0, rb: corner) :
            rightShape.roundCorner(rt: 0, lt: corner, lb: corner, rb: 0)
        rightShape.path(path)
        
        rightMask.addSublayer(rightShape)
        rightView.mask(rightMask)
    }
    
    //MARK: TITLE
    var textTitle = UILabel()
    func setTextTitle(){
        textTitle.frame(5,
                        rightView.y-rightView.height/2,
                        rightView.width-10,
                        rightView.height)
        textTitle.textColor(gray07)
        textTitle.font(Sahel_Bold, 16)
        textTitle.textAlignment(isRTL ? .left : .right)
        textTitle.adjustsFontSizeToFitWidth(true)
        textTitle.text(title)
        rightView.addSubview(textTitle)
    }
    
    //MARK: LEFT VIEW
    var leftView = UIView()
    func setLeftView(){
        leftView.frame(isRTL ? 0 : width/3,
                       0,
                       width - rightView.width + 1,
                       rightView.height)
        setLeftGradient()
        setLeftMask()
        setHolder()
        setInputText()
        setClear()
        setClearGesture()
        addSubview(leftView)
    }
    
    //MARK: LEFT GRADIENT
    var leftGradient = CAGradientLayer()
    func setLeftGradient(){
        leftGradient.frame(leftView.bounds)
        leftGradient.colors([gray0, gray01])
        leftGradient.startPoint(0, 0)
        leftGradient.endPoint(0, 1)
        leftView.addSublayer(leftGradient)
    }
    
    //MARK: LEFT MASK
    var leftMask = UIView()
    func setLeftMask(){
        leftMask.frame(leftView.bounds)
        let leftShape = CAShapeLayer()
        leftShape.frame(leftMask.bounds)
        let path = isRTL ?
            leftShape.roundCorner(rt: 0, lt: corner, lb: corner, rb: 0) :
            leftShape.roundCorner(rt: corner, lt: 0, lb: 0, rb: corner)
        leftShape.path(path)
        leftMask.addSublayer(leftShape)
        leftView.mask = leftMask
    }
    
    //MARK: HOLDER
    var holder = UILabel()
    func setHolder(){
        holder.frame(10,
                     leftView.y-leftView.height/2,
                     width - rightView.width - 20,
                     leftView.height)
        holder.font(Sahel, 21)
        holder.text(placeholder)
        holder.textColor(gray03)
        holder.textAlignment(.center)
        holder.opacity(text.count>0 ? 0 : 1)
        holder.adjustsFontSizeToFitWidth(true)
        leftView.addSubview(holder)
    }
    
    //MARK: INPUT TEXT
    var inputText = UITextField()
    func setInputText(){
        inputText.frame(10,
                        leftView.y-leftView.height/2,
                        width - rightView.width - 20,
                        leftView.height)
        inputText.font(Sahel, 21)
        inputText.textColor(gray07)
        inputText.textAlignment(.center)
        inputText.autocorrectionType(.no)
        inputText.tintColor(gray01)
        inputText.adjustsFontSizeToFitWidth(true)
        inputText.delegate(self)
        inputText.isUserInteractionEnabled(isEnable)
        inputText.opacity(isEnable ? 1 : 0.7)
        inputText.editingChanged(self, #selector(onFocus))
        inputText.editingDidBegin(self, #selector(onFocus))
        inputText.editingDidEnd(self, #selector(onEnd))
        leftView.addSubview(inputText)
    }
        
    func closeKeyboard(){
        inputText.resignFirstResponder()
    }
    
    func focusKeyboard(){
        inputText.becomeFirstResponder()
    }
    
    @objc func onEnd(){
        endEditing()
    }
    
    //MARK: CLEAR
    var clear = UIImageView()
    func setClear(){
        clear.frame(isRTL ? 10 : leftView.width - 10,
                    10,
                    0,
                    0)
        clear.image(UIImage(CLEAR_02_IMG)!)
        clear.contentMode(.scaleAspectFill)
        clear.shadow(.zero, gray07, 0.5, 0.7)
        leftView.addSubview(clear)
    }
    
    var clearGesture = UIView()
    func setClearGesture(){
        clearGesture.frame(isRTL ? 0 : leftView.width - 20,
                           0,
                           20,
                           20)
        clearGesture.isHidden(true)
        clearGesture.onTap(self, #selector(onClean))
        leftView.addSubview(clearGesture)
    }
    
    @objc func onClean(){
        text = ""
        if focus{
            onFocus()
        }else{
            cleanClear()
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if isCharactersCheck{
            let invalidCharacters = CharacterSet(charactersIn: enableCharacters).inverted
            return string.rangeOfCharacter(from: invalidCharacters,
                                           options: [],
                                           range: string.startIndex ..< string.endIndex) == nil
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        onReturn()
        return true
    }
    
    func onReturn() {
        delegateTextEditor?.onReturn()
    }
    
    //MARK: STOP
    func setStopView(){
        isHidden(true)
        rightMask.x(isRTL ? -(rightView.width/2+5) : rightView.width*1.5+5)
        rightView.x(isRTL ? width/3 * 2 : rightView.width)
        leftMask.x(isRTL ? leftView.width*1.5+5 : -(leftView.width/2+10))
        leftView.x(isRTL ? width/2 - leftView.width/2 : rightView.width*2+rightView.width/2)
    }
    
    //MARK: START VIEW
    var canFocus = false
    func startView(delay: CFTimeInterval = 0){
        let duration: CFTimeInterval = 1.0
        isHidden(false)
        enable = true
        hiddenTimer.invalidate()
        rightMask.animate(x: rightView.width/2, 1.0, curveEaseInOut05, delay)
        rightView.animate(x: isRTL ? width/3 * 2 + rightView.width/2 : rightView.width/2,
                          duration, curve, delay)
        leftMask.animate(x: leftView.width/2, 1.0, curveEaseInOut05, delay)
        leftView.animate(x: isRTL ? leftView.width/2 : leftView.width/2 + rightView.width-1,
                         duration, curve, delay)
        var _ = Timer.schedule(1.0 + delay) { _ in
            self.canBeFocus()
        }
    }
    
    @objc func canBeFocus(){
        canFocus = true
    }
    
    //MARK: CLOSE VIEW
    var hiddenTimer = Timer()
    func closeView(delay: CFTimeInterval = 0){
        if enable{
            let duration: CFTimeInterval = 0.8
            enable = false
            canFocus = false
            rightMask.animate(x: dir == RTL ? -(rightView.width/2 + 5) : rightView.width*1.5,
                              duration, curve, delay)
            rightView.animate(x: dir == RTL ? width/3 * 2 : rightView.width,
                              duration, curve, delay)
            leftMask.animate(x: dir == RTL ? leftView.width + leftView.width/2 + 5 : -(leftView.width/2+10),
                             duration, curve, delay)
            leftView.animate(x: dir == RTL ? width/2 - leftView.width/2 : rightView.width*2 + rightView.width/2,
                             duration, curve, delay)
            hiddenTimer = Timer.schedule(0.8 + delay) { _ in
                self.isHidden(true)
            }
        }
    }
    
    var first = true
    
    //MARK: ON FOCUS
    @objc func onFocus(){
        feedback()
        focus = true
        delegateTextEditor?.onFocus()
        
        if text.count > 0 {
            showClear(0.3)
        }else {
            cleanClear()
        }
        select()
        inputText.textColor(gray00)
        textEditorSelected(cell: title)
    }
    
    func feedback(){
        if first {
            first = false
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
    func holderHandle(){
        holder.animate(opacity: text.count>0 ? 0 : 1, 0.2, curve)
    }
    
    func textEditorSelected(cell: String) {
        delegateTextEditor?.textEditorSelected(cell: cell)
    }
    
    //MARK: END EDITING
    func endEditing(){
        first = true
        focus = false
        holderHandle()
        cleanClear()
        deDelect()
        inputText.textColor(gray07)
    }
    
    //MARK: SELECT
    func select(){
        holderHandle()
        holder.textColor(gray0.opacity(0.6))
        rightGradient.animate(colors: [gray01, gray0], 0.8, easeInOut)
        leftGradient.animate(colors: [selectedColor02, selectedColor01], 0.8, easeInOut)
    }
    
    //MARK:  DESELECT
    func deDelect(_ delay: CFTimeInterval = 0){
        holder.textColor(gray03)
        rightGradient.animate(colors: [gray01, gray02], 0.7, easeInOut)
        leftGradient.animate(colors: [gray0, gray01], 0.7, easeInOut)
    }
    
    //MARK: SHOW CLEAR
    func showClear(_ delay: CFTimeInterval = 0){
        clearGesture.isHidden(false)
        clear.animate(size: CGSize(10, 10), 0.4, 0.4, delay)
        clear.animate(opacity: 0.8, 0.4, curve, delay)
    }
    
    //MARK: CLEAN CLEAR
    func cleanClear(){
        clearGesture.isHidden(true)
        clear.animate(size: .zero, 0.4, 3)
        clear.animate(opacity: 0, 0.4, curve)
    }
}

