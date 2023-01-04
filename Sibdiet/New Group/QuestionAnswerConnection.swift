//
//  QuestionAnswerData.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/7/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

class QuestionAnswerConnection {
    
    private let url = "http://foodsms.com/index.php/api/v2/"

    //MARK: REGISTER DEVICE
    func registerDevice(){
        let parameter = [DEVICE_ID : deviceId,
                         "store"   : appVersion.store,
                         "ver"     : appVersion.ver,
                         "os"      : settings.os]
        Alamofire.request("\(url)ios/register/",
                          method:.post,
                          parameters: parameter).responseJSON{
            response in
            if response.result.isSuccess{
                self.updateUser()
            }else{
                print("registerDevice ERROR")
            }
        }
    }
    
    //MARK: UPDATE USER
    func updateUser(){
        let endPoint = users.hasFamily ? "multiaccount" : "detail"
        let parameters = [DEVICE_ID: deviceId,
                          SITE_ID: profile.fileNumber,
                          MOBILE: profile.mobile.enNumber,
                          NAME: profile.fullName]
        Alamofire.request("\(url)ios/\(endPoint)/",
                          method:.post,
                          parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
                self.getQuestions()
                if settings.enableNotification{
                    self.registerToken()
                }
            }else{
                print("updateUser ERROR")
            }
        }
    }
    
    //MARK: REGISTER TOKEN
    func registerToken(){
        let parameter = ["token": settings.deviceToken]
        Alamofire.request("\(url)usage/set/\(deviceId)",
                          method:.post,
                          parameters: parameter).responseJSON{
            response in
            if response.result.isSuccess{
            }else{
                print("registerToken ERROR")
            }
        }
    }
    
    //MARK: GET QUESTIONS
    func getQuestions(){
        Alamofire.request("\(url)question/all/\(profile.fileNumber)/\(deviceId)",
                          method: .get).responseJSON{
            response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                questionAnswer.setQuestionAnswerList(json: json)
            }else{
                print("getQuestions ERROR")
            }
        }
    }
    
    //MARK: GET ANSWER
    func getAnswer(){
        Alamofire.request("\(url)question/all/\(profile.fileNumber)/\(deviceId)",
                          method: .get).responseJSON{
            response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                questionAnswer.setAnswer(json: json)
            }else{
                print("getAnswer ERROR")
            }
        }
    }
    
    //MARK: CHECK ANSWER
    func checkAnswer(){
        Alamofire.request("\(url)question/all/\(profile.fileNumber)/\(deviceId)",
                          method: .get).responseJSON{
            response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                questionAnswer.checkAnswer(json: json)
            }else{
                print("checkAnswer ERROR")
            }
        }
    }
    

    //MARK: ASK QUESTION
    func askQuestion(){
        let parameter = [TEXT: questionAnswer.message]
        Alamofire.request("\(url)question/ask/\(profile.fileNumber)/\(deviceId)/",
                          method:.post, parameters: parameter).responseJSON{
            response in
            if response.result.isSuccess{
                let json: JSON = JSON(response.result.value!)
                questionAnswer.sendNewQuestion(json: json)
            }else{
                print(response.result)
                dietConnection.connectionError()
            }
        }
    }
    
    
    //MARK: CANCEL REQUEST
    func cancelRequest(){
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
//    func checkAnswerInBackground(){
//        let url = questionAnswer.urls[0]
//        Alamofire.request(url, method: .get).responseJSON{
//            response in
//            if response.result.isSuccess {
//                let json = JSON(response.result.value!)
////                data.questionAnswer.checkAnswerInBackground(json: json)
//                print(json)
//            }else{
//                print("checkAnswerInBackground ERROR")
//            }
//        }
//    }
    
//    func getNextQuestions(url: String){
//        Alamofire.request(url, method: .get).responseJSON{
//            response in
//            if response.result.isSuccess {
//                let json = JSON(response.result.value!)
//                questionAnswer.setNextQuestionAnswerList(json: json)
//            }else{
//                print("getAnswer ERROR")
//                dietConnection.connectionError()
//            }
//        }
//    }
    

//    func getList(){
//        let url = "\(self.url)post/all/\(profile.fileNumber)/\(deviceId)"
//        Alamofire.request(url, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess{
//                let json = JSON(response.result.value!)
//                let nextURL = json[DATA][NEXT_PAGE_URL].stringValue
//                self.nextPage(url: nextURL)
//            }else{
//                print(response.result)
//                dietConnection.connectionError()
//            }
//        }
//    }
    
//    func nextPage(url: String){
//        Alamofire.request(url, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess{
////                let json = JSON(response.result.value!)
////                print(json)
//            }else{
//                print(response.result)
//                dietConnection.connectionError()
//            }
//        }
//    }
