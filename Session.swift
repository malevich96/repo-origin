//
//  Session.swift
//  VK1_App
//
//  Created by Анатолий Левин on 21.04.2021.
//

import Foundation

 final class Session {
   static let shared = Session()
    
   var token = ""
   var userId = Int()
    
    private init() {
        
    }
}
