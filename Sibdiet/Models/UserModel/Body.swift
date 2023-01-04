//
//  Body.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/1/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import SwiftyJSON

class Body{
    var stature       = String()
    var weight        = String()
    var birthWeight   = String()
    var birthStature  = String()
    var fatherStature = String()
    var motherStature = String()
    var wrist         = String()
    var abdominal     = String()
    var hip           = String()
    var thigh         = String()
    var chest         = String()
    var shoulders     = String()
    
    func setBody(json: JSON){
        stature       = json[DIET][STATURE].stringValue
        weight        = json[DIET][WEIGHT].stringValue
        wrist         = json[DIET][WRIST].stringValue
        abdominal     = json[DIET][ABDOMINAL].stringValue
        hip           = json[DIET][HIP].stringValue
        thigh         = json[DIET][THIGH].stringValue
        chest         = json[DIET][CHEST].stringValue
        shoulders     = json[DIET][SHOULDERS].stringValue
        birthWeight   = json[DIET][BIRTH_WEIGHT].stringValue
        birthStature  = json[DIET][BIRTH_STATURE].stringValue
        fatherStature = json[DIET][FATHER_STATURE].stringValue
        motherStature = json[DIET][MOTHER_STATURE].stringValue
    }
}

