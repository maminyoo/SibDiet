//
//  SequenceEX.swift
//  Sibdiet
//
//  Created by Amin on 2/24/20.
//  Copyright © 2020 maminyoo. All rights reserved.
//

extension Sequence{
    public func map2<T>(_ transform: (Element) throws -> T) rethrows -> [T]{
        var result = [T]()
        for item in self {
            result.append(try transform(item))
        }
        return result
    }
    public func compactMap2<T>(_ transform: (Element) throws -> T?) rethrows -> [T]{
        var result = [T]()
        for item in self {
            if let transformed = try transform(item){
                result.append(transformed)
            }
        }
        return result
    }
    public func flatMap2<T: Sequence>(_ transform: (Element) throws -> T) rethrows -> [T.Element]{
        var result = [T.Element]()
        for elemet in self {
            result += try transform(elemet)
        }
        return result
    }
}

extension Sequence where Element: Equatable{
    func contains2(_ item: Element) -> Bool{
        for element in self{ if element == item { return true } }
        return false
    }
}
