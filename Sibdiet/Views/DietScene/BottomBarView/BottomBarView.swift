//
//  BottomBarView.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/16/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol BottomBarDelegate {
    func onPrescription()
    func onDiet()
    func onSupplement()
    func onFamily()
    func onQuestion()
}

class BottomBarView: UIView, BottomBarDelegate{
    
    var delegateBottomBar: BottomBarDelegate?
    func delegate(_ delegate: BottomBarDelegate){
        self.delegateBottomBar = delegate
    }
    
    var weekDay = String()
    func weekDay(_ day: String){
        self.weekDay = day
    }
    
    let now = Date()
    
    var answerRequestDelay = Timer()
    var hasFamily = users.hasFamily
    let values = BottomBarValues()
    var devid: CGFloat { hasFamily ? 10 : 8 }
    
    //MARK: INIT VIEW
    func initView(){
        setBackground()
        startView()
        if hasQuestion {
            checkNewAnswer()
        }
    }
    
    //MARK: BACKGROUND
    var background = UIView()
    func setBackground(){
        background.frame(bounds)
        background.backgroundColor(barBackgroundColor)
        background.shadow(CGSize(0, -1), gray09, 2, 0.7)
        setPrescriptionsButton()
        setDietDayButton()
        setSupplementButton()
        if hasFamily {setFamilyButton()}
        setQuestionButton()
        addSubview(background)
    }
    
    //MARK: QUESTION
    var questionButton = BarButton()
    func setQuestionButton(){
        questionButton.frame(width/devid * (hasFamily ? 9 : 7) - 30, hasSafeArea ? 4 : 2, 60, 52)
        questionButton.image01(QUESTION_IMG)
        questionButton.image02(ANSWER_IMG)
        questionButton.text(values.question)
        questionButton.initView()
        questionButton.onTap(self, #selector(onQuestion))
        background.addSubview(questionButton)
    }
    
    @objc func onQuestion(){
        delegateBottomBar?.onQuestion()
    }
    
    @objc func checkNewAnswer(){
        questionAnswerConnection.checkAnswer()
    }
    
    func reciveAnswer(){
        answerRequestDelay.invalidate()
        questionButton.selectedButton()
        questionButton.title.text(values.answer)
    }
    
    func retryCheckAnswer(){
        answerRequestDelay = Timer.scheduledTimer(timeInterval: 30,
                                                  target: self,
                                                  selector: #selector(checkNewAnswer),
                                                  userInfo: nil,
                                                  repeats: false)
    }
    
    //MARK: PRESCRIPTION
    var prescriptionsButton = BarButton()
    func setPrescriptionsButton(){
        prescriptionsButton.frame(width/devid * (hasFamily ? 7 : 5) - 30, hasSafeArea ? 4 : 2, 60, 52)
        prescriptionsButton.image01(PRESCRIPTION01_IMG)
        prescriptionsButton.image02(PRESCRIPTION02_IMG)
        prescriptionsButton.text(values.prescription)
        prescriptionsButton.initView()
        prescriptionsButton.onTap(self, #selector(onPrescription))
        background.addSubview(prescriptionsButton)
    }
    
    @objc func onPrescription(){
        if prescriptionsButton.enable && !prescriptionsButton.selected{
            delegateBottomBar?.onPrescription()
            prescriptionsButton.selectedButton()
            dietDayButton.deSelectButton()
            supplementButton.deSelectButton()
        }
    }
    
    //MARK: DIET
    var dietDayButton = BarButton()
    func setDietDayButton(){
        dietDayButton.frame(width/devid * (hasFamily ? 5 : 3) - 30, hasSafeArea ? 4 : 2, 60, 52)
        dietDayButton.image01(DIET01_IMG)
        dietDayButton.image02(DIET02_IMG)
        dietDayButton.text(values.diet)
        dietDayButton.selected = Date().persianWeekDay == weekDay || Date().weekDay == weekDay
        dietDayButton.initView()
        dietDayButton.onTap(self, #selector(onDiet))
        background.addSubview(dietDayButton)
    }
    
    @objc func onDiet(){
        if dietDayButton.enable && !dietDayButton.selected{
            delegateBottomBar?.onDiet()
            dietDayButton.selectedButton()
            supplementButton.deSelectButton()
            prescriptionsButton.deSelectButton()
        }
    }
    
    //MARK: SUPPLEMENT
    var supplementButton = BarButton()
    func setSupplementButton(){
        supplementButton.frame(width/devid * (hasFamily ? 3 : 1) - 30, hasSafeArea ? 4 : 2, 60, 52)
        supplementButton.image01(SUPPLEMENT01_IMG)
        supplementButton.image02(SUPPLEMENT02_IMG)
        supplementButton.text(values.supplements)
        supplementButton.onTap(self, #selector(onSupplement))
        supplementButton.initView()
        background.addSubview(supplementButton)
    }
    
    @objc func onSupplement(){
        if supplementButton.enable && !supplementButton.selected{
            delegateBottomBar?.onSupplement()
            supplementButton.selectedButton()
            dietDayButton.deSelectButton()
            prescriptionsButton.deSelectButton()
        }
    }
    
    //MARK: FAMILY
    var familyButton = BarButton()
    func setFamilyButton(){
        familyButton.frame((width/10) - 30, hasSafeArea ? 4 : 2, 60, 52)
        familyButton.image01(FAMILY_IMG)
        familyButton.text(values.family)
        if hasFamily{ familyButton.onTap(self, #selector(onFamily)) }
        familyButton.initView()
        background.addSubview(familyButton)
    }
    
    @objc func onFamily(){
        delegateBottomBar?.onFamily()
    }
    
    //MARK: START VIEW
    func startView(){
        background.transformY(background.height)
        background.animate(transform: .identity, 0.7, curve, 0.2)
    }
    
    //MARK: CLOSE VIEW
    func closeView(){
        answerRequestDelay.invalidate()
        questionAnswerConnection.cancelRequest()
        background.animate(transformY: background.height, 0.7, curve)
        var _ = Timer.schedule(2) { _ in self.remove() }
    }
}
