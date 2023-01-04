//
//  Foods.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/2/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit

class FoodStruct: NSObject, NSCoding{
    var id: Int
    var meal: String
    var title: String
    var supplement: String
    var preparation: String
    var composition: String
    
    init(_ food : Food){
        self.id = food.id
        self.meal = food.meal
        self.title = food.titleCorrection
        self.supplement = food.supplement
        self.preparation = food.preparationCorrection
        self.composition = food.composition
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "IntF") as? Int ?? Int()
        meal = aDecoder.decodeObject(forKey: "mealF") as? String ?? String()
        title = aDecoder.decodeObject(forKey: "titleF") as? String ?? String()
        supplement = aDecoder.decodeObject(forKey: "supplementF") as? String ?? String()
        preparation = aDecoder.decodeObject(forKey: "preparationF") as? String ?? String()
        composition = aDecoder.decodeObject(forKey: "compositionF") as? String ?? String()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "IntF")
        aCoder.encode(meal, forKey: "mealF")
        aCoder.encode(title, forKey: "titleF")
        aCoder.encode(supplement, forKey: "supplementF")
        aCoder.encode(preparation, forKey: "preparationF")
        aCoder.encode(composition, forKey: "compositionF")
    }
}

class Food{
    var id = Int()
    var meal = String()
    var title = String()
    var supplement = String()
    var preparation = String()
    var foodCompositions = [FoodCompositions]()
    var composition = String()

    func reverse(_ food : FoodStruct){
        self.id = food.id
        self.meal = food.meal
        self.title = food.title
        self.supplement = food.supplement
        self.preparation = food.preparation
        self.composition = food.composition
    }
}

extension Food{
    var titleCorrection: String{ title.replace(["ازاد" :"آزاد"
        ,"(ن)" : "" ,"(م)" :""
        ,"چای و بسکویت" : "چای و بیسکوئیت"
        ,"شیر و بسکویت" : "شیر و بیسکوئیت"
        ,"مثل غذای ظهر(ب)" : "مثل غذای ظهر"]) }
    
    var hasBread: Bool{ supplement == BREAD }
    var hasRice: Bool{ supplement == RICE ||
                        supplement == ISTANBUL_RICE ||
                        supplement == BREANS_RICE ||
                        supplement == LENTIL_RICE ||
                        supplement == MACARONI }
    var hasMacaroni: Bool{ supplement == MACARONI }
    var freeCompositions: Bool { composition == "" }
    var hasPreparation: Bool { preparationCorrection != "" }
    var preparationCorrection: String{
        let first = preparation.replacingOccurrences(of: "&nbsp;",
                                                     with: "",
                                                     options: .regularExpression,
                                                     range: nil)
        return first.replacingOccurrences(of: "<[^>]+>",
                                          with: "",
                                          options: .regularExpression,
                                          range: nil)
    }
}

class FoodCompositions{
    var id = String()
    var title = String()
    var printTitle = String()
    var unit = String()
    var uamount = String()
}

extension FoodCompositions{
    var replaceUnit: [String: String]{
        if !title.isPersianString {
            return  ["gr": "grams",
                     "(": " ",
                     ")": " ",
                     ".":"",
                     "ق م" : "jar spoon",
                     "ق چ" : "tea spoon",
                     "(ق غ)" : "spoon",
                     "ق غ" : "spoon"]
        }else{
            return ["gr": " گرم",
                    "(": " ",
                    ")": " ",
                    "1": "۱",
                    "2": "۲",
                    "3": "۳",
                    "4": "۴",
                    "5": "۵",
                    "6": "۶",
                    "  ": " ",
                    "7": "۷",
                    "8": "۸",
                    "9": "۹",
                    "0": "۰",
                    ".":"",
                    "ق م" : " قاشق مربا خوری ",
                    "ق چ" : " قاشق چای خوری ",
                    "(ق غ)" : " قاشق غذا خوری ",
                    "ق غ" : " قاشق غذا خوری "]
        }
    }
    var composition: String{
        let isPersian = title.isPersianString
        var com: String{
            !isPersian ?
            uamount + " " + unit.replace(replaceUnit) + " of " + title :
            title + " " + uamount.faNumber + " " + unit.replace(replaceUnit)
        }
        
        if title != "کم چرب" {
            return com
        }else if uamount == "1"{
            switch language {
            case EN: return "All foods and ingredient should be low-fat"
            default: return "کلیه مواد بسیار کم چرب باشد"
            }
        }else{
            return com
        }
    }
    
    var comp: String{
        let isPersian = printTitle.isPersianString
        var com : String{
             !isPersian ?
                uamount + " " + unit.replace(replaceUnit) + " of " + title :
                printTitle + " " + uamount.faNumber + " " + unit.replace(replaceUnit)
        }
        if title != "کم چرب" {
            return com
        }else if uamount == "1"{
            switch language {
            case EN: return "All foods and ingredient should be low-fat"
            default: return "کلیه مواد بسیار کم چرب باشد"
            }
        }else{
            return com
        }
    }
}
