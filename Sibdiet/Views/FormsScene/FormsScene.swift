//
//  FormsScene.swift
//  Sibdiet
//
//  Created by Amin on 2/29/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol FormSceneDelegate {
    func setDietTableView()
    func background(_ color: UIColor)
    func setProfileView(_ fromView: String)
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval)
    func setDietScene()
}

class FormScene: UIView, BodyViewDelegate, GeneralInfoViewDelegate, SpecialInfoViewDelegate , FormSceneDelegate{
    
    var delegateFormsScene: FormSceneDelegate?
    var fromView = String()
    
    func initView(_ fromView: String, _ delegate: FormSceneDelegate){
        delegateFormsScene = delegate
        self.fromView = fromView
        setBodyView(fromView)
    }
    
    //MARK: - BODY VIEW
    var bodyView = BodyView()
    func setBodyView(_ fromView: String){
        hideStatus(false , 0.7)
        background(gray01)
        bodyView = BodyView(BOUNDS)
        bodyView.delegate(self)
        bodyView.initView(fromView)
        addSubview(bodyView)
    }
    func backBody(toView : String){
        switch toView {
        case LOGIN_VIEW: setProfileView(toView)
        case DIET_VIEW: setDietScene()
        default: setDietTableView()
        }
    }
    //MARK: - GENERAL VIEW
    lazy var generalView = GeneralView()
    func setGeneralView(_ fromView: String){
        hideStatus(true)
        generalView = GeneralView(BOUNDS)
        generalView.delegate(self)
        generalView.initView(fromView)
        addSubview(generalView)
    }
    // MARK: - SPECIAL VIEW
    lazy var specialView = SpecialView()
    func setSpecialView(_ fromView: String){
        hideStatus(false)
        specialView = SpecialView(BOUNDS)
        specialView.delegate(self)
        specialView.initView(fromView)
        addSubview(specialView)
    }
    
    func closeSpecialView() {
        if hasDiet{ setDietTableView() }
        else{ setProfileView(LOGIN_VIEW) }
    }
    
    func background(_ color: UIColor){
        delegateFormsScene?.background(color)
    }
    
    func setProfileView(_ fromView: String){
        delegateFormsScene?.setProfileView(fromView)
    }
    
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval = 0){
        delegateFormsScene?.hideStatus(bool, delay)
    }
    
    func setDietScene(){
        delegateFormsScene?.setDietScene()
    }
    
    func setDietTableView(){
        delegateFormsScene?.setDietTableView()
    }
}
