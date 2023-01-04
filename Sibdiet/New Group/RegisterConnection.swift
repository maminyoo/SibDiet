//
//  RegisterConnection.swift
//  Sibdiet
//
//  Created by Amin on 3/13/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol RegisterDelegate{
    func loginDuplicate()
    func registered()
    func loginAgain()
    func duplicateMobile()
    func canRegisterNew()
    func inCorrectMobile()
    func sendFileNumebr()
}

class RegisterConnection: RegisterDelegate{
    
    var delegateRegister: RegisterDelegate?
    func delegate(_ delegate: RegisterDelegate){
        self.delegateRegister = delegate
    }
    
    private let sibDietUrl = "https://sibdiet.net/webservice/"
    private let apiKey = "WC7WPCS4JSTSNYF94VD2"
    
    let manager: SessionManager = { 
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return SessionManager(configuration: configuration)
    }()
    
    //MARK: REGISTER USER
    func registerUser(){
        let dictionary = register.registerParams
        let registerURL = "\(sibDietUrl)post/sibdiet3/profile?"
        let updateData = try! JSONEncoder().encode(dictionary)
        let jsonString = String(data: updateData, encoding: .utf8)!
        var components = URLComponents(string: registerURL)!
        components.queryItems = register.isDuplicateMobile ?
            [URLQueryItem(name: API_KEY, value: apiKey),
             URLQueryItem(name: P, value: register.oldFileNumber.enNumber),
             URLQueryItem(name: M, value: register.mobileResult),
             URLQueryItem(name: PROFILE, value: jsonString)] :
            [URLQueryItem(name: API_KEY, value: apiKey),
             URLQueryItem(name: PROFILE, value: jsonString)]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: PLUS, with: PERCENT_2B)
        Alamofire.request(components.url!, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                let json       = JSON(response.result.value!)
                let status     = json[STATUS].stringValue
                let fileNumber = json[PROFILE_NO].stringValue
                let error      = json[ERROR_DESCRIPTION].stringValue
                let mobilError = json[NOTVALID][0].stringValue
                if status == OK{
                    register.fileNumber = fileNumber
                    if register.isDuplicateMobile{
                        register.isDuplicateMobile = false
                        self.loginDuplicate() }
                    else{ self.registered() } }
                else if error == MOBILE_ERROR{
                    register.isDuplicateMobile = true
                    self.duplicateMobile() }
                else if mobilError == MOBILE{ self.inCorrectMobile() }
                else if error == DUPLICATE_ERROR{
                    register.isDuplicateMobile = false
                    self.loginAgain() } }
            else{ dietConnection.connectionError() }
        }
    }
    
    func loginAgain() {
        delegateRegister?.loginAgain()
    }
    
    func loginDuplicate(){
        delegateRegister?.loginDuplicate()
    }
    
    func registered() {
        repoConnection.registerUser()
        forgetConnection.forget(mobile: register.mobile)
        delegateRegister?.registered()
    }
    
    func duplicateMobile() {
        delegateRegister?.duplicateMobile()
    }
    
    func sendFileNumebr() {
        delegateRegister?.sendFileNumebr()
    }
    
    func inCorrectMobile() {
        delegateRegister?.inCorrectMobile()
    }
    
    //MARK: GET OLD FILENUMBER
    func getOldFileNumber(fileNumber: String){
        let profileURL = "\(sibDietUrl)get/sibdiet3/profile?"
        let parameters = [API_KEY: apiKey, P: fileNumber, M: register.mobileResult]
        manager.requestWithoutCache(profileURL, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                let error = json[ERROR_DESCRIPTION].stringValue
                if status == OK{
                    let fileNumber = json[PROFILE][ID].stringValue
                    register.oldFileNumber = fileNumber
                    self.canRegisterNew() }
                if error == FILENO_ERROR{ self.getOldFileNumberError() } }
            else{ dietConnection.connectionError() }
        }
    }
    
    func canRegisterNew(){
        delegateRegister?.canRegisterNew()
    }
    
    func getOldFileNumberError(){
    }
}
