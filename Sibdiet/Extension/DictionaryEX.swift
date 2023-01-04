//
//  DictionaryEX.swift
//  Sibdiet
//
//  Created by Apple on 12/6/19.
//  Copyright © 2019 maminyoo. All rights reserved.
//

import Foundation

extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
