//
//  QuestionView.swift
//  Sibdiet
//
//  Created by freeman on 1/20/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol QuestionViewDelegate {
    func setDietScene()
    func background(_ color: UIColor)
}

class QuestionView: UIView, QuestionViewDelegate, QuestionCellDelegate, QuestionAnswerListDelegate, AVAudioPlayerDelegate, QuestionAnswerListViewDelegate{
    
    var delegateQuestionView: QuestionViewDelegate?
 
    var QAListY: CGFloat{
        get{ standard.object(forKey: "QAListY") as? CGFloat ?? CGFloat() }
        set{ standard.set(newValue, forKey: "QAListY") }
    }
    
    let values = QuestionValues()
    
    var answerRequestDelay = Timer()

    var isKeyboardEnable: Bool{ questionCell.paragraph.resignFirstResponder() }
    
    //MARK: INIT VIEW
    func initView(_ delegate: QuestionViewDelegate){
        delegateQuestionView = delegate
        questionAnswer.delegateQuestion(self)
        background(gray0)
        observerKeyboard()
        checkAnswer()
        setTopBar()
        setQuestionCell()
        setQuestionAnswerList()
        startView()
        addSubview(questionAnswerList)
        addSubview(topBar)
        addSubview(questionCell)
    }
    
    func background(_ color: UIColor){
           delegateQuestionView?.background(color)
       }
    
