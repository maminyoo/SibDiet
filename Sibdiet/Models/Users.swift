//
//  Users.swift
//  Sibdiet
//
//  Created by Amin on 3/11/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import SwiftyJSON

class Users{
    
    let PERSONS = "person"
    var persons = [[String: String]]()
    var defaultsPersons: [[String: String]]{
        if let persons = standard.array(forKey: PERSONS) as? [[String: String]] { return persons }
        return persons
    }
    
    var hasUser:   Bool{ defaultsPersons.count > 0 }
    var hasFamily: Bool{ defaultsPersons.count > 1 }
    
    //MARK: SAVE USER
    func saveUser(json: JSON){
        persons = defaultsPersons
        let person = [MOBILE      : json[PROFILE][MOBILE].stringValue,
                      FILE_NUMBER : json[PROFILE][ID].stringValue,
                      F_NAME      : json[PROFILE][F_NAME].stringValue,
                      L_NAME      : json[PROFILE][L_NAME].stringValue]
        persons.append(person)
        standard.set(persons, forKey: PERSONS)
    }
    
    //MARK: REPLACE USER
    func replaceUser(){
        persons = defaultsPersons
        let unit = [MOBILE      : updateProfile.mobile.enNumber,
                    FILE_NUMBER : profile.fileNumber,
                    F_NAME      : profile.fname,
                    L_NAME      : profile.lname]
        persons.append(unit)
        standard.set(persons, forKey: PERSONS)
    }
    
    //MARK: LOAD LAST USER
    func loadLastUser(){
        let count = defaultsPersons.count
        dietConnection.getData(defaultsPersons[count-1][MOBILE]!,
                               defaultsPersons[count-1][FILE_NUMBER]!)
    }
    
    //MARK: NEED SAVE
    func needSave(_ fileNumber: String) -> Bool{
        var bool = true
        for u in defaultsPersons{
            let fNumber = u[FILE_NUMBER]
            if fNumber == fileNumber { bool = false }
        }
        return bool
    }
    
    //MARK: REMOVE USER
    func remove(_ fileNumber: String){
        persons = defaultsPersons
        var i = -1
        for person in persons{
            i += 1
            if person[FILE_NUMBER] == fileNumber{ persons.remove(at: i) }
        }
        standard.set(persons, forKey: PERSONS)
    }
}
