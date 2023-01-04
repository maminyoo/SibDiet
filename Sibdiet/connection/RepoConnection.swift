//
//  RepoConnection.swift
//  Sibdiet
//
//  Created by Apple on 12/6/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

class RepoConnection{
    
    private let url = "https://app.sibdiet.net/api/"

    var isRegister: Bool{
        get{ return standard.bool(forKey: "reger") }
        set{ standard.set(newValue, forKey: "reger") }
    }
    
    func registerDevice(){
        if !isRegister{
            let parameters = ["deviceID" : deviceId,
                              "store"   : appVersion.store,
                              "ver"     : appVersion.ver,
                              "os"      : settings.os]
            Alamofire.request("\(url)device", method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: nil).responseJSON { response in
                                if response.result.isSuccess { self.isRegister = true } }
        }
    }
    
    func registerUser(){
        post(url: "\(url)register", ["store"      : appVersion.store,
                                     "name"       : register.fullName,
                                     "mobile"     : register.mobileResult,
                                     "fileNumber" : register.fileNumber,
                                     "token"      : settings.deviceToken,
                                     "deviceID"   : deviceId])
    }
    
    func login(){
        post(url: "\(url)login", [ "name"       : profile.fullName,
                                   "mobile"     : profile.mobile,
                                   "fileNumber" : profile.fileNumber,
                                   "store"      : appVersion.store,
                                   "country"    : profile.country,
                                   "birthday"   : profile.birthday.toString,
                                   "dietDate"   : profile.diet.date.date.toString,
                                   "period"     : profile.diet.period,
                                   "dietCount"  : profile.dietCount,
                                   "token"      : settings.deviceToken,
                                   "language"   : settings.language,
                                   "deviceID"   : deviceId])
    }
    
    func payment(){
        post(url: "\(url)payment", ["store"        : appVersion.store,
                                    "name"         : profile.fullName,
                                    "mobile"       : profile.mobile,
                                    "fileNumber"   : profile.fileNumber,
                                    "main"         : isReviewer ? "15" : "45",
                                    "curency"      : isReviewer ? "E" : "T",
                                    "trackingCode" : specialInformation.trackingCode,
                                    "token"        : settings.deviceToken,
                                    "deviceID"     : deviceId])
    }
    
    func post(url: String, _ parameters: [String: Any]){
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: nil)
    }
}

