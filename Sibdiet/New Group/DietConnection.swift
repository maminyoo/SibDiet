//
//  DietConnection.swift
//  Sibdiet
//
//  Created by Amin on 3/11/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol LoginDelegate{
    func background(_ color: UIColor)
    func setProfileView(_ fromView: String)
    func setDietTableView()
    func setIncomingScene()
}

protocol SrverStateDelegate{
    func setLoading(_ frame: CGRect)
    func retry()
    func connectionError()
    func serverError()
}

protocol LunchDietDelegate {
    func lunchNewDiet()
}

protocol LoadingDelegate {
    func blurBack()
    func closeLoading()
}

protocol LoadProfileDelegate {
    func loadProfile()
}

protocol CloseRetryDelegate {
    func closeRetry()
}

protocol InLoadingDelegate {
    func inLoading(_ bool: Bool)
}

protocol LoginCloseDelegate {
    func loginClose()
}

protocol DietTableClose {
    func closeTable()
}

protocol LoginFamilyDelegate{
    func loginFamily()
}


class DietConnection: LoginDelegate, LoadingDelegate, LoadProfileDelegate, CloseRetryDelegate, LunchDietDelegate, InLoadingDelegate, LoginCloseDelegate, ApplicationDelegate , DietTableClose, SrverStateDelegate, LoginFamilyDelegate{
 
    private let sibDietUrl = "https://sibdiet.net/webservice/"
    private let apiKey = "WC7WPCS4JSTSNYF94VD2"
    
    var mobile: String{
        get{ standard.string(forKey: MOBILE) ?? String() }
        set{ standard.set(newValue, forKey: MOBILE) }
    }

    var fileNumber: String{
        get{ standard.string(forKey: FILE_NUMBER) ?? String() }
        set{ standard.set(newValue, forKey: FILE_NUMBER) }
    }
    
    var delegateLogin       : LoginDelegate?
    var delegateLoading     : LoadingDelegate?
    var delegateLoadProfile : LoadProfileDelegate?
    var delegateCloseRetry  : CloseRetryDelegate?
    var delegateLunchDiet   : LunchDietDelegate?
    var delegateInLoading   : InLoadingDelegate?
    var delegateLoginClose  : LoginCloseDelegate?
    var delegateTableClose  : DietTableClose?
    var delegateServerState : SrverStateDelegate?
    var delegateLoginFamily : LoginFamilyDelegate?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getProfile(){
        getData(profile.mobile, profile.fileNumber)
    }
    
    func loginFamily(){
        delegateLoginFamily?.loginFamily()
    }
    
    //MARK: GET DIET DATA
    @objc func getData(_ mobile: String, _ fileNumber: String){
        inBackground = false
        cancelRequest()
        self.mobile = mobile
        self.fileNumber = fileNumber
        restLastData()
        getProfile([API_KEY : apiKey, P: fileNumber, M: mobile])
        setLoading()
        loadingTimer = Timer.schedule(43) { _ in self.longLoading() }
        background(gray01)
    }
    
    func restLastData(){
        profile.diet.clear()
        register.reset()
        specialInformation.reset()
        questionAnswer.reset()
        updateBody.reset()
    }
    
    var loadingTimer = Timer()
    @objc func longLoading(){
        users.remove(fileNumber)
        forgetConnection.forget(mobile: mobile)
        closeLoading()
    }
    
    func setIncomingScene(){
        delegateLogin?.setIncomingScene()
    }
    
    func setLoading(_ frame: CGRect = BOUNDS) {
        closeLoading()
        if isConnected{
            inLoading(true)
            delegateServerState?.setLoading(frame)
        }
    }
    
    func background(_ color: UIColor){
        delegateLogin?.background(color)
    }
  
    func tryAgain(){
        loadingTimer.invalidate()
        getData(mobile, fileNumber)
    }
    
