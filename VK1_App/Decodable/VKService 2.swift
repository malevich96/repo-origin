//
//  VKService.swift
//  VK1_App
//
//  Created by Анатолий Левин on 29.04.2021.
//

import Foundation
import Alamofire
import AlamofireImage
import RealmSwift

class VKService {
    static let instance = VKService()
    

    
    private let baseUrl = "https://api.vk.com/method/"
    private let apiVersion = "5.68"
    private let accessToken = VKSession.instance.accessToken
    private lazy var commonParameters = [
        "access_token" : accessToken,
        "v" : apiVersion
    ]
    
    private init() {}
    
    func loadFriends(handler: @escaping (Result<[VKUser], Error>) -> Void) {
        let apiMethod = "friends.get"
        let apiEnpoint = baseUrl + apiMethod
        let requestParameters =  [
            "access_token" : accessToken,
            "v" : apiVersion,
            "fields": "photo_200_orig, online"
        ]
        AF.request(apiEnpoint,method: .get, parameters: requestParameters)
            .validate()
            .responseData(completionHandler: { responseData in
                guard let data = responseData.data else {
                    if let error = responseData.error {
                        handler(.failure(error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let requestResponse = try decoder.decode(VKUserRequestResponse.self,from: data)
                    RealmService.instance.deleteObjects(VKUser.self)
                    RealmService.instance.saveObjects(requestResponse.response.items)
                    handler(.success(requestResponse.response.items))
                } catch {
                    handler(.failure(error))
                }
            })
    }
    

    func loadPhotos(userId: Int,
                    handler: @escaping (Result<[VKPhoto], Error>) -> Void)  {
        let apiMethod = "photos.getAll"
        let apiEndpoint = baseUrl + apiMethod
        var requestParameters =  [
            "access_token" : accessToken,
            "v" : apiVersion,
            "owner_id": Int(userId),
            "extended": "1",
            "photo_sizes": "0",
            "count": "60"
        ] as [String : Any]
        requestParameters["v"] = "5.68"
        
        AF.request(apiEndpoint,method: .get, parameters: requestParameters)
            .validate()
            .responseData(completionHandler: { responseData in
                guard let data = responseData.data else {
                    if let error = responseData.error {
                        handler(.failure(error))
                    }
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let requestResponse = try decoder.decode(VKPhotoRequestResponse.self,from: data)
                    RealmService.instance.deleteObjects(VKPhoto.self)
                    RealmService.instance.saveObjects(requestResponse.response.items)
                    handler(.success(requestResponse.response.items))
                } catch {
                    handler(.failure(error))
                }
            })
    }
    
    func loadGroups(handler: @escaping (Result<[VKGroup], Error>) -> Void) {
        let apiMethod = "groups.get"
        let apiEndpoint = baseUrl + apiMethod
        let requestParameters = [
            "access_token" : accessToken,
            "v" : apiVersion,
            "extended": "1",
            "fields": "photo_200",
            "user_id": 196239020,
        ] as [String : Any]
        
        AF.request(apiEndpoint,method: .get, parameters: requestParameters)
            .validate()
            .responseData( completionHandler: { responseData in
                guard let data = responseData.data else {
                    if let error = responseData.error {
                        handler(.failure(error))
                    }
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let requestResponse = try decoder.decode(GroupsResponce.self,from: data)
                    RealmService.instance.deleteObjects(VKGroup.self)
                    RealmService.instance.saveObjects(requestResponse.response.items)
                    handler(.success(requestResponse.response.items))
                } catch {
                    handler(.failure(error))
                }
            })
    } 
    
    func searchGroups(searchQuery: String,
                      handler: @escaping (Result<[VKGroup], Error>) -> Void) {
        let apiMethod = "groups.search"
        let apiEndpoint = baseUrl + apiMethod
        let requestParameters = [
            "access_token" : accessToken,
            "v" : apiVersion,
            "q": searchQuery
        ]
        AF.request(apiEndpoint,
                   method: .get,
                   parameters: requestParameters)
            .validate()
            .responseData(completionHandler: { responseData in
                         guard let data = responseData.data else {
                           //  handler(.failure(VKAPIError.error("Data error")))
                             return
                         }
                         let decoder = JSONDecoder()
                         do {
                             let requestResponse = try
                                 decoder.decode(GroupsResponce.self, from: data)
                             handler(.success(requestResponse.response.items))
                         } catch {
                             handler(.failure(error))
                }
            })
        }
    }
