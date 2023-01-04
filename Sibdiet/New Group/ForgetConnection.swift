//
//  ForgetConnection.swift
//  Sibdiet
//
//  Created by Amin on 3/8/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol ForgetDelegate {
    func notFountPhone()
    func notFound()
    func found()
}

class ForgetConnection: ForgetDelegate{
    
    var delegateForget  : ForgetDelegate?
    private let sibDietUrl = "https://sibdiet.net/webservice/"
    private let apiKey = "WC7WPCS4JSTSNYF94VD2"
    
    //MARK: FORGET FILENUMBER
    func forget(mobile: String){
        getForget([API_KEY : apiKey, M : mobile])
    }
    
    func  getForget(_ parameters: [String : String]){
        let forgetURL = "\(sibDietUrl)get/sibdiet3/profile?"
        Alamofire.request(forgetURL, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                if status == KO{ self.notFountPhone() }
                else{ self.found() } }
            else{ dietConnection.connectionError() }
        }
    }
    
    func notFountPhone() {
        delegateForget?.notFountPhone()
    }
    
    func notFound() {
        delegateForget?.notFound()
    }
    
    func found() {
        delegateForget?.found()
        registerConnection.sendFileNumebr()
    }
}
