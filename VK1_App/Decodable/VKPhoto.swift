//
//  VKPhoto.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation
<<<<<<< Updated upstream
=======
import RealmSwift
>>>>>>> Stashed changes


struct VKPhotoRequestResponse: Codable {
    let response: VKPhotoResponse
}

struct VKPhotoResponse: Codable {
    let items: [VKPhoto]
}

<<<<<<< Updated upstream
struct VKPhoto: Codable {
    var photoId: Int
    var url: String
}

extension VKPhoto: CustomStringConvertible {
    var description: String {
        return String(format: "%id (%@)", photoId, url)
   }
=======
class VKPhoto: Object, Codable {
 override var description: String {
        return String(format: "%id (%@)", photoId, url)
   }
    @objc dynamic var photoId: Int
    @objc dynamic var url: String
>>>>>>> Stashed changes
}

extension VKPhoto {
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case url = "photo_604"
    }
}
