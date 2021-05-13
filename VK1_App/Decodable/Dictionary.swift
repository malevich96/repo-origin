//
//  Dictionary.swift
//  VK1_App
//
//  Created by Анатолий Левин on 02.05.2021.
//

import Foundation

func +<Key, Value> (lhs: [Key: Value],
                    rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}
