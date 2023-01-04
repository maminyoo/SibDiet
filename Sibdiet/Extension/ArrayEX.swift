//
//  ArrayEX.swift
//  Sibdiet
//
//  Created by Amin on 5/20/19.
//  Copyright © 2019 Application.Studio. All rights reserved.
//

import Foundation

extension Array{
    var enumerated: EnumeratedSequence<[Element]>{
        return enumerated()
    }
    var reversed: Array{
        return reversed()
    }
    var shuffled: Array{
        return shuffled()
    }
}
