//
//  QuestionAnswer.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/7/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import SwiftyJSON
import UIKit

protocol QuestionAnswerListDelegate {
    func sendQuestion()
    func notReciveAnswer()
}

protocol ReciveAnswerDelegate{
    func reciveAnswer(questionAnswer: QuestionAnswer)
}

protocol AnswerDelegate{
    func hasAnswer(answer: String)
    func dontHaveAnswer()
}

class QuestionAnswer {
    var firstRead                = false
    var isWaitingToAnswer        = false
    var id                       = String()
    var question                 = String()
    var questionDirection        = String()
    var questionTextHeight       = CGFloat()
    var questionTime             = String()
    var hasNewDate               = Bool()
    var questionDateHeight       = CGFloat()
    var questionDate             = Date()
    var answer                   = String()
    var answerDirection          = String()
    var answerTextHeight         = CGFloat()
    var answerTime               = String()
    var questionAnswerCellHeight = CGFloat()
}

class QuestionAnswerList: QuestionAnswerListDelegate, AnswerDelegate, ReciveAnswerDelegate{
    
    var delegateQuestionAnswerList: QuestionAnswerListDelegate?
    func delegateQuestion(_ delegate: QuestionAnswerListDelegate){
        self.delegateQuestionAnswerList = delegate
    }
    
    var delegateAnswer: AnswerDelegate?
    func delegateAnswer(_ delegate: AnswerDelegate){
        self.delegateAnswer = delegate
    }
    
    var reciveAnswerDelegate: ReciveAnswerDelegate?
    func reciveAnswerDelegate(_ delegate: ReciveAnswerDelegate){
        self.reciveAnswerDelegate = delegate
    }
    
    let now = Date()
    var message: String{
        get{ standard.string(forKey: "Qmessage") ?? String() }
        set{ standard.set(newValue, forKey: "Qmessage") }
    }
    var firstPageURL = String()
    var lastPageURL = String()
    var nextPageURL = String()
    var total = Int()
    
