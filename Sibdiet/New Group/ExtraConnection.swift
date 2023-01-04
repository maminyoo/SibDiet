//
//  ExtraConnection.swift
//  Sibdiet
//
//  Created by Me on 8/24/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ExtraConnection{
    var p = String()
    var t = String()
    var e = "0"
    var x = String()
    var y = "N"
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return SessionManager(configuration: configuration)
    }()

    func getExtra(){
        let url = "http://foodsms.com/bale/amin_sa/extra.php"
        manager.requestWithoutCache(url).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                self.set(json)
            }
        }
    }
    
    func set(_ json: JSON){
        p = json[P].stringValue
        t = json[T].stringValue
        e = json[E].stringValue
        x = json[X].stringValue
        y = json[Y].stringValue
    }
}
