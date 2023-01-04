//
//  IntEX.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/15/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import UIKit

prefix func ++ <T: Numeric> (right: inout T) -> T {
    right += 1
    return right
}

postfix func ++ <T: Numeric> (left: inout T) -> T {
    let value = left
    left += 1
    return value
}

extension Int{
  
    var persianThString: String{
        var result = ""
        let persianThString01 = ["1":"اول",
                                 "2":"دوم",
                                 "3":"سوم",
                                 "4":"چهارم",
                                 "5":"پنجم",
                                 "6":"ششم",
                                 "7":"هفتم",
                                 "8":"هشتم",
                                 "9":"نهم",]
        
        let persianThString02 = ["10":"دهم",
                                 "11":"یازدهم",
                                 "12":"دوازدهم",
                                 "13":"سیزدهم",
                                 "14":"چهاردهم",
                                 "15":"پانزدهم",
                                 "16":"شانزدهم",
                                 "17":"هفدهم",
                                 "18":"هجدهم",
                                 "19":"نوزدهم",
                                 "20":"بیستم",
                                 "21":"بیست و یکم",
                                 "22":"بیست و دوم",
                                 "23":"بیست و سوم",
                                 "24":"بیست و چهارم",
                                 "25":"بیست و پنجم",
                                 "26":"بیست و ششم",
                                 "27":"بیست و هفتم",
                                 "28":"بیست و هشتم",
                                 "29":"بیست و نهم",
                                 "30":"سی ام",
                                 "31":"سی و یکم",
                                 "32":"سی و دوم",
                                 "33":"سی و سوم",
                                 "34":"سی و چهارم",
                                 "35":"سی و پنجم",
                                 "36":"سی و ششم",
                                 "37":"سی و هفتم",
                                 "38":"سی و هشتم",
                                 "39":"سی و نهم",
                                 "40":"چهل ام",
                                 "41":"چهل و یکم",
                                 "42":"چهل و دوم",
                                 "43":"چهل و سوم",
                                 "44":"چهل و چهارم",
                                 "45":"چهل و پنجم",
                                 "46":"چهل و ششم",
                                 "47":"چهل و هفت",
                                 "48":"چهل و هشت",
                                 "49":"چهل و نه",
                                 "50":"پنجاهم",]
        
        if self > 0 && self < 10{
            result = String(self).replace(persianThString01)
        }else if self > 9{
            result = String(self).replace(persianThString02)
        }
        return result
    }
    
    var th: String{
        var result = ""
        let underTen = ["1":"1st",
                        "2":"2nd",
                        "3":"3rd",
                        "4":"4th",
                        "5":"5th",
                        "6":"6th",
                        "7":"7th",
                        "8":"8th",
                        "9":"9th",]
        
        let uperTen = ["10":"10th",
                       "11":"11th",
                       "12":"12th",
                       "13":"13th",
                       "14":"14th",
                       "15":"15th",
                       "16":"16th",
                       "17":"17th",
                       "18":"18th",
                       "19":"19th",
                       "20":"20th",
                       "21":"21st",
                       "22":"22nd",
                       "23":"23rd",
                       "24":"24th",
                       "25":"25th",
                       "26":"26th",
                       "27":"27th",
                       "28":"28th",
                       "29":"29th",
                       "30":"30th",
                       "31":"31st",
                       "32":"32nd",
                       "33":"33rd",
                       "34":"34th",
                       "35":"35th",
                       "36":"36th",
                       "37":"37th",
                       "38":"38th",
                       "39":"39th",
                       "40":"40th",
                       "41":"41st",
                       "42":"42nd",
                       "43":"43rd",
                       "44":"44th",
                       "45":"45th",
                       "46":"46th",
                       "47":"47th",
                       "48":"48th",
                       "49":"49th",
                       "50":"50th"]
        
        if self > 0 && self < 10{
            result = String(self).replace(underTen)
        }else if self > 9{
            result = String(self).replace(uperTen)
        }
        return result
    }
    
