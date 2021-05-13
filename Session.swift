//
//  Session.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation

class Session {
    static let instance = Session()
    
    var accessToken: String = ""
    var userId: String = ""
    
    private init() {}
        
    }

