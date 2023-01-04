//
//  Bool.swift
//  Sibdiet
//
//  Created by Me on 9/28/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//
import UIKit

var standard = UserDefaults.standard

var hasUser         : Bool{ users.hasUser }
var hasFamily       : Bool{ users.hasFamily }
var hasDiet         : Bool{ profile.dietCount > 0 && profile.diet.bmi != String() }
var hasQuestion     : Bool{ questionAnswer.curentIds.count != 0 }
var newDiet         : Bool{ dietConnection.newDiet }
var inOtherBlud     : Bool{ settings.regionCode != IR }
var isMan           : Bool{ profile.isMan }
var isWaiting       : Bool{ paymentConnection.isWaiting }
var isFA            : Bool{ language == FA }
var isEN            : Bool{ language == EN }
var isBaby          : Bool{ profile.isBaby }
var isRTL           : Bool{ direction == RTL }
var iOS11           : Bool{ if #available(iOS 11.0, *) { return true }else{ return false } }
var iOS12           : Bool{ if #available(iOS 12.0, *) { return true }else{ return false } }
var iOS13           : Bool{ if #available(iOS 13.0, *) { return true }else{ return false } }
var iOS14           : Bool{ if #available(iOS 14.0, *) { return true }else{ return false } }
var isReviewer      : Bool{ profile.mobile == "0018003104455" || profile.mobile == "0061123145678" ||
    extraConnection.y != "N" && inUnvar}
var inUnvar         : Bool{ inOtherBlud || !isFA }