    var periodString: String{
        let replaceNumberString01 =
            ["0": "",
             "1": "One",
             "2": "Two",
             "3": "Three",
             "4": "Four",
             "5": "Five",
             "6": "Six",
             "7": "Seven",
             "8": "Eight",
             "9": "Nine",]
        let replaceNumberString02 = ["10": "Ten",
                                     "11": "Eleven",
                                     "12": "Twelve",
                                     "13": "Thirteen",
                                     "14": "Fourteen",
                                     "15": "Fifteen",
                                     "16": "Sixteen",
                                     "17": "Seventeen",
                                     "18": "Eighteen",
                                     "19": "Nineteen",
                                     "20": "Twenty",
                                     "21": "Twenty one",
                                     "22": "Twenty two",
                                     "23": "Twenty Three",
                                     "24": "Twenty four",
                                     "25": "Twenty five",
                                     "26": "Twenty six",
                                     "27": "Twenty seven",
                                     "28": "Twenty eight",
                                     "29": "Twenty nine",
                                     "30": "Thirty",
                                     "31": "Thirty one"]
        
        var result = ""
        var month: Int = 0
        var day: Int = 0
        
        var mah = ""
        var rooz = ""
        
        if self > 30{
            month = self / 30
            day = self % 30
        }else{
            day = self
        }
        
        if month > 0 && month < 10{
            mah = String(month).replace(replaceNumberString01)
        }else if month > 9{
            mah = String(month).replace(replaceNumberString02)
        }
        
        if day > 0 && day < 10{
            rooz = String(day).replace(replaceNumberString01)
        }else if day > 9{
            rooz = String(day).replace(replaceNumberString02)
        }
        
        
        if mah != ""{
            if rooz != ""{
                result = mah + " month & " + rooz + "days"
            }else{
                result = mah + " months "
            }
        }else{
            result = rooz + " days"
        }
        return result
    }
    
    var persianPeriodString: String{
        let replaceNumberString01 =
            ["0": "",
             "1": "یک",
             "2": "دو",
             "3": "سه",
             "4": "چهار",
             "5": "پنچ",
             "6": "شش",
             "7": "هفت",
             "8": "هشت",
             "9": "نه",]
        let replaceNumberString02 = ["10": "ده",
                                     "11": "یازده",
                                     "12": "دوازده",
                                     "13": "سیزده",
                                     "14": "چهارده",
                                     "15": "پانزده",
                                     "16": "شانزده",
                                     "17": "هفده",
                                     "18": "هجده",
                                     "19": "نوزده",
                                     "20": "بیست",
                                     "21": "بیست و یک",
                                     "22": "بیست و دو",
                                     "23": "بیست و سه",
                                     "24": "بیست و چهار",
                                     "25": "بیست و پنچ",
                                     "26": "بیست و شش",
                                     "27": "بیست و هفت",
                                     "28": "بیست و هشت",
                                     "29": "بیست و نه",
                                     "30": "سی",
                                     "31": "سی و یک"]
        
        var result = ""
        var month: Int = 0
        var day: Int = 0
        
        var mah = ""
        var rooz = ""
        
        if self > 30{
            month = self / 30
            day = self % 30
        }else{
            day = self
        }
        
        if month > 0 && month < 10{
            mah = String(month).replace(replaceNumberString01)
        }else if month > 9{
            mah = String(month).replace(replaceNumberString02)
        }
        
        if day > 0 && day < 10{
            rooz = String(day).replace(replaceNumberString01)
        }else if day > 9{
            rooz = String(day).replace(replaceNumberString02)
        }
        
        
        if mah != ""{
            if rooz != ""{
                result = mah + " ماه و " + rooz + " روزه"
            }else{
                result = mah + " ماهه "
            }
        }else{
            result = rooz + " روزه"
        }
        return result
    }
    