    //MARK: OBSERVER KEYBOARD
    func observerKeyboard(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardMovements(notification:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    //MARK: CHECK ANSWER
    func checkAnswer(){
        if hasQuestion {
            answerRequestDelay = Timer.scheduledTimer(timeInterval: 2,
                                                      target: self,
                                                      selector: #selector(checkNewAnswer),
                                                      userInfo: nil,
                                                      repeats: false)
        }
    }
    
    //MARK: CHECK NEW ANSWER
    @objc func checkNewAnswer(){
        questionAnswerConnection.getAnswer()
    }
    
    func notReciveAnswer() {
        answerRequestDelay.invalidate()
        questionAnswerConnection.cancelRequest()
        answerRequestDelay = Timer.scheduledTimer(timeInterval: 30,
                                                  target: self,
                                                  selector: #selector(checkNewAnswer),
                                                  userInfo: nil,
                                                  repeats: true)
    }
    
    //MARK: TOPBAR
    var topBar = UIView()
    func setTopBar(){
        topBar.frame(topFrame)
        topBar.shadow(CGSize(0, 1), gray09, 0.5, 0.5)
//        topBar.blurBack(2, 1)
        topBar.backgroundColor(barBackgroundColor.opacity(0.8))
        setName()
        setSubTitle()
        setBackButton()
    }
    
    //MARK: NAME
    var name = UILabel()
    func setName(){
        name.frame(70,
                   topBar.height - (hasSafeArea ? 60 : 57),
                   width-140,
                   35)
        name.text(profile.fullName)
        name.font(Sahel_Bold, 24)
        name.textColor(profileColor)
        name.textAlignment(.center)
        name.adjustsFontSizeToFitWidth(true)
        topBar.addSubview(name)
    }
    
    //MARK: SUBTITLE
    var subTitleText = SubTitle()
    func setSubTitle(){
        let string = values.subTitle
        let font = values.subTitleFont
        let width = string.width(height: 20, font: font) + 10
        subTitleText.frame(topBar.width/2 - width/2,
                           topBar.height - 22,
                           width,
                           20)
        subTitleText.string(string)
        subTitleText.backColor(profileColor)
        subTitleText.font(font)
        subTitleText.initView()
        topBar.addSubview(subTitleText)
    }
    
    //MARK: BACK BUTTON
    var backButton = BarButton()
    func setBackButton(){
        backButton.frame(isRTL ? width - 63 : 3,
                         topBar.height - (hasSafeArea ? 58 :  54),
                         60,
                         52)
        backButton.image01(BACK_IMG)
        backButton.text(values.backButtonTitle)
        backButton.onTap(self, #selector(backView))
        backButton.initView()
        topBar.addSubview(backButton)
    }
    
    var isClose = true
    @objc func backView(){
        if isClose{
            isClose = false
            closeView()
            questionAnswerConnection.cancelRequest()
            var _ = Timer.schedule(0.5) { _ in
                self.setDietScene()
            }
        }
    }
    
    @objc func setDietScene() {
        delegateQuestionView?.setDietScene()
    }
       
    //MARK: QUESTION ANSWER LIST
    var questionAnswerList = QuestionAnswerListView()
    func setQuestionAnswerList(){
        questionAnswerList.frame(0,
                                 topBar.height,
                                 width,
                                 height-(topBar.height+questionCell.height+10))
        questionAnswerList.containerY(QAListY)
        questionAnswerList.delegate(self)
        questionAnswerList.initView()
    }
    
    func change(y: CGFloat) {
        QAListY = y
    }
    
    //MARK: EXIT KEYBOARD
    func exitKey(){
        let upY: CGFloat = hasSafeArea ? !inEddit ? 7 : 9 : !inEddit ? 7 : -2
        questionCell.closeKeyboard()
        let questionCellY = height - questionCell.height/2 - upY
        questionCell.animate(y: questionCellY - upY, 0.7, 0.6)
        let topY = topBar.height/2 + topBar.y
        let j = height - (questionCell.y - questionCell.height/2)
        let k = height - topY
        let height = k - j
        let y = topY + height/2
        questionAnswerList.animate(height: height, 0.6, curveEaseOut04)
        questionAnswerList.animate(y: y, 0.6, curveEaseOut04)
        questionAnswerList.moveY()
    }
    
    //MARK: QUESTION CELL
    var questionCell = QuestionCell()
    var questionCellY = CGFloat()
    var questionCellViewHeight = CGFloat()
    var questionCellHeight: CGFloat = 93
    func setQuestionCell(){
        let height: CGFloat = hasSafeArea ? 94 : 84
        let y: CGFloat = self.height - height - 14
        questionCellViewHeight = height
        questionCell.frame(-1, y, width+2, height)
        questionCell.cellHeight(questionCellHeight)
        questionCellY = questionCell.y
        questionCell.corner(20)
        questionCell.result(questionAnswer.message)
        questionCell.holder(values.holder)
        questionCell.initView()
        questionCell.onPan(self, #selector(onPanQuestionCell(pan:)))
        questionCell.delegateQuestionCell = self
    }
    
    var cellY: CGFloat!
    @objc func onPanQuestionCell(pan: UIPanGestureRecognizer){
        let translationY = pan.translation(in: questionCell).y
        switch pan.state {
        case .began: cellY = questionCell.y
        case .changed:
            let y = translationY + cellY
            questionCell.y(y > cellY ? y : questionCell.y)
            if y > cellY { questionCell.closeKeyboard() }
        case .ended: if questionCell.y > cellY { exitKey() }
        default: break
        }
    }
    
    //MARK: ON EDDITING
    var inEddit = false
    var paragraphH = CGFloat()
    func onEdditingParagraph(paragraphHeight: CGFloat) {
        paragraphH = paragraphHeight
        inEddit = true
        questionAnswer.message = questionCell.result
        let curve = curveEaseOut04
        let duration: CFTimeInterval = 0.43
        let height = questionCellHeight-questionCellViewHeight+paragraphHeight
        questionCell.animate(height: height, duration, curve)
        let y = questionCellY - keyHeight - (paragraphHeight-questionCellHeight)/2 - (-8)
        questionCell.animate(y: y, duration, curve)
        let distance: CGFloat = !questionAnswerList.isScrollable ? 10 : -5
        let topY = topBar.height/2 + topBar.y
        let j = height - (questionCell.y - questionCell.height/2)
        let k = height - topY
        let questionAnswerHeight = k - j
        let questionAnswerY = topY + questionAnswerHeight/2-distance
        questionAnswerList.animate(height: questionAnswerHeight, duration, curve)
        questionAnswerList.animate(y: questionAnswerY, duration, curve)
        questionAnswerList.container.animate(y: questionAnswerList.bottomList-distance, duration, curve)
    }
    
    var keyHeight = CGFloat()
    @objc func handleKeyboardMovements(notification: Notification) {
        let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height
        if keyHeight != height{
            keyHeight = height
            onEdditingParagraph(paragraphHeight: paragraphH)
        }
    }
    
    //MARK: SEND QUESTION
    func sendQuestion() {
        answerRequestDelay.invalidate()
        let curve = curveEaseOut05
        questionAnswerConnection.cancelRequest()
        questionAnswer.message = ""
        let downY: CGFloat = hasSafeArea ? 34 : 0
        let questionCellY = height+questionCell.height/2+downY
        if isKeyboardEnable{
            questionCell.closeKeyboard()
            questionCell.animate(y: questionCellY, 0.5, curveEaseOut02)
        }else{ questionCell.animate(y: questionCellY, 0.5, curve) }
        let upY: CGFloat = hasSafeArea ? 18 : -4
        let expand: CGFloat = hasSafeArea ? 0 : 10
        questionCell.animate(height: questionCellHeight+expand, 0.7, curve)
        let questionCell02Y = height - questionCell.height/2 - upY
        questionCell.animate(y: questionCell02Y, 0.7, curve, 0.8)
        let topY = topBar.height/2 + topBar.y
        let j = height - (questionCell.y - questionCell.height/2)
        let k = height - topY
        let questionAnswerHeight = k - j
        let questionAnswerY = topY + questionAnswerHeight/2
        questionAnswerList.animate(height: questionAnswerHeight, 0.7, curve)
        questionAnswerList.animate(y: questionAnswerY, 0.7, curve)
        questionAnswerList.container.animate(y: questionAnswerList.bottomList, 0.7 , curve)
        var _ = Timer.schedule(0.5) { _ in
            self.questionCell.resetCell()
            self.questionAnswerList.showNewQuestion()
        }
        answerRequestDelay = Timer.scheduledTimer(timeInterval: 30,
                                                  target: self,
                                                  selector: #selector(checkNewAnswer),
                                                  userInfo: nil,
                                                  repeats: true)
    }

    //MARK: START VIEW
    var enable = false
    func startView(){
        enable = true
        topBar.transformY(-topBar.height)
        topBar.animate(transform: .identity, 0.7, curve, 0.4)
        questionCell.transformY(questionCell.height+20)
        questionCell.animate(transform: .identity, 0.7, curve, 0.4)
    }
    
    //MARK: CLOSE VIEW
    @objc func closeView(){
        inEddit = false
        enable = false
        answerRequestDelay.invalidate()
        questionAnswerConnection.cancelRequest()
        questionCell.closeKeyboard()
        topBar.animate(transformY: -topBar.height, 0.7, curve, 0.3)
        let downY: CGFloat = hasSafeArea ? 34 : 0
        let questionCellY = height+questionCell.height/2+downY
        if isKeyboardEnable{ questionCell.animate(y: questionCellY, 0.5, curveEaseIn03) }
        else{ questionCell.animate(y: questionCellY, 0.7, curve, 0.3) }
        let listY = questionAnswerList.containerHeight/2 + height - topBar.height
        questionAnswerList.container.animate(y: listY, 1, curve)
        var _ = Timer.schedule(2) { _ in self.remove() }
    }
}
