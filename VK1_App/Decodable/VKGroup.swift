//
//  VKGroup.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation
import RealmSwift

class GroupssResponce: Decodable {
    let response: Groups
}

class Groups: Decodable {
    let items: [VKGroup]
}

class VKGroup: Object,Codable {
    override var description: String {
        return String(format: "%@ (%id)", groupName,groupId)
    }
    @objc dynamic var groupId: Int
    @objc dynamic var groupName: String
    @objc dynamic var avatarUrl: String
}

extension VKGroup {
    enum CodingKeys: String, CodingKey {
        case groupId = "id"
        case groupName = "name"
        case avatarUrl = "photo_200"
    }
}
