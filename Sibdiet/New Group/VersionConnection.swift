//
//  VersionConnection.swift
//  Sibdiet
//
//  Created by Amin on 3/8/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

import Alamofire
import SwiftyJSON

class VersionConnection{
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        return SessionManager(configuration: configuration)
    }()
    
    //MARK: CHECK VERSION
    func checkVersion(){
        let url = "http://foodsms.com/bale/amin_sa/get.php?"
        var components = URLComponents(string: url)!
        components.queryItems = [URLQueryItem(name: R, value: appVersion.verId.string)]
        manager.requestWithoutCache(components.url!).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                appVersion.setVersion(json: json)
            }
        }
    }
}
