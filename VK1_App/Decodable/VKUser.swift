//
//  VKUser.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation
<<<<<<< Updated upstream
=======
import RealmSwift
>>>>>>> Stashed changes

struct VKUserRequestResponse: Codable {
    let response: VKUserResponse
}

struct VKUserResponse: Codable {
    let items: [VKUser]
}

<<<<<<< Updated upstream
struct VKUser: Codable{
    var userId: Int
    var firstName: String
    var lastName: String
    var avatarUrl: String
    var isOnline: Int
}

extension VKUser: CustomStringConvertible {
    var description: String {
        return String(format: "%@ %@ (%id)", firstName, lastName, userId)
    }
=======
class VKUser: Object, Codable {
   override var description: String {
        return String(format: "%@ %@ (%id)", firstName, lastName, userId)
    }
    @objc dynamic var userId: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var avatarUrl: String
    @objc dynamic var isOnline: Int
>>>>>>> Stashed changes
}

extension VKUser {
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarUrl = "photo_200_orig"
        case isOnline = "online"
    }
}
