//
//  IncomingScene.swift
//  Sibdiet
//
//  Created by Amin on 2/29/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import UIKit
import QuartzCore

protocol IncomingSceneDelegate{
    func background(_ color: UIColor)
    func present(_ link : [String])
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval)
    func setDietScene()
    func connectionError()
    func setProfileView(_ fromView: String)
}

class IncomingScene: UIView, IncomingSceneDelegate, FirstViewDelegate, AboutViewDelegate, RegisterViewDelegate, LoginCloseDelegate{
    
    var delegateIncomingScene: IncomingSceneDelegate?
    
    var enable: Bool{ firstView.enable }
    
    func initView(_ delegate: IncomingSceneDelegate){
        standard.set(true, forKey: "inIncomingScene")
        delegateIncomingScene = delegate
        dietConnection.delegateLoginClose = self
        setFirstView()
    }
    
    // MARK: - FIRST VIEW
    lazy var firstView = FirstView()
    func setFirstView(){
        hideStatus(true, 0.1)
        background(gray01)
        firstView = FirstView(BOUNDS)
        firstView.delegate(self)
        firstView.initView()
        addSubview(firstView)
    }
    
    func onAbout() {
        hideStatus(false, 0.35)
        setAboutView()
        closeRetry()
    }
    
    func closeFirstView() {
        hideStatus(false, 0.3)
        closeRetry()
        firstView.closeView()
        if hasDiet && !newDiet{ setDietScene() }
        else{ if isWaiting{ dietConnection.getProfile() }
        else{ setProfileView(LOGIN_VIEW) } }
    }
    
    func onRegister() {
        hideStatus(false, 0.2)
        setRegisterView()
        closeRetry()
    }
    
    func resetLoading() {
        firstView.inLoading(false)
        closeRetry()
    }
  
    func closeRetry(){
        dietConnection.closeRetry()
    }
    
    func connectionError() {
        firstView.inLoading(false)
        delegateIncomingScene?.connectionError()
    }
    
    func setDietScene(){
        delegateIncomingScene?.setDietScene()
    }
    
    func setProfileView(_ fromView: String){
        delegateIncomingScene?.setProfileView(fromView)
    }
    
    func loginClose(){
        closeScene()
    }
    
    // MARK: - ABOUT VIEW
    lazy var aboutView = AboutView()
    func setAboutView(){
        aboutView = AboutView(BOUNDS)
        aboutView.delegate(self)
        aboutView.initView()
        addSubview(aboutView)
    }
    
    func share(){ present(shareLink) }
    func present(_ link : [String]){
        delegateIncomingScene?.present(link)
    }
    // MARK: - REGISTER VIEW
    lazy var registerView = RegisterView()
    func setRegisterView(){
        registerView = RegisterView(BOUNDS)
        registerView.delegate(self)
        registerView.initView()
        addSubview(registerView)
    }
    
    func background(_ color: UIColor){
        delegateIncomingScene?.background(color)
    }
    
    func hideStatus(_ bool: Bool, _ delay: CFTimeInterval){
        delegateIncomingScene?.hideStatus(bool, delay)
    }
    
    func closeScene(){
        firstView.closeView()
        var _ = Timer.schedule(1.5) { _ in self.remove() }
        standard.set(false, forKey: "inIncomingScene")
    }
}
