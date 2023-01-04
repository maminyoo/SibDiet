//
//  Settings.swift
//  Sibdiet
//
//  Created by Amin on 9/23/18.
//  Copyright © 2018 maminyoo. All rights reserved.
//

import CoreTelephony
import UIKit

class Setting {
    
    var os = UIDevice.current.systemVersion
    
    var regionCode: String{
        guard let regionCode = CTTelephonyNetworkInfo()
            .subscriberCellularProvider?
            .isoCountryCode?
            .uppercased else{ return Locale.current.regionCode ?? IR }
        return regionCode
    }
    
    var enableNotification: Bool{
        get { standard.bool(forKey: ENABLE_NOTIFICATION) }
        set { standard.set(newValue, forKey: ENABLE_NOTIFICATION) }
    }
    
    var deviceToken: String{
        get{ standard.string(forKey: TOKEN) ?? NOT_AVALABLE }
        set{ standard.set(newValue, forKey: TOKEN) }
    }
    
    let languages = [EN, FA]
    var language: String{ 
        get{
            guard let lng = standard.string(forKey: LANGUAGE) else {
                let lang = regionCode != IR ? EN : FA
                standard.set(lang, forKey: LANGUAGE)
                return lang
            }
            return lng
        }
        set{ standard.set(newValue, forKey: LANGUAGE) }
    }
}