    var questionAnswers = [QuestionAnswer]()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.frame(0, 0, WIDTH-75, 39)
        text.font(UIFont(Sahel, 19)!)
        return text
    }()
    
    var dateHeight: CGFloat = 50
    let space: CGFloat = 12
    
    //MARK: USERS
    var defaults = UserDefaults.standard
    var users = [[String: Any]]()
    var defaultUsers: [[String: Any]]{
        if let users = defaults.array(forKey: USERS) as? [[String: Any]]{ return users }
        return users
    }
    
    //MARK: ID'S
    var ids: [String]{
        var result = [String]()
        for u in defaultUsers{
            let idds = u[IDS] as! [String]
            for id in idds{ result.append(id) }
        }
        return result
    }
    
    //MARK: CURENT ID'S
    var curentIds: [String]{
        var result = [String]()
        for u in defaultUsers{
            let fileNumber = u[FILE_NUMBER] as! String
            if fileNumber == profile.fileNumber{
                let idds = u[IDS] as! [String]
                for id in idds{ result.append(id) }
            }
        }
        return result
    }
    
    //MARK: URL'S
    var urls: [String]{
        var result = [String]()
        for u in defaultUsers{
            let url = u[U_R_L] as! String
            result.append(url)
        }
        return result
    }
    
    //MARK: CURENT USER
    var curentUser:[String: Any]{
        var user = [String: Any]()
        for u in users{
            let fileNumber = u[FILE_NUMBER] as! String
            if fileNumber == profile.fileNumber{ user = u }
        }
        return user
    }
    
    var hasQuestion: Bool{ ids.count > 0 }
        
    //MARK: SET Q&A LIST
    func setQuestionAnswerList(json: JSON){
        total = json[DATA][TOTAL].intValue
        questionAnswers = [QuestionAnswer]()
        firstPageURL = json[DATA][FIRST_PAGE_URL].stringValue
        lastPageURL  = json[DATA][LAST_PAGE_URL].stringValue
        nextPageURL  = json[DATA][NEXT_PAGE_URL].stringValue
        setQuestionAnswers(json: json)
        fixDateCellHeight()
    }
    
    func setNextQuestionAnswerList(json: JSON){
        setQuestionAnswers(json: json)
        fixDateCellHeight()
    }
    
    //MARK: SET Q&A
    var canSave = true
    func setQuestionAnswers(json: JSON){
        let list = json[DATA][DATA]
        users = defaultUsers
        
        for (_, questionAnswer): (String, JSON) in list{
            let qa = QuestionAnswer()
            qa.id = questionAnswer[ID].stringValue
            qa.question = questionAnswer[QUESTION].stringValue
            qa.questionDirection = qa.question.isPersianString ? RTL : LTR
            textView.text = qa.question
            qa.questionTextHeight = textView.paragraphHeight
            qa.questionTime = questionAnswer[QUESTION_CREATED_AT].stringValue.substring(from: 11,to: 15)
            let questionDate = questionAnswer[QUESTION_CREATED_AT].stringValue.substring(from: 0, to: 9).date
            qa.questionDate = questionDate
            qa.answer = questionAnswer[ANSWER].stringValue
            qa.answerDirection = qa.answer.isPersianString ? RTL : LTR
            
            for id in curentIds{
                if id == qa.id && qa.answer != ""{
                    qa.firstRead = true
                    var i = -1
                    for u in users{
                        i += 1
                        var arr = u[IDS] as! [String]
                        var j = -1
                        for ar in arr{
                            j += 1
                            if ar == id{
                                arr.remove(at: j)
                                users[i][IDS] = arr
                            }
                        }
                        if arr.isEmpty{
                            users.remove(at: i)
                        }
                    }
                }else if id == qa.id && qa.answer == ""{
                    qa.answer = qa.questionDirection == RTL ? DAR_ENTEZAR : PLEASE_WAIT
                    qa.isWaitingToAnswer = true
                }
            }
            
            defaults.set(users, forKey: USERS)
            
            textView.text = qa.answer
            qa.answerTextHeight = textView.paragraphHeight
            qa.answerTime = questionAnswer[ANSWER_CREATED_AT].stringValue.substring(from: 11,to: 15)
            
            qa.hasNewDate = false
            qa.questionDateHeight = 0
            qa.questionAnswerCellHeight = qa.questionTextHeight + qa.answerTextHeight + space + qa.questionDateHeight
            questionAnswers.insert(qa, at: 0)
        }
    }
    
    //MARK: DATE HEIGHT
    func fixDateCellHeight(){
        var j = -1
        while j < questionAnswers.count-1 {
            j += 1
            if j == 0 || questionAnswers[j].questionDate != questionAnswers[j-1].questionDate{
                questionAnswers[j].hasNewDate = true
                questionAnswers[j].questionDateHeight = dateHeight
                questionAnswers[j].questionAnswerCellHeight = questionAnswers[j].questionTextHeight + questionAnswers[j].answerTextHeight + space + questionAnswers[j].questionDateHeight
            }
        }
    }
    
    //MARK: SEND QUESTION
    func sendNewQuestion(json: JSON){
        users = defaultUsers
        let qa = QuestionAnswer()
        qa.id = json[DATA][ID].stringValue
        let unit: [String: Any] = [MOBILE      : profile.mobile,
                                   FILE_NUMBER : profile.fileNumber,
                                   U_R_L       : firstPageURL,
                                   IDS         : [qa.id]]
        if users.isEmpty{
            users.append(unit)
        }else{
            var haveAnotherUserQuestion = true
            var index = -1
            for user in users{
                index += 1
                let fileNumber: String = user[FILE_NUMBER] as! String
                if fileNumber == profile.fileNumber{
                    haveAnotherUserQuestion = false
                    var arr = user[IDS] as! [String]
                    arr.append(qa.id)
                    users[index][IDS] = arr
                }
            }
            if haveAnotherUserQuestion{
                users.append(unit)
            }
        }
        
        defaults.set(users, forKey: USERS)
        
        qa.question = json[DATA][QUESTION].stringValue
        qa.questionDirection = qa.question.isPersianString ? RTL : LTR
        
        textView.text = qa.question
        qa.questionTextHeight = textView.paragraphHeight
        qa.questionTime = json[DATA][QUESTION_CREATED_AT].stringValue.substring(from: 11,to: 15)
        qa.questionDate = json[DATA][QUESTION_CREATED_AT].stringValue.substring(from: 0, to: 9).date
        qa.answer = qa.questionDirection == RTL ? DAR_ENTEZAR : PLEASE_WAIT
        textView.text = qa.answer
        qa.answerTextHeight = textView.paragraphHeight
        qa.isWaitingToAnswer = true
        let count = questionAnswers.count
        qa.questionAnswerCellHeight = qa.questionTextHeight + qa.answerTextHeight + space
        if count>0{
            if qa.questionDate != questionAnswers[count-1].questionDate{
                qa.hasNewDate = true
                qa.questionDateHeight = dateHeight
                qa.questionAnswerCellHeight += dateHeight
            }
        }else{
            qa.hasNewDate = true
            qa.questionDateHeight = dateHeight
            qa.questionAnswerCellHeight += dateHeight
        }
        questionAnswers.append(qa)
        sendQuestion()
    }
    
    func sendQuestion() {
        delegateQuestionAnswerList?.sendQuestion()
    }
    
    //MARK: SET ANSWER
    func setAnswer(json: JSON){
        let list = json[DATA][DATA]
        for (_, questionAnswer): (String, JSON) in list{
            let qaID = questionAnswer[ID].stringValue
            let answer = questionAnswer[ANSWER].stringValue
            var donHaveAnswer = true
            for id in curentIds{
                if id == qaID && answer != ""{
                    var i = -1
                    for qa in questionAnswers{
                        i += 1
                        if id == qa.id{
                            donHaveAnswer = false
                            questionAnswers[i].answer = answer
                            textView.text = answer
                            questionAnswers[i].answerDirection = answer.isPersianString ? RTL : LTR
                            let height = textView.paragraphHeight
                            questionAnswers[i].questionAnswerCellHeight = questionAnswers[i].questionAnswerCellHeight - questionAnswers[i].answerTextHeight + height
                            questionAnswers[i].answerTextHeight = height
                            questionAnswers[i].firstRead = true
                            questionAnswers[i].isWaitingToAnswer = false
                            questionAnswers[i].answerTime = questionAnswer[ANSWER_CREATED_AT].stringValue.substring(from: 11,to: 15)
                            remove(id: id)
                            reciveAnswer(questionAnswer: questionAnswers[i])
                        }
                    }
                }
            }
            if donHaveAnswer{
                notReciveAnswer()
            }
        }
    }
    
    //MARK: REMOVE ID
    func remove(id : String){
        var i = -1
        for user in users{
            i += 1
            let fileNumber = user[FILE_NUMBER] as! String
            if fileNumber == profile.fileNumber{
                var ids = user[IDS] as! [String]
                var j = -1
                for iidd in ids{
                    j += 1
                    if id == iidd{
                        ids.remove(at: j)
                        if ids.isEmpty{ users.remove(at: i) }
                        else{ users[i][IDS] = ids }
                    }
                }
            }
        }
        defaults.set(users, forKey: USERS)
    }
    
    //MARK: RECIVE ANSWER
    func reciveAnswer(questionAnswer : QuestionAnswer){
        reciveAnswerDelegate?.reciveAnswer(questionAnswer: questionAnswer)
    }
    
    //MARK: NOT RECIVE
    func notReciveAnswer(){
        delegateQuestionAnswerList?.notReciveAnswer()
    }
    
    //MARK: CHECK ANSWER
    func checkAnswer(json: JSON){
        var dontHave = true
        let list = json[DATA][DATA]
        for (_, questionAnswer): (String, JSON) in list{
            let qaID = questionAnswer[ID].stringValue
            let answer = questionAnswer[ANSWER].stringValue
            for id in curentIds{
                if id == qaID && answer != ""{
                    hasAnswer(answer: answer)
                    dontHave = false
                }
            }
        }
        if dontHave{
            dontHaveAnswer()
        }
    }
    
    func hasAnswer(answer: String){
        delegateAnswer?.hasAnswer(answer: answer)
    }
    
    func dontHaveAnswer(){
        delegateAnswer?.dontHaveAnswer()
    }
    
    //MARK: RESET
    func reset(){
        message = String()
        firstPageURL = String()
        lastPageURL = String()
        nextPageURL = String()
        total = Int()
        questionAnswers = [QuestionAnswer]()
    }
}