    //MARK: GET PROFILE DATA
    private func getProfile(_ parameters: [String: String]){
        let profileURL = "\(sibDietUrl)get/sibdiet3/profile?"
        manager.requestWithoutCache(profileURL, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                let fileNumber = json[PROFILE][ID].stringValue
                let appleId = json[PROFILE][APPLE_ID].stringValue
                if status == KO{ forgetConnection.notFound() }
                else{
                    profile.setProfile(json: json)
                    self.getDietsInfo()
                    if  appleId != deviceId { self.update() }
                    self.registerDeviceToken()
                    if users.needSave(fileNumber){ users.saveUser(json: json) }
                    self.loadProfile() } }
            else{ self.retry() }
        }
    }
    
    //MARK: REGISTER TOKEN
    private func registerDeviceToken(){
        let URL = "\(sibDietUrl)put/push/register?"
        let parameters = [APPCODE: SIBDIET_APPLE,
                          PLATFORM: IOS,
                          IOS_ALERT: ONE,
                          IOS_BADGE: ONE,
                          IOS_SOUND: ONE,
                          API_KEY: apiKey,
                          PROFILE_ID: profile.fileNumber,
                          TOKEN: settings.deviceToken]
        Alamofire.request(URL, method:.post, parameters: parameters)
    }
    
    func loadProfile() {
        loadingTimer.invalidate()
        delegateLoadProfile?.loadProfile()
        blurBack()
    }
    
    var curentID: String{
        get{ standard.string(forKey: "curentID") ?? String() }
        set{ standard.set(newValue, forKey: "curentID") }
    }
    
    var inBackground = false
    var notBefore = false
    func loadBackground(){
        appDelegate.delegateApp = self
        if !inBackground{
            inBackground = true
            cancelRequest()
            notBefore = hasDiet
            curentID = profile.diet.id
            getDietsInfo()
            setLoading(CGRect(topFrame.width/2 - 40, topFrame.midY, 80, 80))
        }
    }
    
    func didBecomeActive(){
        loadingTimer.invalidate()
        let _ = Timer.schedule(9) { _ in  if self.inBackground{  self.closeLoading() } }
    }
    
    func didEnterBackground(){ }
    
    //MARK: GET DIETS LIST
    func getDietsInfo(){
        questionAnswerConnection.registerDevice()
        let dietsURL = "\(sibDietUrl)get/sibdiet3/diets?"
        let parameters = [API_KEY: apiKey,
                          P: profile.fileNumber,
                          M: profile.mobile]
        manager.requestWithoutCache(dietsURL, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                if status == OK{ self.setDietInfo(json: json) }
            }else{
                if !self.inBackground{ self.retry() }
            }
        }
    }
    
    //MARK: SET DIETS
    var newDiet = false
    var chartJson = JSON()
    private func setDietInfo(json: JSON){
        chartJson = json
        newDiet = false
        var dietCount = json[DIETS].count
        profile.dietCount = dietCount
        let period = json[DIETS][dietCount-1][PERIOD].stringValue
        paymentConnection.isWaiting = period == "" && dietCount>0
        profile.published = dietCount == 1 ? json[DIETS][0][PUBLISHED].stringValue : THREE
        newDiet = dietCount == 1 && isWaiting
        if dietCount > 0 && profile.published != ZERO && !newDiet{
            var id = json[DIETS][dietCount-1][ID].stringValue
            profile.realID = id
            if isWaiting{
                dietCount -= 1
                id = json[DIETS][dietCount-1][ID].stringValue
            }
            profile.id = id
            self.getDietData()
        }else { setProfileView(LOGIN_VIEW) }
    }
    
    //MARK: LOGIN NEW USER
    func setProfileView(_ fromView: String){
        inBackground = false
        resetDiet()
        closeLoading()
        closeRetry()
        loginClose()
        delegateLogin?.setProfileView(fromView)
    }
    
    //MARK: GET LAST DIET DATA
    func getDietData(){
        let parameters = [API_KEY: apiKey, P: fileNumber, M: mobile, D: profile.id]
        let dietsURL = "\(sibDietUrl)get/sibdiet3/diet?"
        manager.requestWithoutCache(dietsURL, parameters: parameters).responseData{
            response in
            if response.result.isSuccess{
                let json = JSON(response.result.value!)
                if json[DIET].count > 0{
                    self.resetDiet()
                    profile.diet.setDietsData(json: json)
                    profile.prescriptions.setPrescriptionsData(json: json)
                    profile.setSupplementData(json: json)
                    profile.body.setBody(json: json)
                    profile.diet.setWeightsDates(json: self.chartJson)
                    if self.inBackground{ self.loaded() } else { self.login()  }
                    repoConnection.login()
                }
                else{ self.serverError() } }
            else{
                if !self.inBackground{ self.retry() }
            }
        }
    }
        
    //MARK: SERVER ERROR
    func serverError() {
        loadingTimer.invalidate()
        delegateServerState?.serverError()
        closeLoading()
        closeRetry()
    }
    
    //MARK: RESET DIET
    func resetDiet(){
        profile.diet = Diet()
        profile.prescriptions = Prescriptions()
        profile.supplements = [Supplements]()
        profile.body = Body()
    }
    
   func inLoading(_ bool: Bool){
        delegateInLoading?.inLoading(bool)
    }
    
    //MARK: LOGIN
    var canLogin = true
    func login(){
        loadingTimer.invalidate()
        if canLogin {
            canLogin = false
            cancelRequest()
            closeRetry()
            loginClose()
            closeLoading()
            dietSceneState.reset()
            let inIncomingScene = standard.bool(forKey: "inIncomingScene")
            var _ = Timer.schedule(inIncomingScene ? 1 : 0) { _ in
                self.setDietTableView()
            }
            standard.set(CGFloat(), forKey: "QAListY")
            let _ = Timer.schedule(15) { _ in self.canLogin = true }
        }
    }
    
    func loginClose() {
        delegateLoginClose?.loginClose()
    }

    func setDietTableView() {
        versionConnection.checkVersion()
        delegateLogin?.setDietTableView()
    }
       
    func loaded(){
        inBackground = false
        closeLoading()
        versionConnection.checkVersion()
        if profile.diet.id != curentID || !notBefore { lunchNewDiet() }
    }
    
    func lunchNewDiet(){
        notBefore = true
        curentID = profile.diet.id
        delegateLunchDiet?.lunchNewDiet()
    }
    
    func retry() {
        loadingTimer.invalidate()
        inLoading(false)
        closeLoading()
        closeTable()
        delegateServerState?.retry()
    }
    
    func closeTable(){
        if !iOS11 {
            delegateTableClose?.closeTable()
        }
    }
    
    func blurBack() {
        delegateLoading?.blurBack()
    }
    
    func closeLoading() {
        delegateLoading?.closeLoading()
    }
    
    func closeRetry(){
        delegateCloseRetry?.closeRetry()
    }
    
    //MARK: UPDATE PROFILE
    func update(){
        let updateURL = "\(sibDietUrl)put/sibdiet3/profile?"
        let dictionary = updateProfile.profileParams
        let updateData = try! JSONEncoder().encode(dictionary)
        let jsonString = String(data: updateData, encoding: .utf8)!
        var components = URLComponents(string: updateURL)!
        components.queryItems = [URLQueryItem(name: API_KEY, value: apiKey),
                                 URLQueryItem(name: P, value: profile.fileNumber),
                                 URLQueryItem(name: M, value: profile.mobile),
                                 URLQueryItem(name: PROFILE, value: jsonString)]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: PLUS, with: PERCENT_2B)
        Alamofire.request(components.url!).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                let notupdated = json[NOTUPDATED]
                if status == OK{
                    if notupdated.count == 0{
                        users.remove(profile.fileNumber)
                        users.replaceUser()
                    }
                    profile.saveUpdate()
                } }
            else{ self.connectionError() }
        }
    }
    
    //MARK: CONNECTION ERROR
    var canShowAlart = true
    func connectionError() {
        if canShowAlart{
            canShowAlart = false
            delegateServerState?.connectionError()
            delegateLoading?.closeLoading()
            var _ = Timer.schedule(3.7) { _ in
                self.canShowAlart = true
            }
        }
    }
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return SessionManager(configuration: configuration)
    }()
    
    //MARK: CANCEL REQUEST
    func cancelRequest(){
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
        Alamofire
            .SessionManager
            .default
            .session
            .getTasksWithCompletionHandler {
                dataTasks, uploadTasks, downloadTasks in
                dataTasks.forEach { $0.cancel() }
                uploadTasks.forEach { $0.cancel() }
                downloadTasks.forEach { $0.cancel() }
        }
    }
}
