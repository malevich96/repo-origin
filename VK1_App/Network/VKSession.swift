//
//  VKSession.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//


import Foundation

class VKSession {
    static let instance = VKSession()
    
    var accessToken: String = ""
    var userId: String = ""
    
    private init() {}
    
    func toDictionary() -> [String: Any] {
        return [
            "accessToken": accessToken,
            "userId": userId
        ]
    }
}

