//
//  User.swift
//  VK1_App
//
//  Created by Анатолий Левин on 31.03.2021.
//

import Foundation

enum LifeStatus {
    case working
}

class User {
    var name: String
    var age: Int
    var avatarImageName: String
    var imageView: [String]
    
    init(name: String,
         age: Int,
         numberOfFollowers: Int,
         avatarImageName: String,
         imageView: [String] = [String]()) {
        self.name = name
        self.age = age
        self.imageView = imageView
        self.avatarImageName = avatarImageName
   }
}
