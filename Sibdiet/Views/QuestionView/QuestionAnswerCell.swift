//
//  QuestionAnswerCell.swift
//  Sibdiet
//
//  Created by Amin on 2/18/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class QuestionAnswerCell: UIView {
    
    var questionAnswer = QuestionAnswer()
    func questionAnswer(_ questionAnswer: QuestionAnswer){
        self.questionAnswer = questionAnswer
    }
    
    let font = UIFont(Sahel, 19)!
    
    var corner = CGFloat()
    func corner(_ corner: CGFloat){
        self.corner = corner
    }
    
    var direction = RTL
    func direction(_ direction: String){
        self.direction = direction
    }
    
    //MARK: INIT VIEW
    func initView(){
        setBackground()
        if questionAnswer.hasNewDate{ setTimeView() }
    }
    
    //MARK: TIME
    let time = UILabel()
    func setTimeView(){
        let date = questionAnswer.questionDate
        let separate = isRTL ? "،" : ","
        var string = isRTL ? date.persianWeekDay + "، " + date.persianDay + " " + date.persianMonth :
            date.weekDay + ", " + date.month + " " + date.day
        if Date().year != date.year{
            string.append("\(separate) \( isRTL ? date.persianYear : date.year )")
            let s = string.replace([ isRTL ? date.persianWeekDay + "، " : date.weekDay + ", ": ""])
            string = s
        }
        let font = UIFont(Sahel, 15)!
        let width = string.width(height: 23, font: font)+10
        time.frame(10, questionAnswer.questionDateHeight - 35, width,23)
        time.font(font)
        time.text(string)
        time.textAlignment(.center)
        time.textColor(gray03)
        time.cornerRadius(7)
        time.clipsToBounds(true)
        time.backgroundColor(gray01.opacity(0.2))
        time.border(gray01, 0.8)
        addSubview(time)
    }
    
    //MARK: BACKGROUND
    let background = UIView()
    func setBackground(){
        background.frame(10,
                         questionAnswer.questionDateHeight,
                         width-20,
                         questionAnswer.questionAnswerCellHeight - questionAnswer.questionDateHeight)
        background.backgroundColor(white.opacity(0.9))
        background.cornerRadius(corner)
        background.shadow(.zero, gray07, 2, 0.5)
        setQuestionBackground()
        setAnswerBackground()
        addSubview(background)
    }
    
    //MARK: QUESTION BG
    let questionBackground = UIView()
    func setQuestionBackground(){
        questionBackground.frame(5,
                                 5,
                                 background.width-10,
                                 questionAnswer.questionTextHeight)
        let shape = CAShapeLayer()
        shape.fillColor(questionBackColor)
        shape.frame(questionBackground.bounds)
        shape.path(shape.roundCorner(rt: corner-4, lt: corner-4, lb: 0, rb: 0))
        questionBackground.addSublayer(shape)
        setQuestionText()
        setQuestionTimeText()
        background.addSubview(questionBackground)
    }
        
    //MARK: QUESTION TEXT
    var questionText = UILabel()
    func setQuestionText(){
       let text = questionAnswer.question
        questionText.frame(questionAnswer.questionDirection == RTL ? 35 : 10,
                           0,
                           questionBackground.width-45,
                           questionAnswer.questionTextHeight)
        questionText.font(font)
        questionText.textColor(questionTextColor)
        questionText.textAlignment(questionAnswer.questionDirection == RTL ? .right : .left)
        questionText.backgroundColor(.clear)
        questionText.numberOfLines(0)
        questionText.text(text)
        questionBackground.addSubview(questionText)
    }
    
    //MARK: QUESTION TIME
    var questionTimeText = UILabel()
    func setQuestionTimeText(){
        let time = isRTL ? questionAnswer.questionTime.faNumber : questionAnswer.questionTime.enNumber
        questionTimeText.frame(questionAnswer.questionDirection == RTL ? 5 : questionBackground.width-50,
                               questionBackground.height - 17,
                               45,
                               18)
        questionTimeText.text(time)
        questionTimeText.font(Sahel, 14)
        questionTimeText.textAlignment(.center)
        questionTimeText.textColor(gray03)
        questionBackground.addSubview(questionTimeText)
    }
    
    //MARK: ANSWER BG
    var answerBackground = UIView()
    let shape = CAShapeLayer()
    func setAnswerBackground(){
        let color =  questionAnswer.firstRead ? white : gray0
        answerBackground.frame(5,
                               questionBackground.y + questionAnswer.questionTextHeight/2+2,
                               background.width-10,
                               questionAnswer.answerTextHeight)
        shape.fillColor(color)
        shape.frame(answerBackground.bounds)
        shape.path(shape.roundCorner(rt: 0, lt: 0, lb: corner-3, rb: corner-3))
        answerBackground.addSublayer(shape)
        answerBackground.clipsToBounds(true)
        setAnswerText()
        setAnswerTimeText()
        if questionAnswer.isWaitingToAnswer{ setCircles() }
        background.addSubview(answerBackground)
    }
    
    //MARK: ANSWER TEXT
    var answerText = UILabel()
    func setAnswerText(){
        let text = questionAnswer.answer
        answerText.frame(questionAnswer.answerDirection == RTL ? 35 : 10,
                         0,
                         answerBackground.width-45,
                         questionAnswer.answerTextHeight)
        answerText.font(font)
        answerText.textColor(answerTextColor)
        answerText.text(text)
        answerText.textAlignment(questionAnswer.answerDirection == RTL ? .right : .left)
        answerText.backgroundColor(.clear)
        answerText.numberOfLines(0)
        answerBackground.addSubview(answerText)
    }
    
    //MARK: ANSWER TIME
    var answerTimeText = UILabel()
    func setAnswerTimeText(){
        let time = isRTL ? questionAnswer.answerTime.faNumber : questionAnswer.answerTime.enNumber
        answerTimeText.frame(questionAnswer.answerDirection == RTL ? 5 : answerBackground.width-50,
                             answerBackground.height - 17,
                             45,
                             18)
        answerTimeText.text(time)
        answerTimeText.font(Sahel, 14)
        answerTimeText.textAlignment(.center)
        answerTimeText.textColor(gray03)
        answerBackground.addSubview(answerTimeText)
    }
    
    //MARK: CIRCLES
    var circles = Circles()
    func setCircles(){
        let w = answerBackground.height/2.5
        circles.frame(questionAnswer.answerDirection == RTL ? 10 :  answerBackground.width - 30,
                      answerBackground.height/2 - w/2,
                      w,
                      w)
        circles.duration(1.5)
        circles.colors([green02,green,green01,lime02])
        circles.timingFunction(easeOut04)
        circles.initView()
        answerBackground.addSubview(circles)
    }
    
    //MARK: RECIVE ANSWER
    func recive(answer: QuestionAnswer){
        answerText.font(font)
        let duration: CFTimeInterval = 0.7
        circles.animate(opacity: 0, duration, curve)
        let backgroundHeight = answer.questionAnswerCellHeight - answer.questionDateHeight
        let backgroundY = answer.questionDateHeight + backgroundHeight/2
        background.animate(height: backgroundHeight, duration, curve)
        background.animate(y: backgroundY, duration, curve)
        let answerBackgroundHeight = answer.answerTextHeight
        let answerBackgroundY = questionBackground.y + questionAnswer.questionTextHeight/2+2 + answerBackgroundHeight/2
        answerBackground.animate(height: answerBackgroundHeight, duration, curve)
        answerBackground.animate(y: answerBackgroundY, duration, curve)
        answerText.opacity(0)
        answerText.text(answer.answer)
        answerText.animate(opacity: 1, duration, curve)
        answerText.animate(height: answerBackgroundHeight, duration, curve)
        answerText.animate(y: answerBackgroundHeight/2, duration, curve)
        answerText.textAlignment(answer.answerDirection == RTL ? .right : .left)
        let textWidth = answerBackground.width-45
        answerText.x(answer.answerDirection == RTL ? 40+textWidth/2 : textWidth/2+5)
        shape.animate(fillColor: white, duration+0.5, easeInOut05)
        shape.frame(answerBackground.bounds)
        let newShape = shape.roundCorner(rt: 0, lt: 0, lb: corner-4, rb: corner-4)
        shape.animate(path: newShape, 0.7, easeInOut04)
        answerTimeText.opacity = 0
        answerTimeText.text(isRTL ? answer.answerTime.faNumber : answer.answerTime.enNumber)
        answerTimeText.animate(opacity: 1, 0.5, curve, 0.7)
        let answerTimeWidth = answerTimeText.width
        answerTimeText.x(answer.answerDirection == RTL ? 5+answerTimeWidth/2 : answerBackground.width-answerTimeWidth/2-5)
        answerTimeText.animate(y: answerBackground.height - 16 + answerTimeText.height/2, duration, 0.5, 0.7)
    }
}
