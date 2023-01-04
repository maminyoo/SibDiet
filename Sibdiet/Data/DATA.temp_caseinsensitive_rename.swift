//
//  CoreDataService.Swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/4/17.
//  Copyright © 2017 Application.Studio. All rights reserved.
//

import SwiftyJSON
import Alamofire
import CoreData

protocol DataStatusDelegate {
    func notFountPhone()
    func notFount()
    func connectionError()
    func fount()
}

protocol LoginDelegate{
    func onLoading()
    func retry()
    func login()
    func loginNewUser()
}

protocol RegisterDelegate{
    func registered()
    func doplicateMobile()
    func notConnect()
    func inCorrectMobile()
}

class DATA: DataStatusDelegate, LoginDelegate, RegisterDelegate{
    
    var delegateDataStatus: DataStatusDelegate?
    var delegateLogin: LoginDelegate?
    var delegateRegister: RegisterDelegate?

    var profile = Profile()
    var updateProfile = UpdateProfile()
    var register = Register()
    var updateBody = UpdateBody()
    var specializedInformation = SpecializedInformation()
    
    private let apiKey = "WC7WPCS4JSTSNYF94VD2"
    
    private let idUrl = "http://sibdiet.net/webservice/get/sibdiet3/diets?"
    private let profileUrl = "http://sibdiet.net/webservice/get/sibdiet3/profile?"
    private let dietsUrl = "http://sibdiet.net/webservice/get/sibdiet3/diet?"
    private let forgetUrl = "http://sibdiet.net/webservice/get/sibdiet3/profile?"
    private let updateUrl = "http://sibdiet.net/webservice/put/sibdiet3/profile?"
    private let registerUrl = "http://sibdiet.net/webservice/post/sibdiet3/profile?"
    private let getDietUrl = "http://sibdiet.net/webservice/post/sibdiet3/diet?"
    
    private let paymentUrl = "http://sibdiet.net/payment?"
    private let newDeviceUrl = "http://foodsms.com/index.php/api/v1/ios/register?"
    private let savePersonUrl = "http://foodsms.com/index.php/api/v1/ios/detail?"
    
    private let context = AppDelegate.context
    
