//
//VKNews.swift
//  VK1_App
//
//  Created by Анатолий Левин on 03.06.2021.
//

import Foundation

// MARK: - News
struct VKNews: Codable {
    var response: ResponseNews

    enum CodingKeys: String, CodingKey {
        case response = "response"
    }
}

// MARK: - Response
struct ResponseNews: Codable {
    var items: [Item]
    var profiles: [Profile]
    var groups: [GroupNews]
    var nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case profiles = "profiles"
        case groups = "groups"
        case nextFrom = "next_from"
    }
}

// MARK: - class Group
class GroupNews: Codable {
    var id: Int
    var name: String
    var screenName: String
    var isClosed: Int
    var type: String
    var isAdmin: Int
    var isMember: Int
    var isAdvertiser: Int
    var photo50: String
    var photo100: String
    var photo200: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type = "type"
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - class Item
class Item: Codable {
    var sourceid: Int
    var date: Int
    var canDoubtCategory: Bool
    var canSetCategory: Bool
    var postType: String
    var text: String
    var markedAsAds: Int?
    var postSource: ItemPostSource
    var comments: Comments
    var likes: Likes
    var reposts: Reposts
    var views: Views
    var isFavorite: Bool
    var donut: Donut
    var shortTextRate: Double
    var postid: Int
    var type: String
    var attachments: [ItemAttachment]?
    var copyHistory: [CopyHistory]?

    enum CodingKeys: String, CodingKey {
        case sourceid = "source_id"
        case date = "date"
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case postType = "post_type"
        case text = "text"
        case markedAsAds = "marked_as_ads"
        case postSource = "post_source"
        case comments = "comments"
        case likes = "likes"
        case reposts = "reposts"
        case views = "views"
        case isFavorite = "is_favorite"
        case donut = "donut"
        case shortTextRate = "short_text_rate"
        case postid = "post_id"
        case type = "type"
        case attachments = "attachments"
        case copyHistory = "copy_history"
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    var type: String
//    var video: PurpleVideo?
    var photo: PhotoNews?

    enum CodingKeys: String, CodingKey {
        case type = "type"
//        case video = "video"
        case photo = "photo"
    }
}

// MARK: - Link
//struct Link: Codable {
//    var url: String
//    var title: String
//    var caption: String?
//    var linkDescription: String
//    var photo: PhotoNews?
//    var isFavorite: Bool

//    enum CodingKeys: String, CodingKey {
//        case url = "url"
//        case title = "title"
//        case caption = "caption"
//        case linkDescription = "description"
//        case photo = "photo"
//        case isFavorite = "is_favorite"
//    }
//}

// MARK: - Photo
struct PhotoNews: Codable {
//    var albumid: Int
//    var date: Int
//    var id: Int
//    var ownerid: Int
//    var hasTags: Bool
    var sizes: [Size]
//    var text: String
//    var userid: Int

    enum CodingKeys: String, CodingKey {
//        case albumid = "album_id"
//        case date = "date"
//        case id = "id"
//        case ownerid = "owner_id"
//        case hasTags = "has_tags"
        case sizes = "sizes"
//        case text = "text"
//        case userid = "user_id"
    }
}

// MARK: - Size
struct Size: Codable {
//    var height: Int
    var url: String
//    var type: String
//    var width: Int

    enum CodingKeys: String, CodingKey {
//        case height = "height"
        case url = "url"
//        case type = "type"
//        case width = "width"
    }
}

// MARK: - PurpleVideo
struct PurpleVideo: Codable {
    var accessKey: String
    var canComment: Int
    var canLike: Int
    var canRepost: Int
    var canSubscribe: Int
    var canAddToFaves: Int
    var canAdd: Int
    var comments: Int
    var date: Int
    var videoDescription: String
    var duration: Int
    var image: [PurpleImage]
    var firstFrame: [PurpleFirstFrame]
    var width: Int
    var height: Int
    var id: Int
    var ownerid: Int
    var ovid: String?
    var title: String
    var isFavorite: Bool
    var trackCode: String
    var type: String
    var views: Int

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments = "comments"
        case date = "date"
        case videoDescription = "description"
        case duration = "duration"
        case image = "image"
        case firstFrame = "first_frame"
        case width = "width"
        case height = "height"
        case id = "id"
        case ownerid = "owner_id"
        case ovid = "ov_id"
        case title = "title"
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type = "type"
        case views = "views"
    }
}

// MARK: - PurpleFirstFrame
struct PurpleFirstFrame: Codable {
    var height: Int
    var url: String
    var width: Int

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
}

// MARK: - PurpleImage
struct PurpleImage: Codable {
    var height: Int
    var url: String
    var width: Int
    var withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
        case withPadding = "with_padding"
    }
}

// MARK: - Comments
struct Comments: Codable {
    var count: Int
    var canPost: Int
    var groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    var id: Int
    var ownerid: Int
    var fromid: Int
    var date: Int
    var postType: String
    var text: String
    var attachments: [CopyHistoryAttachment]
    var postSource: CopyHistoryPostSource

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerid = "owner_id"
        case fromid = "from_id"
        case date = "date"
        case postType = "post_type"
        case text = "text"
        case attachments = "attachments"
        case postSource = "post_source"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    var type: String
    var video: FluffyVideo

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case video = "video"
    }
}

// MARK: - FluffyVideo
struct FluffyVideo: Codable {
    var accessKey: String
    var canComment: Int
    var canLike: Int
    var canRepost: Int
    var canSubscribe: Int
    var canAddToFaves: Int
    var canAdd: Int
    var date: Int
    var videoDescription: String
    var duration: Int
    var image: [FluffyImage]
    var id: Int
    var ownerid: Int
    var title: String
    var isFavorite: Bool
    var trackCode: String
    var type: String
    var views: Int
    var platform: String?
    var comments: Int?
    var firstFrame: [FluffyFirstFrame]?
    var width: Int?
    var height: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case date = "date"
        case videoDescription = "description"
        case duration = "duration"
        case image = "image"
        case id = "id"
        case ownerid = "owner_id"
        case title = "title"
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type = "type"
        case views = "views"
        case platform = "platform"
        case comments = "comments"
        case firstFrame = "first_frame"
        case width = "width"
        case height = "height"
    }
}

// MARK: - FluffyFirstFrame
struct FluffyFirstFrame: Codable {
    var height: Int
    var url: String
    var width: Int

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
}

// MARK: - FluffyImage
struct FluffyImage: Codable {
    var height: Int
    var url: String
    var width: Int
    var withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
        case withPadding = "with_padding"
    }
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
    var type: String

    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}

// MARK: - Donut
struct Donut: Codable {
    var isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    var count: Int
    var userLikes: Int
    var canLike: Int
    var canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
    var type: String
    var platform: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case platform = "platform"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    var count: Int
    var userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    var count: Int

    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
}

// MARK: - class Profile
class Profile: Codable {
    var firstName: String
    var id: Int
    var lastName: String
    var canAccessClosed: Bool?
    var isClosed: Bool?
    var sex: Int
    var screenName: String?
    var photo50: String
    var photo100: String
    var onlineInfo: OnlineInfo
    var online: Int
    var deactivated: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex = "sex"
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online = "online"
        case deactivated = "deactivated"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    var visible: Bool
    var isOnline: Bool
    var isMobile: Bool
    var lastSeen: Int?
    var appid: Int?

    enum CodingKeys: String, CodingKey {
        case visible = "visible"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case appid = "app_id"
    }
}
