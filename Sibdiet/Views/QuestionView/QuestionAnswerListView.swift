//
//  QuestionAnswerListView.swift
//  Sibdiet
//
//  Created by Amin on 2/14/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

protocol QuestionAnswerListViewDelegate {
    func change(y: CGFloat)
}

class QuestionAnswerListView : UIView, AVAudioPlayerDelegate, ReciveAnswerDelegate, QuestionAnswerListViewDelegate{
    
    var delegateQuestionAnswerListView:QuestionAnswerListViewDelegate?
    func delegate(_ delegate: QuestionAnswerListViewDelegate){
        delegateQuestionAnswerListView = delegate
    }

    var containerY = CGFloat()
    func containerY(_ y : CGFloat){
        containerY = y
    }
    
    //MARK: INIT VIEW
    func initView(){
        questionAnswer.reciveAnswerDelegate(self)
        setContainer()
        read()
        startView()
    }
    
    //MARK: CONTAINER
    var container = UIView()
    func setContainer(){
        container.frame(0, 0, width, containerHeight)
        container.onPan(self, #selector(onPan(pan:)))
        setQuestionAnswerList()
    }
    
    var bottomList: CGFloat{ isScrollable ? height-containerHeight/2-5 : height/2 }
    var isScrollable : Bool { height<containerHeight }
    
    var containerHeight : CGFloat{
        var result: CGFloat = 10
        for qa in questionAnswer.questionAnswers{ result += qa.questionAnswerCellHeight+10 }
        return result
    }
    
    //MARK: ON PAN
    var formY: CGFloat!
    @objc func onPan(pan: UIPanGestureRecognizer){
        let top = containerHeight/2 - 10
        let translation = pan.translation(in: self)
        switch pan.state {
        case .began:
            formY = container.y
        case .changed:
            container.y(isScrollable ? formY+translation.y : formY+translation.y/4)
        case .ended:
            let velocity = pan.velocity(in: self)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 300
            let slideFactor = 0.1 * slideMultiplier
            let y = (container.y + (velocity.y * slideFactor))
            let time = CFTimeInterval(slideFactor * 2)
            
            if isScrollable{
                if y > top { container.animate(y: top, 0.8, 0.8) }
                else if y < bottomList{ container.animate(y: bottomList, 0.8,  0.8) }
                else{ container.animate(y: y, time, curveEaseOut03) }
            }else{ container.animate(y: height/2, 0.8, 0.8) }
            change(y: container.y)
        default: break
        }
    }
    
    //MARK: Q&A CELL'S
    var questionAnswerCells = [QuestionAnswerCell]()
    func setQuestionAnswerList(){
        var i = -1
        for qa in questionAnswer.questionAnswers{
            i += 1
            let questionAnswerCell = QuestionAnswerCell()
            questionAnswerCells.append(questionAnswerCell)
            questionAnswerCells[i].questionAnswer = qa
            let y: CGFloat =  i != 0 ? questionAnswerCells[i-1].y + questionAnswerCells[i-1].height/2 + 10 : 10
            questionAnswerCells[i].frame(0, y, width, qa.questionAnswerCellHeight)
            questionAnswerCells[i].direction(direction)
            questionAnswerCells[i].corner(20)
            questionAnswerCells[i].opacity(0)
            questionAnswerCells[i].initView()
            container.addSubview(questionAnswerCells[i])
        }
        addSubview(container)
        var j = questionAnswerCells.count-1
        var k = -1
        var delay: CFTimeInterval = 0.4
        for cells in questionAnswerCells{
            j -= 1
            k += 1
            delay += 0.1
            cells.transformY(cells.height*3)
            cells.animate(transform: .identity, 0.7, curveEaseOut05, delay)
            cells.animate(opacity: 1, 0.7, curveEaseOut05, delay)
        }
    }
    
    //MARK: SHOW NEW QUESTION
    func showNewQuestion() {
        var _ = Timer.schedule(0.1) { _ in self.playSound(source: QUESTION_SOUND) }
        container.animate(y: bottomList, 0.6 , curveEaseOut05)
        let q = QuestionAnswerCell()
        let questions = questionAnswer.questionAnswers
        let count = questions.count
        let index = count-1
        questionAnswerCells.append(q)
        let y: CGFloat = count != 0 && count != 1 ?
            questionAnswerCells[index-1].y + questionAnswerCells[index-1].questionAnswer.questionAnswerCellHeight/2 + 10 : 10
        questionAnswerCells[index].frame(0,
                                         y,
                                         width,
                                         questions[index].questionAnswerCellHeight)
        questionAnswerCells[index].questionAnswer(questions[index])
        questionAnswerCells[index].corner(15)
        questionAnswerCells[index].direction(direction)
        questionAnswerCells[index].initView()
        container.animate(height: containerHeight, 0.6, curveEaseOut05)
        questionAnswerCells[index].transformP(1 , questionAnswerCells[index].height*3)
        questionAnswerCells[index].animate(transform: .identity, 0.6, curveEaseOut05)
        container.addSubview(questionAnswerCells[index])
        change(y: container.y)
    }
    
    //MARK: RECIVE ANSWER
    func reciveAnswer(questionAnswer: QuestionAnswer){
        var _ = Timer.schedule(0.2) { _ in self.playSound(source: ANSWER_SOUND) }
        container.animate(height: containerHeight, 0.7, curve)
        container.animate(y: bottomList, 0.7, curve)
        var i = -1
        for qa in questionAnswerCells{
            i += 1
            if qa.questionAnswer.id == questionAnswer.id{ qa.recive(answer: questionAnswer) }
            qa.animate(height: qa.questionAnswer.questionAnswerCellHeight, 0.7, curve)
            let y = i == 0 ? 10 + qa.height/2 : questionAnswerCells[i-1].y + questionAnswerCells[i-1].height/2 + 10 + qa.height/2
            qa.animate(y: y, 0.7, curve)
        }
        read()
        change(y: container.y)
    }
    
    func change(y: CGFloat) {
        delegateQuestionAnswerListView?.change(y: y)
    }
    
    //MARK: PLAYER
    var player: AVAudioPlayer?
    @objc func playSound(source: String){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
        let url = Bundle.main.url(forResource: source, withExtension: CAF_EXTENSION)!
        do {
            let b = AVAudioSession.sharedInstance().isOtherAudioPlaying
            player = try AVAudioPlayer(contentsOf: url)
            if !b{ player?.play() }
        } catch _ as NSError {
        }
    }
    
    //MARK: MOVE Y
    func moveY(){
        let containerY: CGFloat = isScrollable ? container.y > bottomList ? container.y : bottomList : height/2
        container.animate(y: containerY, 0.6, curveEaseOut04)
    }
    
    //MARK: START VIEW
    func startView(){
        if containerY == .zero{
            if isScrollable{ container.animate(y: bottomList, 1.2, curve, 0.7) }
            else{ container.animate(y: height/2, 1.2, curveEaseOut05, 0.2) }
        }else{ container.animate(y: bottomList > containerY ? bottomList : containerY, 1.2, curve, 0.7)}
    }
    
    //MARK: READ
    func read(){
        for q in questionAnswer.questionAnswers{ q.firstRead = false }
    }
}