    var UUID: String{
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    func payUrl() -> URLRequest{
        let r = profile.fileNumber + profile.id
        let stringUrl = paymentUrl+"p="+profile.fileNumber+"&m="+profile.mobile+"&r="+r+"&tmpl=component"
        let url = URL(string: stringUrl)
        return URLRequest(url: url!)
    }
    
    func forget(mobile: String){
        let param: [String : String] = ["api_key" : apiKey, "m" : mobile]
        getForget(url: forgetUrl, parameters: param)
    }
    
    private func  getForget(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json["status"].stringValue
                if status == "ko"{
                    self.notFountPhone()
                }else{
                    self.fount()
                }
            }else{
                self.connectionError()
            }
        }
    }
    
    func getData(mobile: String, fileNumber: String){
        let param: [String: String] = ["api_key" : apiKey, "p": fileNumber, "m": mobile]
        getProfile(url: profileUrl, parameters: param)
        onLoading()
    }
    
    func onLoading() {
        delegateLogin?.onLoading()
    }
    
    private func getProfile(url: String, parameters: [String: String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json["status"].stringValue
                let fileNumber = json["profile"]["id"].stringValue
                if status == "ko"{
                    self.notFount()
                }else{
                    self.setProfile(json: json)
                    
                    if self.needSave(fileNumber: fileNumber){
                        self.savePerson(json: json)
                    }
                }
                
            }else{
                self.connectionError()
            }
        }
        
    }
    
    private func getDietsInfo(url: String, parameters: [String: String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json["status"].stringValue
                if status == "ko"{
                    self.notFount()
                }else{
                    self.setDietInfo(json: json)

                }
            }else{
                self.connectionError()
            }
        }
    }
    
    private func savePerson(json: JSON){
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        
        person.mobile = json["profile"]["mobile"].stringValue
        person.fileNumber = json["profile"]["id"].stringValue
        person.fname = json["profile"]["fname"].stringValue
        person.lname = json["profile"]["lname"].stringValue
        
        do{
            try context.save()
        }catch{
            print("not Save")
        }
    }
    
    private func setDietInfo(json: JSON){
        var dietCount = json["diets"].count
        
        specializedInformation.reset()

        profile.dietCount = dietCount
        if dietCount>0{
            let fileNumber = profile.fileNumber
            let phone = profile.mobile
            var id = json["diets"][dietCount-1]["id"].stringValue
            let body = json["diets"][dietCount-1]["body"].stringValue
            if body == "{}"{
                dietCount -= 1
                id = json["diets"][dietCount-1]["id"].stringValue
            }
            profile.id = id
            let param: [String: String] = ["api_key": apiKey, "p": fileNumber, "m": phone, "d": id]
            self.getDietData(url : dietsUrl, parameters : param)
        }else{
            loginNewUser()
        }
    }
    
    func loginNewUser(){
        delegateLogin?.loginNewUser()
        updateBody.reset()
        profile.diet = Diet()
        profile.prescriptions = Prescriptions()
        profile.supplements = [Supplements]()
        profile.body = Body()
    }
    
    private func getDietData(url: String, parameters: [String: String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                if json["diet"] != "null"{
                    self.setDietsData(json: json)
                    self.setPrescriptionsData(json: json)
                    self.setSupplementData(json: json)
                    self.setBody(json: json)
                }
            }
            else{
                self.connectionError()
            }
        }
    }
    
    func notFountPhone() {
        delegateDataStatus?.notFountPhone()
    }
    
    func notFount() {
        delegateDataStatus?.notFount()
    }
    
    func connectionError() {
        delegateDataStatus?.connectionError()
    }
    
    func fount() {
        delegateDataStatus?.fount()
    }
    
    func havePerson() -> Bool{
        var havePerson = false
        let person = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let persons = try context.fetch(person) as! [Person]
            if persons.count>0{
                havePerson = true
            }
        }catch{
            print("dont fetch")
        }
        return havePerson
    }
    
    func haveFamily() -> Bool{
        var haveFamily = false
        let person = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let persons = try context.fetch(person) as! [Person]
            if persons.count>1{
                haveFamily = true
            }
        }catch{
            print("dont fetch")
        }
        return haveFamily
    }
    
    func loadLastPerson(){
        let person = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let persons = try context.fetch(person) as! [Person]
            
            let count = persons.count
            if count>0{
                let fileNumber = persons[count-1].fileNumber
                let mobile = persons[count-1].mobile
                self.getData(mobile: mobile!, fileNumber: fileNumber!)
            }
        }catch{
            print("dont fetch")
        }
    }
    
    func family() -> [Person]{
        var persons = [Person]()
        let person = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            persons = try context.fetch(person) as! [Person]
        }catch{
            print("dont fetch")
        }
        return persons
    }
    
    func needSave(fileNumber: String) -> Bool{
        var canSave = true
        let person = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let persons = try context.fetch(person) as! [Person]
            for prs in persons{
                if prs.fileNumber == fileNumber{
                    canSave = false
                }
            }
        }catch{
            print("dont fetch")
        }
        return canSave
    }
    
    func remove(fileNumber: String){
        let person = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let persons = try context.fetch(person) as! [Person]
            for prs in persons{
                if prs.fileNumber == fileNumber{
                    context.delete(prs)
                }
            }
        }catch{
            print("dont fetch")
        }
    }
    
    func registerUser(){
        let dictionary = data.register.register
        
        let updateData = try! JSONEncoder().encode(dictionary)
        let jsonString = String(data: updateData, encoding: .utf8)!
        
        var components = URLComponents(string: registerUrl)!
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                 URLQueryItem(name: "profile", value: jsonString)]
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        Alamofire.request(components.url!, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json["status"].stringValue
                let fileNumber = json["profileNo"].stringValue
                let error = json["error_description"].stringValue
                let mobilError = json["notvalid"][0].stringValue
                if status == "ok"{
                    self.register.fileNumber = fileNumber
                    self.registered()
                    print(fileNumber)
                }else if error == "پرونده ای با این موبایل موجود می باشد."{
                    self.doplicateMobile()
                }else if mobilError == "mobile"{
                    self.inCorrectMobile()
                }
            }else{
                self.notConnect()
            }
        }
    }
    
    func registered() {
        delegateRegister?.registered()
    }
    
    func doplicateMobile() {
        delegateRegister?.doplicateMobile()
    }
    
    func notConnect() {
        delegateRegister?.notConnect()
    }
    
    func inCorrectMobile() {
        delegateRegister?.inCorrectMobile()
    }
    
    func needUpdate() -> Bool{
        var bool = false
        if updateProfile.mobile.count == 11 && updateProfile.mobile.persianInt() != profile.mobile.persianInt(){
            bool = true
        }else if profile.birthday.toString() != updateProfile.birthday.toString(){
            bool = true
        }else if profile.gender != updateProfile.genderResult{
            bool = true
        }else if profile.marital != updateProfile.maritalResult{
            bool = true
        }else if profile.blood != updateProfile.bloodResult{
            bool = true
        }else if profile.education != updateProfile.educationResult{
            bool = true
        }else if profile.job != updateProfile.job{
            bool = true
        }else if profile.country != updateProfile.countryResult{
            bool = true
        }else if profile.city != updateProfile.city{
            bool = true
        }else if profile.homePhone.persianInt() != updateProfile.homePhone.persianInt(){
            bool = true
        }else if profile.homeAddress.persianInt() != updateProfile.homeAddress.persianInt(){
            bool = true
        }
        return bool
    }
    
    func update(){
        let dictionary = data.updateProfile.profile
        
        let updateData = try! JSONEncoder().encode(dictionary)
        let jsonString = String(data: updateData, encoding: .utf8)!

        var components = URLComponents(string: updateUrl)!
        
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                 URLQueryItem(name: "p", value: data.profile.fileNumber),
                                 URLQueryItem(name: "m", value: data.profile.mobile),
                                 URLQueryItem(name: "profile", value: jsonString)]
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        Alamofire.request(components.url!, method: .put).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                let status = json["status"].stringValue
                if status == "ok"{
                    self.saveUpdate()
                }else{
//                    print(response.error!)
                }
            }
        }
    }
    
    
    private func saveUpdate(){
        profile.mobile = updateProfile.mobile.englishInt()
        profile.birthday = updateProfile.birthday
        profile.gender = updateProfile.genderResult
        profile.marital = updateProfile.maritalResult
        profile.blood = updateProfile.bloodResult
        profile.education = updateProfile.educationResult
        profile.job = updateProfile.job
        profile.country = updateProfile.countryResult
        profile.city = updateProfile.city
        profile.homePhone = updateProfile.homePhone
        profile.homeAddress = updateProfile.homeAddress
    }
    
    func getDiet(){
        let request = [specializedInformation.request]
        let profile = [updateProfile.profile]
        let body = [updateBody.body]
        let special = [specializedInformation.special]
        let payment = [specializedInformation.payment]
        
        let diet = ["request": request,
                    "profile": profile,
                    "body": body,
                    "special": special,
                    "payment": payment]
        
        let dictionary = ["diet": diet]
        
        let dietData = try! JSONEncoder().encode(dictionary)
        let jsonString = String(data: dietData, encoding: .utf8)!
        
        var components = URLComponents(string: getDietUrl)!
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                 URLQueryItem(name: "p", value: data.profile.fileNumber.englishInt()),
                                 URLQueryItem(name: "m", value: data.profile.mobile.englishInt()),
                                 URLQueryItem(name: "diet", value: jsonString)]
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        Alamofire.request(components.url!, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                let json: JSON = JSON(response.result.value!)
                print(json)
            }
        }
    }
    
    private func setProfile(json: JSON){
        profile = Profile()
        
        profile.city = json["profile"]["city"].stringValue
        profile.marital = json["profile"]["marital"].stringValue
        profile.mobile = json["profile"]["mobile"].stringValue
        profile.homeAddress = json["profile"]["homeaddress"].stringValue
        profile.gender = json["profile"]["gender"].stringValue
        profile.naturalTemper = json["profile"]["natural_temper"].stringValue
        profile.homePhone = json["profile"]["homephone"].stringValue
        profile.birthday = json["profile"]["birthday"].stringValue.date()
        profile.telegramId = json["profile"]["telegram_id"].stringValue
        profile.fileNumber = json["profile"]["id"].stringValue
        profile.lname = json["profile"]["lname"].stringValue
        profile.job = json["profile"]["job"].stringValue
        profile.education = json["profile"]["education"].stringValue
        profile.blood = json["profile"]["blood"].stringValue
        profile.fname = json["profile"]["fname"].stringValue
        profile.country = json["profile"]["country"].stringValue
        
        saveProfile()

        let param: [String: String] = ["api_key" : apiKey, "p": profile.fileNumber, "m": profile.mobile]
        getDietsInfo(url: idUrl, parameters: param)
    }
    
    private func saveProfile(){
        updateProfile.mobile = profile.mobile.englishInt()
        updateProfile.birthday = profile.birthday
        updateProfile.gender = profile.gender
        updateProfile.marital = profile.marital
        updateProfile.blood =  profile.blood
        updateProfile.education = profile.education
        updateProfile.job = profile.job
        updateProfile.country = profile.country
        updateProfile.city =  profile.city
        updateProfile.homePhone = profile.homePhone.englishInt()
        updateProfile.homeAddress = profile.homeAddress
    }
    
    private func setDietsData(json: JSON){
        let diet = Diet()
        
        diet.dietCount = profile.dietCount
        diet.id = json["diet"]["id"].stringValue
        diet.date = json["diet"]["created"].stringValue.date()
        diet.idealWeight = json["diet"]["ideal_weight"].stringValue
        diet.period = json["diet"]["period"].intValue
        
        let goals = json["diet"]["goals"]
        for (index , goal): (String, JSON) in goals{
            diet.goals.insert(goal.stringValue, at: Int(index)!)
        }
        
        diet.bmi = json["diet"]["bmi"].stringValue
        diet.obesityDegree = json["diet"]["obesityDegree"].stringValue
        diet.defaultsHistory = json["diet"]["defaultsHistory"].stringValue
        diet.firstWeight = json["diet"]["firstWeight"].stringValue
        diet.firstStature =  json["diet"]["firstStature"].stringValue
        
        let bodyFat: JSON = json["diet"]["bodyFat"]
        diet.fat = bodyFat["fat"].stringValue
        diet.status = bodyFat["status"].stringValue
        diet.overWeight = json["diet"]["overWeight"].stringValue
        
        let implementations = json["diet"]["implementations"]
        for (index, implementation): (String, JSON) in implementations{
            diet.implementations.insert(implementation.stringValue, at: Int(index)!)
        }
        
        let diseases = json["diet"]["diseases"]
        for (index, disease): (String, JSON) in diseases{
            diet.diseases.insert(disease.stringValue, at: Int(index)!)
        }
        
        let errands = json["diet"]["errands"]
        for (index, errand): (String, JSON) in errands{
            diet.diseases.insert(errand.stringValue, at: Int(index)!)
        }
        
        diet.room6 = json["diet"]["room6"].stringValue
        
        let breakfast01 = json["diet"]["breakfasts"]["1"].intValue
        let breakfast02 = json["diet"]["breakfasts"]["2"].intValue
        let breakfast03 = json["diet"]["breakfasts"]["3"].intValue
        let breakfast04 = json["diet"]["breakfasts"]["4"].intValue
        let breakfast05 = json["diet"]["breakfasts"]["5"].intValue
        let breakfast06 = json["diet"]["breakfasts"]["6"].intValue
        let breakfast07 = json["diet"]["breakfasts"]["7"].intValue
        
        diet.breakfastBread = json["diet"]["breakfasts"]["bread"].stringValue
        
        let lunch01 = json["diet"]["lunchs"]["1"].intValue
        let lunch02 = json["diet"]["lunchs"]["2"].intValue
        let lunch03 = json["diet"]["lunchs"]["3"].intValue
        let lunch04 = json["diet"]["lunchs"]["4"].intValue
        let lunch05 = json["diet"]["lunchs"]["5"].intValue
        let lunch06 = json["diet"]["lunchs"]["6"].intValue
        let lunch07 = json["diet"]["lunchs"]["7"].intValue
        
        diet.lunchBread = json["diet"]["lunchs"]["bread"].stringValue
        diet.lunchRice = json["diet"]["lunchs"]["rice"].stringValue
        
        let dinner01 = json["diet"]["dinners"]["1"].intValue
        let dinner02 = json["diet"]["dinners"]["2"].intValue
        let dinner03 = json["diet"]["dinners"]["3"].intValue
        let dinner04 = json["diet"]["dinners"]["4"].intValue
        let dinner05 = json["diet"]["dinners"]["5"].intValue
        let dinner06 = json["diet"]["dinners"]["6"].intValue
        let dinner07 = json["diet"]["dinners"]["7"].intValue
        
        diet.dinnerBread = json["diet"]["dinners"]["bread"].stringValue
        diet.dinnerRice = json["diet"]["dinners"]["rice"].stringValue
        
        let morningSnack = json["diet"]["morning_snack_id"].intValue
        let eveningSnack = json["diet"]["evening_snack_id"].intValue
        
        let foodIds = [breakfast01,
                       breakfast02,
                       breakfast03,
                       breakfast04,
                       breakfast05,
                       breakfast06,
                       breakfast07,
                       lunch01,
                       lunch02,
                       lunch03,
                       lunch04,
                       lunch05,
                       lunch06,
                       lunch07,
                       dinner01,
                       dinner02,
                       dinner03,
                       dinner04,
                       dinner05,
                       dinner06,
                       dinner07,
                       morningSnack,
                       eveningSnack]
        
        let foods = json["diet"]["foods"]
        
        var foodsHelper = [Food]()
        
        for (_, food): (String, JSON) in foods{
            let meal = Food()
            
            meal.id = food["id"].intValue
            meal.title = food["title"].stringValue
            meal.supplement = food["supplement"].stringValue
            meal.preparation = food["preparation"].stringValue
            
            let compositions = food["compositions"]
            
            for (_, composition): (String, JSON) in compositions{
                let foodCompositions = FoodCompositions()
                
                foodCompositions.id = composition["id"].stringValue
                foodCompositions.title = composition["title"].stringValue
                foodCompositions.printTitle = composition["print_title"].stringValue
                foodCompositions.unit = composition["unit"].stringValue
                foodCompositions.uamount = composition["uamount"].stringValue
                meal.foodCompositions.append(foodCompositions)
            }
            foodsHelper.append(meal)
        }
        
        var i = -1
        for id in foodIds{
            i += 1
            for food in foodsHelper{
                if id == food.id{
                    switch i{
                        
                    case 0:
                        diet.breakfast01 = food
                    case 1:
                        diet.breakfast02 = food
                    case 2:
                        diet.breakfast03 = food
                    case 3:
                        diet.breakfast04 = food
                    case 4:
                        diet.breakfast05 = food
                    case 5:
                        diet.breakfast06 = food
                    case 6:
                        diet.breakfast07 = food
                        
                    case 7:
                        diet.lunch01 = food
                    case 8:
                        diet.lunch02 = food
                    case 9:
                        diet.lunch03 = food
                    case 10:
                        diet.lunch04 = food
                    case 11:
                        diet.lunch05 = food
                    case 12:
                        diet.lunch06 = food
                    case 13:
                        diet.lunch07 = food
                        
                    case 14:
                        diet.dinner01 = food
                    case 15:
                        diet.dinner02 = food
                    case 16:
                        diet.dinner03 = food
                    case 17:
                        diet.dinner04 = food
                    case 18:
                        diet.dinner05 = food
                    case 19:
                        diet.dinner06 = food
                    case 20:
                        diet.dinner07 = food
                        
                    case 21:
                        diet.morningSnack = food
                    case 22:
                        diet.eveningSnack = food
                        
                    default:
                        break
                    }
                }
            }
        }
        profile.diet = diet
    }
    
    private func setPrescriptionsData(json: JSON){
        let prescriptions = Prescriptions()
        
        prescriptions.dietTitle = json["diet"]["dietTitle"].stringValue
        prescriptions.specialRecommendation = json["diet"]["specialRecommendation"].stringValue
        
        prescriptions.activityTitle = json["diet"]["activityTitle"].stringValue
        prescriptions.activityAmount = json["diet"]["activityAmount"].stringValue
        prescriptions.activityDescription = json["diet"]["activityDescription"].stringValue
        
        prescriptions.sweetenerTitle = json["diet"]["sweetenerTitle"].stringValue
        prescriptions.sweetenerAmount = json["diet"]["sweetenerAmount"].stringValue
        prescriptions.sweetenerDescription = json["diet"]["sweetenerDescription"].stringValue
        
        prescriptions.fruitTitle = json["diet"]["fruitTitle"].stringValue
        prescriptions.fruitAmount = json["diet"]["fruitAmount"].stringValue
        prescriptions.fruitDescription = json["diet"]["fruitDescription"].stringValue
        
        prescriptions.dairyTitle = json["diet"]["dairyTitle"].stringValue
        prescriptions.dairyAmount = json["diet"]["dairyAmount"].stringValue
        prescriptions.dairyDescription = json["diet"]["dairyDescription"].stringValue
        
        profile.prescriptions = prescriptions
    }
    
    private func setSupplementData(json: JSON){
        profile.supplements = [Supplements]()
        let prescriptions = json["diet"]["prescriptions"]
        if prescriptions.count > 0{
            for (_, prescription): (String, JSON) in prescriptions{
                let supplement = Supplements()
                supplement.title = prescription["title"].stringValue
                supplement.printTitle = prescription["print_title"].stringValue
                supplement.amount = prescription["amount"].stringValue
                supplement.usage = prescription["usage"].stringValue
                supplement.descriptions = prescription["description"].stringValue
                profile.supplements.append(supplement)
            }
        }
        let hprescriptions = json["diet"]["hprescriptions"]
        if hprescriptions.count > 0{
            for (_, hprescription): (String, JSON) in hprescriptions{
                let supplement = Supplements()
                supplement.title = hprescription["title"].stringValue
                supplement.printTitle = hprescription["print_title"].stringValue
                supplement.amount = hprescription["amount"].stringValue
                supplement.usage = hprescription["usage"].stringValue
                supplement.descriptions = hprescription["description"].stringValue
                profile.supplements.append(supplement)

            }
        }
    }
    
    private func setBody(json: JSON){
        let body = Body()
        body.weight = json["diet"]["weight"].stringValue
        body.stature = json["diet"]["stature"].stringValue
        body.wrist = json["diet"]["wrist"].stringValue
        body.abdominal = json["diet"]["abdominal"].stringValue
        body.hip = json["diet"]["hip"].stringValue
        body.thigh = json["diet"]["thigh"].stringValue
        body.chest = json["diet"]["chest"].stringValue
        body.shoulders = json["diet"]["shoulders"].stringValue
        body.birthWeight = json["diet"]["birth_weight"].stringValue
        body.birthStature = json["diet"]["birth_stature"].stringValue
        body.fatherStature = json["diet"]["father_stature"].stringValue
        body.motherStature = json["diet"]["mother_stature"].stringValue
        updateBody.reset()
        profile.body = body
        login()
    }
    
    func login(){
        if profile.diet.goals == []{
            retry()
        }else{
            delegateLogin?.login()
        }
    }
    
    func retry() {
        delegateLogin?.retry()
    }
}
