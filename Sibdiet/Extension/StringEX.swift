//
//  StringEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 11/17/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit

extension StringProtocol {
    var words: [SubSequence] {
        return split { !$0.isLetter }
    }
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

//usage:
//
//  let str = "abcde"
//  if let index = str.index(of: "cd") {
//    let substring = str[..<index]   // ab
//    let string = String(substring)
//    print(string)  // "ab\n"
//  }
//  let str = "Hello, playground, playground, playground"
//  str.index(of: "play")      // 7
//  str.endIndex(of: "play")   // 11
//  str.indexes(of: "play")    // [7, 19, 31]
//  str.ranges(of: "play")     // [{lowerBound 7, upperBound 11}, {lowerBound 19, upperBound 23}, {lowerBound 31, upperBound 35}]
//  case insensitive sample
//
//  let query = "Play"
//  let ranges = str.ranges(of: query, options: .caseInsensitive)
//  let matches = ranges.map { str[$0] }   //
//  print(matches)  // ["play", "play", "play"]
//  regular expression sample
//
//  let query = "play"
//  let escapedQuery = NSRegularExpression.escapedPattern(for: query)
//  let pattern = "\\b\(escapedQuery)\\w+"  // matches any word that starts with "play" prefix
//
//  let ranges = str.ranges(of: pattern, options: .regularExpression)
//  let matches = ranges.map { str[$0] }
//
//  print(matches) //  ["playground", "playground", "playground"]


extension NSMutableAttributedString {
    func setupAttriutedLable(texts: [String], fonts: [UIFont], colors: [UIColor]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let output = NSMutableAttributedString.init(string: texts.first?.localized() ?? "",
                                                    attributes: [.foregroundColor: colors.first ?? .black,
                                                                 .font: fonts.first ?? .systemFont(ofSize: 10),
                                                                 .paragraphStyle: paragraphStyle])
        guard texts.count > 1, texts.count == fonts.count, texts.count == colors.count else { return output }
        for index in texts.indices.dropFirst() {
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: colors[index],
                                                             .font: fonts[index],
                                                             .paragraphStyle: paragraphStyle]
            output.append(NSAttributedString(string: texts[index].localized(), attributes: attributes))
        }
        return output
    }
}

extension String{
    var toJSON: Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
   var parseJSONString: AnyObject? {
       let data = self.data(using: .utf8, allowLossyConversion: false)
       if let jsonData = data {
           do {
               let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
               if let jsonResult = message as? NSMutableArray { return jsonResult  }
               else { return nil }
           }
           catch _ as NSError { return nil }
       }
       else { return nil }
   }
    
    var int: Int{  Int(enNumber) ?? 0 }
    
    var float: Float{ Float(enNumber) ?? 0 }
    
    var capitalizingFirstLetter: String {  prefix(1).capitalized + dropFirst() }
    
    var lowercased: String{ lowercased() }
    
    var uppercased: String{ uppercased() }
    