    var persianDateString: String{
        let replaceNumberString01 = ["0" : "",
                                     "1" : "یک",
                                     "2" : "دو",
                                     "3" : "سه",
                                     "4" : "چهار",
                                     "5" : "پنچ",
                                     "6" : "شش",
                                     "7" : "هفت",
                                     "8" : "هشت",
                                     "9" : "نه",]
        let replaceNumberString02 = ["10" : "ده",
                                     "11" : "یازده",
                                     "12" : "دوازده",
                                     "13" : "سیزده",
                                     "14" : "چهارده",
                                     "15" : "پانزده",
                                     "16" : "شانزده",
                                     "17" : "هفده",
                                     "18" : "هجده",
                                     "19" : "نوزده",
                                     "20" : "بیست",
                                     "21" : "بیست و یک",
                                     "22" : "بیست و دو",
                                     "23" : "بیست و سه",
                                     "24" : "بیست و چهار",
                                     "25" : "بیست و پنچ",
                                     "26" : "بیست و شش",
                                     "27" : "بیست و هفت",
                                     "28" : "بیست و هشت",
                                     "29" : "بیست و نه",
                                     "30": "سی",
                                     "31" : "سی و یک",
                                     "32" : "سی و دو",
                                     "33" : "سی و سه",
                                     "34" : "سی و چهار",
                                     "35" : "سی و پنج",
                                     "36" : "سی و شش",
                                     "37" : "سی و هفت",
                                     "38" : "سی و هشت",
                                     "39" : "سی و نه",
                                     "40" : "چهل",
                                     "41" : "چهل و یک",
                                     "42" : "چهل و دو",
                                     "43" : "چهل و سه",
                                     "44" : "چهل و چهار",
                                     "45" : "چهل و پنچ",
                                     "46" : "چهل و شش",
                                     "47" : "چهل و هفت",
                                     "48" : "چهل و هشت",
                                     "49" : "چهل و نه",
                                     "50" : "پنجاه",
                                     "51" : "پنجاه و یک",
                                     "52" : "پنجاه و دو",
                                     "53" : "پنجاه و سه",
                                     "54" : "پنجاه و چهار",
                                     "55" : "پنجاه و پنج",
                                     "56" : "پنجاه و شش",
                                     "57" : "پنجاه هفت",
                                     "58" : "پنجاه و هشت",
                                     "59" : "پنجاه و نه",
                                     "60" : "شصت",
                                     "61" : "شصت ‌و یک",
                                     "62" : "شصت و دو",
                                     "63" : "شصت و سه",
                                     "64" : "شصت و چهار",
                                     "65" : "شصت و پنج",
                                     "66" : "شصت و شش",
                                     "67" : "شصت و هفت",
                                     "68" : "شصت و هشت",
                                     "69" : "شصت و نه",
                                     "70" : "هفتاد",
                                     "71" : "هفتاد و یک",
                                     "72" : "هفتاد و دو",
                                     "73" : "هفتاد و سه",
                                     "74" : "هفتاد چهار",
                                     "75" : "هفتاد و پنچ",
                                     "76" : "هفتاد و شش",
                                     "77" : "هفتاد و هفت",
                                     "78" : "هفتاد و هشت",
                                     "79" : "هفتاد و نه",
                                     "80" : "هشتاد",
                                     "81":"هشتاد و یک",
                                     "82":"هشتاد و دو",
                                     "83":"هشتاد و سه",
                                     "84":"هشتاد و چهار",
                                     "85":"هشتاد و پنج",
                                     "86":"هشتاد و شش",
                                     "87": "هشتاد و هفت",
                                     "88": "هشتاد و هشت",
                                     "89": "هشتاد و نه",
                                     "90" : "نود",
                                     "91" : "نود و یک",
                                     "92" : "نود و دو",
                                     "93" : "نود و سه",
                                     "94" : "نود و چهار",
                                     "95" : "نود و پنج",
                                     "96" : "نود و شش",
                                     "97" : "نود و هفت",
                                     "98" : "نود و هشت",
                                     "99" : "نود و نه",
                                     "100" : "صد"]
        
        var result = ""
        var year: Int = 0
        var leftOFYear: Int = 0
        var month: Int = 0
        var day: Int = 0
        
        var sal = ""
        var mah = ""
        var rooz = ""
        
        if self > 365{
            year = self / 365
            leftOFYear = self % 365
            month = leftOFYear / 30
            day = leftOFYear % 30
        }else if self < 365 && self > 30{
            month = self / 30
            day = self % 30
        }else{
            day = self
        }
        
        if year > 0 && year < 10{
            sal = String(year).replace(replaceNumberString01)
        }else if year > 9{
            sal = String(year).replace(replaceNumberString02)
        }
        
        if month > 0 && month < 10{
            mah = String(month).replace(replaceNumberString01)
        }else if month > 9{
            mah = String(month).replace(replaceNumberString02)
        }
        
        if day > 0 && day < 10{
            rooz = String(day).replace(replaceNumberString01)
        }else if day > 9{
            rooz = String(day).replace(replaceNumberString02)
        }
        
        if sal != ""{
            if mah != ""{
                result = sal + " سال و " + mah + " ماه "
            }else{
                result = sal + " سال "
            }
        }else{
            if mah != ""{
                if rooz != ""{
                    result = mah + " ماه و " + rooz + " روز"
                }else{
                    result = mah +  " ماه "
                }
            }else{
                result = rooz + " روز"
            }
        }
        return result
    }
    
