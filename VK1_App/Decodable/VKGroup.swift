//
//  VKGroup.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation
<<<<<<< Updated upstream

class GroupssResponce: Decodable {
    let response: Groups
}

class Groups: Decodable {
    let items: [VKGroup]
}

class VKGroup: Decodable {
    
    var id: Int = 0
    var name: String = ""
    var screenName: String = ""
    var avatar: String = ""
    var userCity = ""
    var typeGroup = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case screenName = "screen_name"
        case avatar = "photo_200"
        case id
        case countGroup
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.screenName = try values.decode(String.self, forKey: .screenName)
        self.id = try values.decode(Int.self, forKey: .id)
        self.avatar = try values.decode(String.self, forKey: .avatar)
    }
    
}


=======
import RealmSwift

class GroupsResponce: Codable {
    let response: Groups
}

class Groups: Codable {
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
>>>>>>> Stashed changes
