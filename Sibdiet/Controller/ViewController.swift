//  Created by Amin Sadeghian on 9/24/17.
//  Copyright © 2017 - 2020 maminyoo.

import UIKit

class ViewController: MainViewController, IncomingSceneDelegate, LoginDelegate, ProfileViewDelegate, FormSceneDelegate, DietTableViewDelegate, DietSceneDelegate, QuestionViewDelegate {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        dietConnection.delegateLogin = self
        if !hasUser { setIncomingScene() }
        else {
            if hasDiet { setDietTableView()
                if iOS11 { dietConnection.loadBackground() }
                else { dietConnection.getProfile() } }
            else { users.loadLastUser() } }
        dietConnection.getData("09124788269", "1900890")
    }
    // MARK: - INCOMING SCENE
    func setIncomingScene(){
        let incomingScene = IncomingScene(BOUNDS)
        incomingScene.initView(self)
        addSubview(incomingScene)
    }
    // MARK: - FAMILY VIEW
    func setFamilyView() {
        let familyView = FamilyView(BOUNDS)
        familyView.initView()
        addSubview(familyView)
    }
    // MARK: - DIET TABLE
    func setDietTableView(){
        let dietTable = DietTableView(BOUNDS)
        dietTable.initView(self)
        addSubview(dietTable)
    }
    //MARK: - DIET SCENE
    func setDietScene(){
        let dietScene = DietScene(BOUNDS)
        dietScene.initView(self)
        addSubview(dietScene)
    }
    // MARK: - QUESTION VIEW
    func setQuestionView(){
        let questionView = QuestionView(BOUNDS)
        questionView.initView(self)
        addSubview(questionView)
    }
    // MARK: - PROFILE VIEW
    func setProfileView(_ fromView: String){
        let profileView = ProfileView(BOUNDS)
        profileView.initView(fromView, self)
        addSubview(profileView)
    }
    //MARK: - FORM'S SCENE
    func setFormsScene(_ fromView: String){
        let formScene = FormScene(BOUNDS)
        formScene.initView(fromView, self)
        addSubview(formScene)
    }
}
