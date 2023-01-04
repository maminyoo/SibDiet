//
//  DietScene.swift
//  Sibdiet
//
//  Created by Amin on 2/14/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore
import StoreKit

protocol DietSceneDelegate{
    func setProfileView(_ fromView: String)
    func setIncomingScene()
    func setDietTableView()
    func setFormsScene(_ fromView: String)
    func background(_ color: UIColor)
    func setQuestionView()
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval)
    func setFamilyView()
}

class DietScene: UIView, TopBarDelegate, BottomBarDelegate, DietViewDelegate, SupplementsViewDelegate, PrescriptionsViewDelegate, AnswerDelegate, DietSceneDelegate, LunchDietDelegate, LoginFamilyDelegate{
  
    var enable = false
    
    var delegateDietScene: DietSceneDelegate?

    var loginCount: Int{
        get{ standard.integer(forKey: "counter") }
        set{ standard.set(newValue, forKey: "counter") }
    }
    
    func initView(_ delegate: DietSceneDelegate){
        loginCount += 1
        delegateDietScene = delegate
        questionAnswer.delegateAnswer(self)
        dietConnection.delegateLunchDiet = self
        dietConnection.delegateLoginFamily = self
        hideStatus(false, 0.35)
        enable = true
        onOut(false)
        setTopBar()
        setBottomBarView()
        standard.set(true, forKey: "inDietScene")
        switch dietSceneState.state {
        case DIET: setDietView()
        case SUPPLEMENT: bottomBarView.onSupplement()
        case PRESCRIPTION: bottomBarView.onPrescription()
        default: break }
        if loginCount == 7 || loginCount == 21{
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval){
        delegateDietScene?.hideStatus(bool, delay)
    }
    
    // MARK: - TOP BAR VIEW
    lazy var topBarView = TopBarView()
    @objc func setTopBar(){
        topBarView = TopBarView(topFrame)
        topBarView.weekDay(TopBarValues().diet)
        topBarView.delegate(self)
        topBarView.initView()
        addSubview(topBarView)
    }
    
    var onOut = false
    func onOut(_ bool: Bool){onOut = bool}
    func onProfile() {
        if !onOut && !inFamily{
            onOut(true)
            closeView()
            setProfileView(DIET_VIEW)
        }
    }
    
    func setProfileView(_ fromView: String) {
        delegateDietScene?.setProfileView(fromView)
    }
    
    func onAdd() {
        if !onOut && !inFamily{
            onOut(true)
            closeView()
            setIncomingScene()
        }
    }
    
    func setIncomingScene() {
        delegateDietScene?.setIncomingScene()
    }
      
    func onCalender() {
        if !onOut && !inFamily{
            onOut(true)
            closeView()
            setDietTableView()
        }
    }
    
    func setDietTableView() {
        delegateDietScene?.setDietTableView()
    }
           
    // MARK: - DIET VIEW
    lazy var dietView = DietView()
    func setDietView(){
        dietSceneState.state = DIET
        dietView = DietView(midFrame)
        dietView.delegate(self)
        dietView.weekDay(dietSceneState.weekDay)
        dietView.selectedRow(dietSceneState.selectedDiet)
        dietView.initView()
        addSubview(dietView)
    }
    
    func selectedDietRow(color: UIColor, row: Int) {
        dietSceneState.dietColor = color
        dietSceneState.selectedDiet = row
        background(color)
    }
    
    func selectWeed(day: String) {
        dietSceneState.weekDay = day
        setDietView()
    }
    
    func background(_ color: UIColor) {
        topBarView.selected(color: color)
        delegateDietScene?.background(color.opacity(0.5))
    }
    
    func updateDiet() {
        onOut(true)
        closeView()
        setFormsScene(DIET_VIEW)
    }
    
   func setFormsScene(_ fromView: String) {
        delegateDietScene?.setFormsScene(fromView)
    }
       
    // MARK: - SUPPLEMENT VIEW
    lazy var supplementsView = SupplementsView()
    func setSupplementView(){
        supplementsView = SupplementsView(midFrame)
        dietSceneState.state = SUPPLEMENT
        supplementsView.selectedRow(dietSceneState.selectedSupplementRow)
        supplementsView.delegate(self)
        supplementsView.initView()
        addSubview(supplementsView)
    }
    
    func selectedSupplementsRow(color: UIColor, row: Int) {
        dietSceneState.selectedSupplementRow = row
        dietSceneState.supplementColor = color
        background(color)
    }
    
    // MARK: - PRESCRIPTION VIEW
    lazy var prescriptionsView = PrescriptionsView()
    func setPrescriptionsView(){
        prescriptionsView = PrescriptionsView(midFrame)
        dietSceneState.state = PRESCRIPTION
        prescriptionsView.selectedRow(dietSceneState.selectedPrescriptionRow)
        prescriptionsView.delegate(self)
        prescriptionsView.initView()
        addSubview(prescriptionsView)
    }
    
    func selectPrescriptionsRow(color: UIColor, row: Int) {
        dietSceneState.selectedPrescriptionRow = row
        dietSceneState.prescriptionColor = color
        background(color)
    }
    
    // MARK: - BOTTOM BAR VIEW
    lazy var bottomBarView = BottomBarView()
    func setBottomBarView(){
        bottomBarView = BottomBarView(btmFrame)
        bottomBarView.delegate(self)
        bottomBarView.weekDay(dietSceneState.weekDay)
        bottomBarView.initView()
        addSubview(bottomBarView)
    }
    
    @objc func onQuestion() {
        if !onOut && !inFamily{
            onOut(true)
            closeView()
            setQuestionView()
        }
    }
    
    func setQuestionView() {
        delegateDietScene?.setQuestionView()
    }
    
    func onPrescription() {
        if !onOut && !inFamily {
            dietView.closeView()
            supplementsView.closeView()
            if !prescriptionsView.selected{
                setPrescriptionsView()
                topBarView.showPrescriptions()
                background(dietSceneState.prescriptionColor)
            }
        }
    }
    
    func onDiet() {
        let now = isFA ? Date().persianWeekDay : Date().weekDay
        if !onOut && !inFamily{
            prescriptionsView.closeView()
            supplementsView.closeView()
            if now != dietSceneState.weekDay{ dietView.closeView() }
            if !dietView.selected{
                dietSceneState.weekDay = now
                topBarView.weekDay = TopBarValues().diet
                setDietView()
                topBarView.showDiet()
            }
        }
    }
    
    func onSupplement() {
        if !onOut && !inFamily{
            dietView.closeView()
            prescriptionsView.closeView()
            if !supplementsView.selected{
                setSupplementView()
                topBarView.showSupplement()
                background(dietSceneState.supplementColor)
            }
        }
    }
    
    func setFamilyView() {
        inFamily(false)
        delegateDietScene?.setFamilyView()
    }
    
    func loginFamily(){
        closeView()
    }
    
    var inFamily = false
    func inFamily(_ bool: Bool){inFamily = bool}
    func onFamily() {
        if !onOut && !inFamily{
            inFamily(true)
            setFamilyView()
        }
    }
    
    func lunchNewDiet() {
        closeView()
        setDietTableView()
    }
    
    //MARK: - ANSWER VIEW
    lazy var answerView = AnswerView()
    func setAnswerView(_ answer: String){
        answerView = AnswerView(topFrame)
        answerView.answer(answer)
        answerView.initView()
        answerView.onTap(self, #selector(onQuestion))
        addSubview(answerView)
    }
    
    func hasAnswer(answer: String) {
        bottomBarView.reciveAnswer()
        setAnswerView(answer)
    }
      
    func dontHaveAnswer() {
        bottomBarView.retryCheckAnswer()
    }
    
    func connectionError() {
        dietConnection.connectionError()
    }
    
    func closeView(){
        if enable{
            standard.set(false, forKey: "inDietScene")
            enable = false
            topBarView.closeView()
            bottomBarView.closeView()
            dietView.closeView()
            prescriptionsView.closeView()
            supplementsView.closeView()
            var _ = Timer.schedule(2) { _ in self.remove() }
        }
    }
}

//MARK: - Diet Scene State
class DietSceneState{
    var weekDay = String()
    var selectedPrescriptionRow: Int{
        get{ standard.integer(forKey: "selectedPrescriptionRowS") }
        set{ standard.set(newValue, forKey: "selectedPrescriptionRowS") }
    }
    var prescriptionColor = UIColor()
    var selectedDiet = Int()
    var dietColor = UIColor()
    var selectedSupplementRow: Int{
        get{ standard.integer(forKey: "selectedSupplementRowS") }
        set{ standard.set(newValue, forKey: "selectedSupplementRowS") }
    }
    var supplementColor = UIColor()
    var state: String{
        get{ standard.string(forKey: "stateS") ?? DIET }
        set{ standard.set(newValue, forKey: "stateS") }
    }
    
    func reset(){
         weekDay = isEN ? Date().weekDay : Date().persianWeekDay
         selectedPrescriptionRow = 0
         prescriptionColor = specialRecommendationColor
         selectedDiet = 0
         dietColor = breakfastColor
         selectedSupplementRow = 0
         supplementColor = purple01
         state = DIET
    }

    func reRoud(){
        weekDay = isEN ? Date().weekDay : Date().persianWeekDay
        profile.loadSupplement()
    }
}
