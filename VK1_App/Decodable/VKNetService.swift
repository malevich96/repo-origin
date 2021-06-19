//
//  VKNetService.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.06.2021.
//

import Foundation
import PromiseKit

class VKNetService {

    private var urlConstructor = URLComponents()
    private let constants = NetworkConstants()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!

    init() {
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }

    func  getAuthorizeRequest() -> URLRequest? {
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"

        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: constants.clientID),
            URLQueryItem(name: "scope", value: constants.scope),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]

        guard let url = urlConstructor.url else { return nil }
        let request = URLRequest(url: url)
        return request
    }

    //MARK: - News feed
    // Result use
    func getNews(onComplete: @escaping ([NewsModel]) -> Void, onError: @escaping (Error) -> Void) {
           urlConstructor.path = "/method/newsfeed.get"
           
           urlConstructor.queryItems = [
               URLQueryItem(name: "filters", value: "post"),
               URLQueryItem(name: "start_from", value: "next_from"),
               URLQueryItem(name: "count", value: "20"),
               URLQueryItem(name: "access_token", value: VKSession.instance.accessToken),
               URLQueryItem(name: "v", value: constants.versionAPI),
           ]
           let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
               
               if error != nil {
                   onError(ServerError.errorTask)
               }
               
               guard let data = data else {
                   onError(ServerError.noDataProvided)
                   return
               }
               guard let news = try? JSONDecoder().decode(Response<NewsModel>.self, from: data).response.items else {
                   onError(ServerError.failedToDecode)
                   return
               }
               DispatchQueue.main.async {
                   onComplete(news)
               }
           }
           task.resume()
           
       }
    
    func getNewsResult(completion: @escaping (Swift.Result<[NewsModel], ServerError>) -> Void) {

        // 1. Создаем URL для запроса
        urlConstructor.path = "/method/newsfeed.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "start_from", value: "next_from"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: VKSession.instance.accessToken),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]

        // 2. Создаем запрос
        let task = session.dataTask(with: urlConstructor.url!) {  (data, response, error) in

            // 3. Ловим ошибку
            if error != nil {
                completion(.failure(ServerError.errorTask))
            }
            // 4 Проверяем есть ли data
            guard let data = data else {
                completion(.failure(ServerError.noDataProvided))
                return
            }
            // 5 Парсим data
            guard var news = try? JSONDecoder().decode(ResponseNews.self, from: data).response.items else {
                completion(.failure(ServerError.failedToDecode))
                return
            }
            guard let profiles = try? JSONDecoder().decode(ResponseNews.self, from: data).response.profiles else {
                completion(.failure(ServerError.failedToDecode))
                print("Error profiles")
                return
            }
            guard let groups = try? JSONDecoder().decode(ResponseNews.self, from: data).response.groups else {
                completion(.failure(ServerError.failedToDecode))
                print("Error groups")
                return
            }

            // 6 Объединяю массивы
            
            for i in 0..<news.count {
               if news[i].sourceID < 0 {
                let group = groups.first(where: { $0.id == -news[i].sourceID })
                    news[i].avatarURL = group?.avatarURL
                    news[i].creatorName = group?.name
                } else {
                   let profile = profiles.first(where: { $0.id == news[i].sourceID })
                    news[i].avatarURL = profile?.avatarURL
                    news[i].creatorName = (profile?.firstName ?? "") + (profile?.lastName ?? "")
                }
            }

            DispatchQueue.main.async {
                completion(.success(news))
            }
        }
        DispatchQueue.global(qos: .utility).async {
        task.resume()
    }
}
    // 1. Создаем URL для запроса
    func getUrl() -> Promise<URL> {
        urlConstructor.path = "/method/newsfeed.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "start_from", value: "next_from"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: VKSession.instance.accessToken),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]

        return Promise  { resolver in
            guard let url = urlConstructor.url else {
                resolver.reject(ServerError.notCorrectUrl)
                return
            }
            resolver.fulfill(url)
        }
    }

    // 2. Создаем запрос получили данные
    func getData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) {  (data, response, error) in
                guard let data = data else {
                    resolver.reject(ServerError.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }

    // Парсим Данные
    func getParsedData(_ data: Data) -> Promise<ItemsNews> {
        return Promise  { resolver in
            do {
                let response = try JSONDecoder().decode(ResponseNews.self, from: data).response
                resolver.fulfill(response)
            } catch {
                resolver.reject(ServerError.failedToDecode)
            }
        }
    }

    func getNews(_ items: ItemsNews) -> Promise<[NewsModel]> {
        return Promise<[NewsModel]> { resolver in
            var news = items.items
            let groups = items.groups
            let profiles = items.profiles

            for i in 0..<news.count {
                if news[i].sourceID < 0 {
                    let group = groups.first(where: { $0.id == -news[i].sourceID })
                    news[i].avatarURL = group?.avatarURL
                    news[i].creatorName = group?.name
                } else {
                    let profile = profiles.first(where: { $0.id == news[i].sourceID })
                    news[i].avatarURL = profile?.avatarURL
                    news[i].creatorName = (profile?.firstName ?? "") + (profile?.lastName ?? "")
                }
            }
            resolver.fulfill(news)
        }
    }
}
