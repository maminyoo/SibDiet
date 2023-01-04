//
//  AppVersion.swift
//  Sibdiet
//
//  Created by Amin on 3/13/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import SwiftyJSON

protocol AppVersionDelegate {
    func updateApplication()
}

class AppVersion: AppVersionDelegate{
    
    var delegateAppVersion: AppVersionDelegate?
    func delegate(_ delegate: AppVersionDelegate){
        delegateAppVersion = delegate
    }
    
    var outOfAppPayement = false
    
    var ver = "0.9.49"
    var verId = 949
    
    var store = "Development"  
//    var store = "AppStore"

//    var store = "SibApp"
//    var store = "Anardoni"
//    var store = "iApps"
//    var store = "SibIrani"
//    var store = "iTips"

    var newVersion = String()
    var versionDescription = String()
    var needed = String()
    var updateURL = String()
    
    func setVersion(json: JSON){
        let count = json.count
        if count>0 {
            let ver = json[count-1][VER_ID].intValue
            if ver > verId {
                newVersion = json[count-1][VER].stringValue
                versionDescription = json[count-1][DES].stringValue
                needed = json[count-1][NEEDED].stringValue
                let links = json[count-1][JSN]
                let hasLinks = links.count>0
                if hasLinks{
                    for (key, url): (String, JSON) in links{
                        if key == store{
                            updateURL = url.stringValue
                            self.updateApplication()
                        }
                    }
                }
            }
        }
    }
    
    func updateApplication() {
        let inDietScene = standard.bool(forKey: "inDietScene")
        if !inDietScene{ delegateAppVersion?.updateApplication() }
    }
}
