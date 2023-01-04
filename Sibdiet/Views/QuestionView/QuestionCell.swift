//
//  QuestionCell.swift
//  Sibdiet
//
//  Created by freeman on 1/22/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import UIKit
import AVFoundation

protocol QuestionCellDelegate {
    func onEdditingParagraph(paragraphHeight: CGFloat)
}

class QuestionCell: UIView, UITextViewDelegate, QuestionCellDelegate, AVAudioPlayerDelegate{
    
    var delegateQuestionCell: QuestionCellDelegate?
    
    var cellHeight: CGFloat = 105
    func cellHeight(_ height: CGFloat){
        self.cellHeight = height
    }
    
    var corner = CGFloat()
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var result = String()
    func result(_ string: String){
        self.result = string
    }

    var holder = String()
    func holder(_ holder: String){
        self.holder = holder
    }
    
    let curve = curveEaseOut05
    
    //MARK: INIT VIEW
    func initView(){
        setBackground()
        setForground()
        if result != ""{ deSelectColor() }
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackground(){
        background.frame(10, 5, width-20, cellHeight-10)
        background.backgroundColor(white01)
        background.cornerRadius(corner)
        background.shadow(.zero, gray07, 4, 0.8)
        addSubview(background)
    }
    
    //MARK: FOREGROUND
    var forground = UIView()
    func setForground(){
        forground.frame(5, 5, background.width-10, background.height-10)
        forground.backgroundColor(white.opacity(0.7))
        forground.cornerRadius(corner-4)
        forground.clipsToBounds(true)
        setParagraphHolder()
        setParagraph()
        setVerticalLine()
        setSendButton()
        background.addSubview(forground)
    }

    //MARK: HOLDER
    var paragraphHolder = UILabel()
    func setParagraphHolder(){
        paragraphHolder.frame(isRTL ? 50 : 10,
                              0,
                              forground.width-60,
                              forground.height)
        paragraphHolder.backgroundColor(.clear)
        paragraphHolder.numberOfLines(0)
        paragraphHolder.font(Sahel, 19)
        paragraphHolder.textAlignment(isRTL ? .right : .left)
        paragraphHolder.textColor(gray04)
        paragraphHolder.text(holder)
        forground.addSubview(paragraphHolder)
    }
    
    //MARK: PARAGRAPH
    var paragraph = UITextView()
    func setParagraph(){
        paragraph.frame(isRTL ? 55 : 5,
                        0,
                        forground.width-60,
                        forground.height)
        paragraph.backgroundColor(UIColor.clear)
        paragraph.isEditable(true)
        paragraph.font(Sahel, 19)
        paragraph.textAlignment(result.isPersianString ? .right : .natural)
        paragraph.textColor(gray07)
        paragraph.autocorrectionType(.no)
        paragraph.text(result)
        paragraph.isMultipleTouchEnabled(true)
        paragraph.delegate(self)
        paragraph.tintColor(sand02)
        forground.addSubview(paragraph)
    }
    
    func closeKeyboard(){
        paragraph.resignFirstResponder()
    }
    
    //MARK: VERTICAL LINE
    var verticalLine = CAGradientLayer()
    func setVerticalLine(){
        verticalLine.frame(isRTL ? 52 :  forground.width - 52,
                           5,
                           1.2,
                           forground.height-10)
        verticalLine.colors([white01, gray03])
        verticalLine.startPoint(0, 0)
        verticalLine.endPoint(1, 0)
        forground.addSublayer(verticalLine)
    }
    
    //MARK: SEND BUTTON
    var sendButton = UILabel()
    func setSendButton(){
        sendButton.frame(isRTL ? 0 : forground.width-50,
                         forground.height/2-forground.height/4,
                         50,
                         forground.height/2)
        sendButton.font(Sahel_Bold, 18)
        sendButton.textAlignment(.center)
        sendButton.text(isRTL ? "ارسال" : "Send")
        sendButton.textColor(gray03)
        sendButton.onTap(self, #selector(tapSend), 1)
        forground.addSubview(sendButton)
    }
    
    @objc func tapSend(){
        if sendButton.textColor == skyBlue01{
            if isConnected {
                sendParagraph()
            }else {
                dietConnection.connectionError()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        onEditting()
    }
    
    //MARK: PLAYER
    var player: AVAudioPlayer?
    @objc func playSound(source: String){
        let url = Bundle.main.url(forResource: source, withExtension: CAF_EXTENSION)!
        do {
            let b = AVAudioSession.sharedInstance().isOtherAudioPlaying
            player = try AVAudioPlayer(contentsOf: url)
            if !b{ player?.play() }
        } catch _ as NSError {
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        onEditting()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        deSelectColor()
    }
    
    @objc func onEditting(){
        result = paragraph.text ?? String()
        selectColor()
        getRow()
    }
    
    //MARK: SELECT COLOR
    func selectColor(){
        verticalLine.animate(colors: [white, gray03], 1, easeInOut05)
        background.animate(backgroundColor: white, 1, curve)
        forground.animate(backgroundColor: white01, 1, curve)
        background.layer.animate(shadowColor: white, 0.8, easeOut)
        handleHolder()
    }
    
    //MARK: DESELECT COLOR
    func deSelectColor(){
        verticalLine.animate(colors: [white02, white], 1, easeInOut05)
        background.animate(backgroundColor: white01.opacity(0.9), 1, curve)
        forground.animate(backgroundColor: white.opacity(0.7), 1, curve)
        background.layer.animate(shadowColor: gray07, 0.8, easeOut)
        handleHolder()
    }
    
    func handleHolder(){
        paragraphHolder.animate(opacity: result == "" ? 1 : 0, 0.4, curve)
        sendButton.textColor(result == "" ? gray03 : skyBlue01)
    }
    
    //MARK: GET ROW
    func getRow(){
        let height = paragraph.paragraphHeight+0.5
        if height <= 76 {
            resizeCell(paragraphHeight: 76)
            paragraph.isScrollEnabled(false)
        }else if height <= 165{
            resizeCell(paragraphHeight: height)
            paragraph.isScrollEnabled(height > 164.5)
        }else if height > 164.5{
            resizeCell(paragraphHeight: 165)
        }
    }
    
    //MARK: RESIZE CELL
    func resizeCell(paragraphHeight: CGFloat){
        let backgroundHeight = paragraphHeight+10
        let cellHeight = paragraphHeight+20
        let curve = curveEaseOut04
        let duration: CFTimeInterval = 0.43
        background.animate(height: backgroundHeight, duration, curve)
        background.animate(y: backgroundHeight/2+5, duration, curve)
        forground.animate(height: paragraphHeight, duration, curve)
        forground.animate(y: paragraphHeight/2+5, duration, curve)
        paragraph.animate(height: paragraphHeight, duration, curve)
        paragraph.animate(y: paragraphHeight/2, duration, curve)
        sendButton.animate(y: paragraphHeight/2, duration, 0.5, 0.2)
        verticalLine.animate(height: paragraphHeight-10, duration, easeOut04)
        verticalLine.animate(y: (paragraphHeight-10)/2+5, duration, easeOut04)
        onEdditingParagraph(paragraphHeight: cellHeight)
    }
    
    func onEdditingParagraph(paragraphHeight: CGFloat) {
        delegateQuestionCell?.onEdditingParagraph(paragraphHeight: paragraphHeight)
    }
    
    //MARK: SEND
    func sendParagraph(){
        questionAnswerConnection.askQuestion()
        sendButton.animate(y: forground.height*2, 0.5, curveEaseIn05, 0.05)
    }
    
    //MARK: RESET CELL
    func resetCell(){
        deSelectColor()
        result = ""
        paragraph.text = ""
        paragraphHolder.opacity = 1
        sendButton.textColor = gray03
        let paragraphHeight: CGFloat = 76
        let backgroundHeight = paragraphHeight+10
        let curve = curveEaseOut04
        let duration: CFTimeInterval = 0.43
        background.animate(height: backgroundHeight,duration, curve)
        background.animate(y: backgroundHeight/2+5, duration, curve)
        forground.animate(height: paragraphHeight, duration, curve)
        forground.animate(y: paragraphHeight/2+5, duration, curve)
        paragraph.animate(height: paragraphHeight, duration, curve)
        paragraph.animate(y: paragraphHeight/2, duration, curve)
        sendButton.animate(y: paragraphHeight/2, duration, 0.5, 0.2)
        verticalLine.animate(height: paragraphHeight-10, duration, easeOut04)
        verticalLine.animate(y: (paragraphHeight-10)/2+5, duration, easeOut04)
    }
}