    var dateString: String{
        let replaceNumberString01 = ["0": "",
                                     "1": "One",
                                     "2": "Two",
                                     "3": "Three",
                                     "4": "Four",
                                     "5": "Five",
                                     "6": "Six",
                                     "7": "Seven",
                                     "8": "Eight",
                                     "9": "Nine"]
        
        let replaceNumberString02 = ["10": "Ten",
                                     "11": "Eleven",
                                     "12": "Twelve",
                                     "13": "Thirteen",
                                     "14": "Fourteen",
                                     "15": "Fifteen",
                                     "16": "Sixteen",
                                     "17": "Seventeen",
                                     "18": "Eighteen",
                                     "19": "Nineteen",
                                     "20": "Twenty",
                                     "21": "Twenty one",
                                     "22": "Twenty two",
                                     "23": "Twenty three",
                                     "24": "Twenty four",
                                     "25": "Twenty five",
                                     "26": "Twenty six",
                                     "27": "Twenty seven",
                                     "28": "Twenty eight",
                                     "29": "Twenty nine",
                                     "30": "Thirty",
                                     "31": "Thirty one",
                                     "32": "Thirty two",
                                     "33": "Thirty three",
                                     "34": "Thirty four",
                                     "35": "Thirty five",
                                     "36": "Thirty six",
                                     "37": "Thirty seven",
                                     "38": "Thirty eight",
                                     "39": "Thirty nine",
                                     "40": "Forty",
                                     "41": "Forty one",
                                     "42": "Forty two",
                                     "43": "Forty three",
                                     "44": "Forty four",
                                     "45": "Forty five",
                                     "46": "Forty six",
                                     "47": "Forty seven",
                                     "48": "Forty eight",
                                     "49": "Forty nine",
                                     "50": "Fifty",
                                     "51": "Fifty one",
                                     "52": "Fifty two",
                                     "53": "Fifty three",
                                     "54": "Fifty four",
                                     "55": "Fifty five",
                                     "56": "Fifty six",
                                     "57": "Fifty seven",
                                     "58": "Fifty eight",
                                     "59": "Fifty nine",
                                     "60": "Sixty",
                                     "61": "Sixty one",
                                     "62": "Sixty two",
                                     "63": "Sixty tree",
                                     "64": "Sixty four",
                                     "65": "Sixty five",
                                     "66": "Sixty six",
                                     "67": "Sixty seven",
                                     "68": "Sixty eight",
                                     "69": "Sixty nine",
                                     "70": "Seventy",
                                     "71": "Seventy one",
                                     "72": "Seventy two",
                                     "73": "Seventy three",
                                     "74": "Seventy four",
                                     "75": "Seventy five",
                                     "76": "Seventy six",
                                     "77": "Seventy seven",
                                     "78": "Seventy eight",
                                     "79": "Seventy nine",
                                     "80": "Eighty",
                                     "81": "Eighty one",
                                     "82": "Eighty two",
                                     "83": "Eighty three",
                                     "84": "Eighty four",
                                     "85": "Eighty five",
                                     "86": "Eighty six",
                                     "87": "Eighty seven",
                                     "88": "Eighty eight",
                                     "89": "Eighty nine",
                                     "90": "Ninety",
                                     "91": "Ninety one",
                                     "92": "Ninety two",
                                     "93": "Ninety three",
                                     "94": "Ninety four",
                                     "95": "Ninety five",
                                     "96": "Ninety six",
                                     "97": "Ninety seven",
                                     "98": "Ninety eight",
                                     "99": "Ninety nine",
                                     "100": "One hundred"]
        
        var result = ""
        var year: Int = 0
        var leftOFYear: Int = 0
        var month: Int = 0
        var day: Int = 0
        
        var sal = ""
        var mah = ""
        var rooz = ""
        
        if self > 365{
            year = self / 365
            leftOFYear = self % 365
            month = leftOFYear / 30
            day = leftOFYear % 30
        }else if self < 365 && self > 30{
            month = self / 30
            day = self % 30
        }else{
            day = self
        }
        
        if year > 0 && year < 10{
            sal = String(year).replace(replaceNumberString01)
        }else if year > 9{
            sal = String(year).replace(replaceNumberString02)
        }
        
        if month > 0 && month < 10{
            mah = String(month).replace(replaceNumberString01)
        }else if month > 9{
            mah = String(month).replace(replaceNumberString02)
        }
        
        if day > 0 && day < 10{
            rooz = String(day).replace(replaceNumberString01)
        }else if day > 9{
            rooz = String(day).replace(replaceNumberString02)
        }
        let m = month>1 ? "months" : "month"
        if sal != ""{
            let y = year>1 ? "years" : "year"
            
            if mah != ""{
                result = sal + " \(y) & " + mah + " \(m) "
            }else{
                result = sal + " \(y) "
            }
        }else{
            let d = day>1 ? "days" : "day"
            if mah != ""{
                if rooz != ""{
                    result = mah + " \(m) & " + rooz + " \(d)"
                }else{
                    result = mah +  " \(m) "
                }
            }else{
                result = rooz + " \(d)"
            }
        }
        return result
    }
    
    var string: String{
        return String(self)
    }
    
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
    
    var toCGFloat: CGFloat{
        return CGFloat(self)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    var string: String{
        return String(self)
    }
}

extension Float {
    var shortValue: String { String(format: "%.0f", self) }
    
    var int: Int{ Int(self.shortValue)! }
    
    var string: String{ String(self) }
}
