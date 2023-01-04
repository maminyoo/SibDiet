//
//  Supplements.swift
//  Sibdiet
//
//  Created by amin sadeghian on 12/2/17.
//  Copyright © 2017 maminyoo. All rights reserved.
//

import SwiftyJSON

class Supplements: NSObject, NSCoding{
    var title = String()
    var printTitle = String()
    var amount = String()
    var usage = String()
    var descriptions = String()
    
    init(title: String,
         printTitle: String,
         amount: String, usage: String,
         descriptions: String ) {
        self.title = title
        self.printTitle = printTitle
        self.amount = amount
        self.usage = usage
        self.descriptions = descriptions
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "titleS") as? String ?? String()
        printTitle = aDecoder.decodeObject(forKey: "printTitleS") as? String ?? String()
        amount = aDecoder.decodeObject(forKey: "amountS") as? String ?? String()
        usage = aDecoder.decodeObject(forKey: "usageS") as? String ?? String()
        descriptions = aDecoder.decodeObject(forKey: "descriptionsS") as? String ?? String()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "titleS")
        aCoder.encode(printTitle, forKey: "printTitleS")
        aCoder.encode(amount, forKey: "amountS")
        aCoder.encode(usage, forKey: "usageS")
        aCoder.encode(descriptions, forKey: "descriptionsS")
    }
}

extension Supplements{
    var printTitleCorrection: String{
        let int = printTitle.indexOf(char: "(")
        if printTitle != title{
            if int > 0{ return printTitle.substring(to: int) }
            else{ return printTitle }
        }else{ return "" }
    }
    
    var printTitleInParentheses: String{
        let int = printTitle.indexOf(char: "(")
        let count = printTitle.count
        if int > 0 { return printTitle.substring(from: int+1, to: count) }
        else{ return "" }
    }
    
    var amountCorrection: String{ amount.replace([NADARAD: ""]) }
}