    var htmlToStrong: String{ replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) }
    
    var date: Date{
        let newDate = substring(to: 10)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
//        dateFormater.timeZone = TimeZone(abbreviation: "GMT-14:30")
        let dateObjc = dateFormater.date(from: newDate)
        if let date = dateObjc{
            return date
        }else{
            return Date()
        }
    }
    
    var persianDate: Date{
        let newDate = substring(to: 10)
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        formater.calendar = Calendar(identifier: .persian)
//        formater.timeZone = TimeZone(abbreviation: "GMT-14:30")
        let gregorian = formater.date(from: newDate)
        if let newG = gregorian{
            return newG
        }else{
            return Date()
        }
    }
    
    func applyPatternOnNumbers(pattern: String) -> String {
        let replacmentCharacter: Character = "#"
        let pureNumber = self.replacingOccurrences( of: "[^۰-۹0-9]", with: "", options: .regularExpression)
        var result = ""
        var pureNumberIndex = pureNumber.startIndex
        for patternCharacter in pattern {
            guard pureNumberIndex < pureNumber.endIndex else { return result }
            if patternCharacter == replacmentCharacter {
                result.append(pureNumber[pureNumberIndex])
                pureNumber.formIndex(after: &pureNumberIndex)
            } else {
                result.append(patternCharacter)
            }
        }
        return result
    }
    
    func replace(_ dictionary: [String: String]) -> String{
        var result = String()
        var i = -1
        for (of , with): (String, String)in dictionary{
            i += 1
            result = i<1  ? replacingOccurrences(of: of, with: with) : result.replacingOccurrences(of: of, with: with)
        }
        return result
    }
    
    func number(_ direction: String)-> String{
        isRTL ? faNumber : enNumber
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width, .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(.greatestFiniteMagnitude, height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }

    func mutableString(specialString: String,
                       defaultFont: UIFont,
                       defaultColor: UIColor,
                       specialFont: UIFont,
                       specialColor: UIColor,
                       specialBackgroundColor: UIColor) -> NSMutableAttributedString{
        
        let defaultAttributes = [
            NSAttributedString.Key.foregroundColor: defaultColor,
            NSAttributedString.Key.font: defaultFont
            ]
        let specialAttributes = [
            NSAttributedString.Key.foregroundColor: specialColor,
            NSAttributedString.Key.backgroundColor: specialBackgroundColor,
            NSAttributedString.Key.font: specialFont
        ]
        
        var mutableString = NSMutableAttributedString()
        mutableString = NSMutableAttributedString(string: self, attributes: defaultAttributes)
        let range = (self as NSString).range(of: specialString)
        mutableString.addAttributes(specialAttributes, range: range)
        
        return mutableString
    }
    
    var faNumber: String{ replace(["0": "۰",
                                   "1": "۱",
                                   "2": "۲",
                                   "3": "۳",
                                   "4": "۴",
                                   "5": "۵",
                                   "6": "۶",
                                   "7": "۷",
                                   "8": "۸",
                                   "9": "۹"]) }
    
    var enNumber: String{ replace(["۰": "0",
                                   "۱": "1",
                                   "۲": "2",
                                   "۳": "3",
                                   "۴": "4",
                                   "۵": "5",
                                   "۶": "6",
                                   "۷": "7",
                                   "۸": "8",
                                   "۹": "9",
                                   "٠": "0",
                                   "١": "1",
                                   "٢": "2",
                                   "٣": "3",
                                   "٤": "4",
                                   "٥": "5",
                                   "٦": "6",
                                   "٧": "7",
                                   "٨": "8",
                                   "٩": "9"]) }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int) -> String { substring(from: from, to: nil) }
    
    func substring(to: Int) -> String { substring(from: nil, to: to) }
    
    func indexOf(char: Character) -> Int{
        var result = 0
        var i = -1
        for j in self{
            i += 1
            if j == char{
                result = i - 1
            }
        }
        return result
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        return self.substring(from: start, to: to)
    }
    
    var isPersianString: Bool{
        var result = false
        let persianCharachters = ["چ"

            ,"ج"
 
            ,"ح"
            
            ,"خ"
            
            ,"ه"
            
            ,"ع‌"
            
            ,"غ‌"
            
            ,"ف‌"
            
            ,"ق"
            
            ,"ص"
            
            ,"ض"
            
            ,"گ"
            
            ,"ک"
            
            ,"م"
            
            ,"ن"
            
            ,"ت"
            
            ,"ا"
            
            ,"ل"
            
            ,"ب"
            
            ,"ی"
            
            ,"س"
            
            ,"ش"
            
            ,"ث"
            
            ,"و"
             
            ,"د"
            
            ,"ذ"
            
            ,"ر"
            
            ,"ز"
            
            ,"ژ"
            
            ,"ط"
    
            ,"ظ"]
        for c in self{
            for pc in persianCharachters{
                if String(c) == pc{
                    result = true
                }
            }
        }
        return result
    }
    
    var isNumber: Bool{
        var result = false
        let numbers = ["0","1","2","3","4","5","6","7","8","9","۰","۱","۲","۳","۴","۵","۶","۷","۸","۹"]
        for c in self.replace([" ":""]){
            for number in numbers{
                if String(c) == number { result = true }
            }
        }
        return result
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
    
    //    let string = "0123456789"
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    //    string[0...5] //=> "012345"
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    //    string[1...3] //=> "123"
    
    subscript (bounds: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex..<end])
    }
    //    string[3..<7] //=> "3456"

    
    subscript (bounds: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[startIndex...end])
    }
    //    string[...4]  //=> "01234

    subscript (bounds: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        return String(self[start..<endIndex])
    }
    //    string[..<4]  //=> "0123"
    
    public func localized(param: String = "", table: String? = nil) -> String {
        return Bundle.main.localizedString(forKey: self, value: param, table: table)
    }
    //    string[4...]  //=> "456789"
}
