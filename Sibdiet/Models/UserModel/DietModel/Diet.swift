//
//  Diet.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/2/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import SwiftyJSON

class Diet {

    //MARK: DIET TABLE DATA
    var id: String{
        get{ standard.string(forKey: "IDD") ?? String() }
        set{ standard.set(newValue, forKey: "IDD") }
    }
    var goals: [String]{
        get{ standard.array(forKey: "GOALSD\(id)") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "GOALSD\(id)") }
    }
    var bmi: String{
        get{ standard.string(forKey: "BMID\(id)") ?? String() }
        set{ standard.set(newValue, forKey: "BMID\(id)") }
    }
    var idealWeight: String{
        get{ standard.string(forKey: "IDEALWEIGHTD\(id)") ?? String() }
        set{ standard.set(newValue, forKey: "IDEALWEIGHTD\(id)") }
    }
    var overWeight: Int{
        get{ standard.integer(forKey: "OVERWEIGHTD\(id)") }
        set{ standard.set(newValue, forKey: "OVERWEIGHTD\(id)") }
    }
    var weights: [Int]{
        get{ standard.array(forKey: "WEIGHTSD") as? [Int] ?? [Int]()}
        set{ standard.set(newValue, forKey: "WEIGHTSD") }
    }
    var days: [String]{
        get{ standard.array(forKey: "DAYSD") as? [String] ?? [String]() }
        set{ standard.set(newValue, forKey: "DAYSD") }
    }
    var date: String{
        get{ standard.string(forKey: "DATED\(id)") ?? String() }
        set{ standard.set(newValue, forKey: "DATED\(id)") }
    }
    var period: Int{
        get{ standard.integer(forKey: "PERIODD\(id)") }
        set{ standard.set(newValue, forKey: "PERIODD\(id)") }
    }
    
    var lastDay      : Date{ date.date.getDay(after: period) }
    var lastToNow    : Int{ lastDay.days(to: Date()) }
    var pastDay      : Int{ lastToNow + period }
    var leftDay      : Int{ period - pastDay }
    var dontHaveDiet : Bool{ lastToNow > 0 }
    
    var foodList = [String : Food]()

    //MARK: BREAKFASTS
    var breakfast01: Food{ load("BREAK01") }
    var breakfast02: Food{ load("BREAK02") }
    var breakfast03: Food{ load("BREAK03") }
    var breakfast04: Food{ load("BREAK04") }
    var breakfast05: Food{ load("BREAK05") }
    var breakfast06: Food{ load("BREAK06") }
    var breakfast07: Food{ load("BREAK07") }
    var breakfastBread: String{
        get{ standard.string(forKey: "BREAKFASTBREADD")! }
        set{ standard.set(newValue, forKey: "BREAKFASTBREADD") }
    }
    
    //MARK: LUNCHS
    var lunch01    : Food{ load("LUNCH01") }
    var lunch02    : Food{ load("LUNCH02") }
    var lunch03    : Food{ load("LUNCH03") }
    var lunch04    : Food{ load("LUNCH04") }
    var lunch05    : Food{ load("LUNCH05") }
    var lunch06    : Food{ load("LUNCH06") }
    var lunch07    : Food{ load("LUNCH07") }
    var lunchBread: String{
        get{ standard.string(forKey: "LUNCHBREADD")! }
        set{ standard.set(newValue, forKey: "LUNCHBREADD") }
    }
    var lunchRice: String{
        get{ standard.string(forKey: "LUNCHRICED")! }
        set{ standard.set(newValue, forKey: "LUNCHRICED") }
    }
    
    //MARK: DINNERS
    var dinner01   : Food{ load("DINNER01") }
    var dinner02   : Food{ load("DINNER02") }
    var dinner03   : Food{ load("DINNER03") }
    var dinner04   : Food{ load("DINNER04") }
    var dinner05   : Food{ load("DINNER05") }
    var dinner06   : Food{ load("DINNER06") }
    var dinner07   : Food{ load("DINNER07") }
    var dinnerBread: String{
        get{ standard.string(forKey: "DINNERBREADD")! }
        set{ standard.set(newValue, forKey: "DINNERBREADD") }
    }
    
    var dinnerRice: String{
        get{ standard.string(forKey: "DINNERRICED")! }
        set{ standard.set(newValue, forKey: "DINNERRICED") }
    }
    
    //MARK: MORNING SNACK
    var morningSnack: Food{ load("MORNING") }
    var hasMorningSnack: Bool{ morningSnack.title != String() }
    
    //MARK: EVENING SNACK
    var eveningSnack: Food{ load("EVENING") }
    var hasEveningSnack: Bool{ eveningSnack.title != String() }
    
    var obesityDegree = String()
    var defaultsHistory = String()
    var firstWeight = String()
    var firstStature = String()
    var fat = String()
    var status = String()
    var implementations = [String]()
    var diseases = [String]()
    var errands = [String]()
    var room6 = String()
    
    //MARK: LOAD FOOD
    func load(_ wichFood: String) -> Food{
        var result = Food()
        if iOS11{
            if let food = standard.object(forKey: wichFood) as? Data {
                if let meal = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(food)
                    as? FoodStruct {
                    result.reverse(meal)
                }
            }
        }else{
            for (wich, food): (String, Food) in foodList{
                if wich == wichFood{ result = food }
            }
        }
        return result
    }
        
    //MARK: SET DIET DATA
    func setDietsData(json: JSON){
        clear()
        id                = json[DIET][ID].stringValue
        date              = json[DIET][CREATED].stringValue
        idealWeight       = json[DIET][IDEAL_WEIGHT].stringValue
        period            = json[DIET][PERIOD].intValue
        bmi               = json[DIET][BMI].stringValue
        obesityDegree     = json[DIET][OBESITY_DEGREE].stringValue
        defaultsHistory   = json[DIET][DEFAULT_HISTORY].stringValue
        firstWeight       = json[DIET][FIRST_WEIGHT].stringValue
        firstStature      = json[DIET][FIRST_STATURE].stringValue
        
        let bodyFat: JSON = json[DIET][BODY_FAT]
        fat               = bodyFat[FAT].stringValue
        status            = bodyFat[STATUS].stringValue
        overWeight        = json[DIET][OVER_WEIGHT].intValue
        room6             = json[DIET][ROOM6].stringValue

        let goals   = json[DIET][GOALS]
        self.goals  = [String]()
        for (index , goal): (String, JSON) in goals{
            let t = goal.stringValue
            let gt = goal["title"].stringValue
            let string = t != "" ? t : gt
            self.goals.insert(string, at: Int(index)!)
        }
        
        let implementations  = json[DIET][IMPLEMENTATIONS]
        self.implementations = [String]()
        for (index, implementation): (String, JSON) in implementations{
            self.implementations.insert(implementation.stringValue, at: Int(index)!)
        }
        
        let diseases  = json[DIET][DISEASES]
        self.diseases = [String]()
        for (index, disease): (String, JSON) in diseases{
            self.diseases.insert(disease.stringValue, at: Int(index)!)
        }
        
        let errands  = json[DIET][ERRANDS]
        self.errands = [String]()
        for (index, errand): (String, JSON) in errands{
            self.diseases.insert(errand.stringValue, at: Int(index)!)
        }

        let breakfast1 = json[DIET][BREAKFASTS][ONE].intValue
        let breakfast2 = json[DIET][BREAKFASTS][TWO].intValue
        let breakfast3 = json[DIET][BREAKFASTS][THREE].intValue
        let breakfast4 = json[DIET][BREAKFASTS][FOUR].intValue
        let breakfast5 = json[DIET][BREAKFASTS][FIVE].intValue
        let breakfast6 = json[DIET][BREAKFASTS][SIX].intValue
        let breakfast7 = json[DIET][BREAKFASTS][SEVEN].intValue
        breakfastBread = json[DIET][BREAKFASTS][BREAD].stringValue
        
        let lunch1     = json[DIET][LUNCHES][ONE].intValue
        let lunch2     = json[DIET][LUNCHES][TWO].intValue
        let lunch3     = json[DIET][LUNCHES][THREE].intValue
        let lunch4     = json[DIET][LUNCHES][FOUR].intValue
        let lunch5     = json[DIET][LUNCHES][FIVE].intValue
        let lunch6     = json[DIET][LUNCHES][SIX].intValue
        let lunch7     = json[DIET][LUNCHES][SEVEN].intValue
        lunchBread     = json[DIET][LUNCHES][BREAD].stringValue
        lunchRice      = json[DIET][LUNCHES][RICE].stringValue
        
        let dinner1    = json[DIET][DINNERS][ONE].intValue
        let dinner2    = json[DIET][DINNERS][TWO].intValue
        let dinner3    = json[DIET][DINNERS][THREE].intValue
        let dinner4    = json[DIET][DINNERS][FOUR].intValue
        let dinner5    = json[DIET][DINNERS][FIVE].intValue
        let dinner6    = json[DIET][DINNERS][SIX].intValue
        let dinner7    = json[DIET][DINNERS][SEVEN].intValue
        dinnerBread    = json[DIET][DINNERS][BREAD].stringValue
        dinnerRice     = json[DIET][DINNERS][RICE].stringValue
        
        let morning    = json[DIET][MORNING_SNACK].intValue
        let evening    = json[DIET][EVENING_SNACK].intValue
        
        let foodIds = [breakfast1, breakfast2, breakfast3, breakfast4, breakfast5, breakfast6, breakfast7,
                       lunch1, lunch2, lunch3, lunch4, lunch5, lunch6, lunch7,
                       dinner1, dinner2, dinner3, dinner4, dinner5, dinner6, dinner7,
                       morning, evening]
        
        let foods = json[DIET][FOODS]
        var foodsHelper = [Food]()
        for (_, food): (String, JSON) in foods{
            let meal = Food()
            meal.id          = food[ID].intValue
            meal.title       = food[TITLE].stringValue
            meal.supplement  = food[SUPPLEMENT].stringValue
            meal.preparation = food[PREPARTION].stringValue
            let compositions = food[COMPOSITIONS]
            for (_, composition): (String, JSON) in compositions{
                let foodCompositions     = FoodCompositions()
                foodCompositions.id      = composition[ID].stringValue
                foodCompositions.title   = composition[PRINT_TITLE].stringValue != "" ?
                                           composition[PRINT_TITLE].stringValue :
                                           composition[TITLE].stringValue
                foodCompositions.unit    = composition[UNIT].stringValue
                foodCompositions.uamount = composition[UAMOUNT].stringValue
                meal.foodCompositions.append(foodCompositions)
            }
            
            var result = String()
            var i = 0
            for com in meal.foodCompositions{
                i += 1
                let composition = extraConnection.e == "0" ? com.composition : com.comp
                result += i>1 ? " + \(composition)" : "\(composition)"
            }
            meal.composition = result
            foodsHelper.append(meal)
        }
        
        var i = -1
        for id in foodIds{
            i += 1
            for food in foodsHelper{
                if id == food.id{
                    switch i{
                    case 0  : save(food, "BREAK01")
                    case 1  : save(food, "BREAK02")
                    case 2  : save(food, "BREAK03")
                    case 3  : save(food, "BREAK04")
                    case 4  : save(food, "BREAK05")
                    case 5  : save(food, "BREAK06")
                    case 6  : save(food, "BREAK07")
                    case 7  : save(food, "LUNCH01")
                    case 8  : save(food, "LUNCH02")
                    case 9  : save(food, "LUNCH03")
                    case 10 : save(food, "LUNCH04")
                    case 11 : save(food, "LUNCH05")
                    case 12 : save(food, "LUNCH06")
                    case 13 : save(food, "LUNCH07")
                    case 14 : save(food, "DINNER01")
                    case 15 : save(food, "DINNER02")
                    case 16 : save(food, "DINNER03")
                    case 17 : save(food, "DINNER04")
                    case 18 : save(food, "DINNER05")
                    case 19 : save(food, "DINNER06")
                    case 20 : save(food, "DINNER07")
                    case 21 : save(food, "MORNING")
                    case 22 : save(food, "EVENING")
                    default : break
                    }
                }
            }
        }
    }
    
    func clear(){
        id                = String()
        goals             = [String]()
        date              = String()
        idealWeight       = String()
        overWeight        = Int()
        period            = Int()
        bmi               = String()
        obesityDegree     = String()
        defaultsHistory   = String()
        firstWeight       = String()
        firstStature      = String()
        weights           = [Int]()
        days              = [String]()
        breakfastBread    = String()
        lunchBread        = String()
        lunchRice         = String()
        dinnerBread       = String()
        dinnerRice        = String()
        foodList          = [String : Food]()
        if #available(iOS 11.0, *) {
            if let meal = try? NSKeyedArchiver.archivedData(withRootObject: FoodStruct(Food()),
                                                            requiringSecureCoding: false) {
                standard.set(meal, forKey: "MORNING")
                standard.set(meal, forKey: "EVENING")
                standard.set(meal, forKey: "BREAK01")
                standard.set(meal, forKey: "BREAK02")
                standard.set(meal, forKey: "BREAK03")
                standard.set(meal, forKey: "BREAK04")
                standard.set(meal, forKey: "BREAK05")
                standard.set(meal, forKey: "BREAK06")
                standard.set(meal, forKey: "BREAK07")
                standard.set(meal, forKey: "LUNCH01")
                standard.set(meal, forKey: "LUNCH02")
                standard.set(meal, forKey: "LUNCH03")
                standard.set(meal, forKey: "LUNCH04")
                standard.set(meal, forKey: "LUNCH05")
                standard.set(meal, forKey: "LUNCH06")
                standard.set(meal, forKey: "LUNCH07")
                standard.set(meal, forKey: "DINNER01")
                standard.set(meal, forKey: "DINNER02")
                standard.set(meal, forKey: "DINNER03")
                standard.set(meal, forKey: "DINNER04")
                standard.set(meal, forKey: "DINNER05")
                standard.set(meal, forKey: "DINNER06")
                standard.set(meal, forKey: "DINNER07")
            }
        }
    }
    
    func save(_ food: Food, _ whichMeal: String){
        if #available(iOS 11.0, *) {
            if let meal = try? NSKeyedArchiver.archivedData(withRootObject: FoodStruct(food),
                                                            requiringSecureCoding: false) {
                standard.set(meal, forKey: whichMeal) }
        } else { foodList[whichMeal] = food }
    }
    
    
    //MARK: SET WEIGHTS DATES
    func setWeightsDates(json: JSON){
        weights = [Int]()
        days = [String]()
        let list =  json[DIETS]
        let count = list.count-1
        idealWeight = list[isWaiting ? count-1 : count][IDEAL_WEIGHT].stringValue
        for (s, diet): (String, JSON) in list{
            let body = diet[BODY].stringValue
            let date = diet[DATE].stringValue
            
            let data = Data(body.utf8)
            var lastW = Float()
            do {
                if let js = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    lastW = (Float(js[WEIGHT]!))!
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            let subString = body.substring(from: 10, to : 18)
            let wait = isWaiting && s.int == list.count-1
            let index = subString.indexOf(char: ",")
            let weight = wait ? lastW : Float(subString.substring(to: index).replace(["\"":""]))
            weights.append(weight!.int)
            days.append(date)
        }
        var w = [Int]()
        var d = [String]()
        if weights.count>=3{
            w.append(weights[0])
            w.append(weights[weights.count-2])
            w.append(weights[weights.count-1])
            d.append(days[0])
            d.append(days[days.count-2])
            d.append(days[days.count-1])
        }else if weights.count == 2{
            w.append(weights[0])
            w.append(weights[1])
            d.append(days[0])
            d.append(days[1])
        }else{
            w.append(weights[0])
            d.append(days[0])
        }
        weights = w
        days = d
    }
}
