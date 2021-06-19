//
//  VKPhoto.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation
import RealmSwift


struct VKPhotoRequestResponse: Codable {
    let response: VKPhotoResponse
}

struct VKPhotoResponse: Codable {
    let items: [VKPhoto]
}


class VKPhoto: Object, Codable {
     override var description: String {
         return String(format: "%ld (%@)", photoId, url)
     }

     @objc dynamic var photoId: Int
     @objc dynamic var url: String
 }

extension VKPhoto {
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case url = "photo_604"
    }
}
