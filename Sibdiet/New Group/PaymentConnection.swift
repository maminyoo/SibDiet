//
//  PaymentConnection.swift
//  Sibdiet
//
//  Created by Amin on 3/13/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import SwiftyJSON
import Alamofire

protocol PaymentDelegate{
    func exitPayment()
    func purchased()
    func paymentError()
    func postDiet()
}

class PaymentConnection: PaymentDelegate {
    
    private let sibDietUrl = "https://sibdiet.net/webservice/"
    private let apiKey = "WC7WPCS4JSTSNYF94VD2"
    
    var delegatePayment: PaymentDelegate?
    func delegate(_ delegate: PaymentDelegate){
        self.delegatePayment = delegate
    }
    
    var fn: String { profile.fileNumber }
    var isWaiting: Bool{
        get{ standard.bool(forKey: "isWaiting\(fn)") }
        set{ standard.set(newValue, forKey: "isWaiting\(fn)") }
    }

    private var r: String{ profile.fileNumber +
                           profile.realID +
                           profile.mobile.substring(from: 7) }
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return SessionManager(configuration: configuration)
    }()
    
    let paymentRURL = "https://sibdiet.net/payment?"
    let paymentEURL = "https://sibdiet.net/en/payment?"
    var payUrl: URLRequest{
//        inOtherBlud || !isFA
        let paymentURL  = isReviewer ? paymentEURL : paymentRURL
        let fileNumber  = profile.fileNumber
        let mobile      = profile.mobile
        let stringUrl   = paymentURL+"p="+fileNumber+"&m="+mobile+"&r="+r+"&tmpl=component"
        return (URLRequest(URL(stringUrl)!))
    }
    
    // outOfAppPayURL
    var payUrlString: String{
//        inOtherBlud || !isFA
        let paymentURL  = isReviewer ? paymentEURL : paymentRURL
        let fileNumber  = profile.fileNumber
        let mobile      = profile.mobile
        return paymentURL+"p="+fileNumber+"&m="+mobile+"&r="+r+"&tmpl=component"+"&d=1"
    }
 
    func logJson(){
        let request    = specialInformation.request
        let parameters = updateProfile.profileParams
        let body       = updateBody.bodyParams
        let special    = specialInformation.specialParams
        let payment    = specialInformation.payment
        let diet = [REQUEST : request,
                    PROFILE : parameters,
                    BODY    : body,
                    SPECIAL : special,
                    PAYMENT : payment]
        let json = diet.json
        print("JSON : ===== /n \(json)")
    }
    
    //MARK: PAYMENT RESULT
    var lastCancelKey = Int()
    func paymentResult(){
        let url = "\(sibDietUrl)get/sibdiet3/payment?"
        let parameters = [API_KEY: apiKey, R: r]
        manager.requestWithoutCache(url, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                print(json)
                if status == OK{
                    let payment = json[PAYMENT]
                    var lastKey = Int()
                    var paymentId = Int()
                    for (key, _) in payment{
                        let int = key.int
                        lastKey = int < lastKey ? lastKey : int
                        paymentId = payment[key][_STATUS].stringValue == ONE ? key.int : paymentId
                    }
                    paymentId = paymentId == Int() ? lastKey : paymentId
                    let status = payment["\(paymentId)"][_STATUS].stringValue
                    let trackingCode = payment["\(paymentId)"][_TRANSACTION_ID].stringValue
                    specialInformation.trackingCode = trackingCode
                    print(json, status, trackingCode)
                    switch status{
                    case NEGATIVE_ONE :
                        if lastKey != self.lastCancelKey{
                            self.lastCancelKey = lastKey
                            self.exitPayment()
                        }
                    case ONE  : self.purchased()
                    default   : break }
                }
            }
            else{ dietConnection.connectionError() }
        }
    }
    
    func exitPayment(){
        delegatePayment?.exitPayment()
    }
    
    func purchased() {
        delegatePayment?.purchased()
        getDiet()
    }
    
    //MARK: POST DATA
    func getDiet(){
        let getDietURL = "\(sibDietUrl)post/sibdiet3/diet?"
        let request    = specialInformation.request
        let parameters = updateProfile.profileParams
        let body       = updateBody.bodyParams
        let special    = specialInformation.specialParams
        let payment    = specialInformation.payment
        let diet = [REQUEST : request,
                    PROFILE : parameters,
                    BODY    : body,
                    SPECIAL : special,
                    PAYMENT : payment].json
        var components = URLComponents(string: getDietURL)!
        components.queryItems = [URLQueryItem(name: API_KEY, value: apiKey),
                                 URLQueryItem(name: P, value: profile.fileNumber.enNumber),
                                 URLQueryItem(name: M, value: profile.mobile.enNumber),
                                 URLQueryItem(name: DIET, value: diet)]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: PLUS, with: PERCENT_2B)
        Alamofire.request(components.url!, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json[STATUS].stringValue
                let dietId = json["dietId"].stringValue
                if status == OK && dietId != "" { self.postDiet() }
                else{
                    self.paymentError()
//                    let errorMessage = self.jsonToString(response.result.value as AnyObject)
                }
            }
            else{ dietConnection.connectionError() }
        }
    }
    
    func jsonToString(_ json: AnyObject) -> String{
        var result = String()
        do {
            let data =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            result = String(data: data, encoding: .utf8) ?? "default value"
        }
        catch _ { result = "nashod" }
        return result
    }
    
    func paymentError(){
        delegatePayment?.paymentError()
    }
    
    func postDiet(){
        isWaiting = true
        repoConnection.payment()
        delegatePayment?.postDiet()
    }
}
