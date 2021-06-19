//
//  VKServiceApi.swift
//  VK1_App
//
//  Created by Анатолий Левин on 03.06.2021.



import Foundation
import RealmSwift

class VKServiseApi {
  
  let myDispatchGroup = DispatchGroup()
  

  //  MARK: - newsGet
  func newsGet(startTime: Int?, nextFrom: String?, completion: @escaping ([Item], [Profile], [GroupNews], String) -> Void) {
    
    
    let configuration = URLSessionConfiguration.default
    var urlConstructor = URLComponents()
    let session =  URLSession(configuration: configuration)
    urlConstructor.scheme = "https"
    urlConstructor.host = "api.vk.com"
    urlConstructor.path = "/method/newsfeed.get"
    urlConstructor.queryItems = [
      URLQueryItem(name: "access_token", value: "\(VKSession.instance.accessToken)"),
      URLQueryItem(name: "filters", value: "post,photo"),
      URLQueryItem(name: "start_time", value: ""),
      URLQueryItem(name: "start_from", value: nextFrom),
      URLQueryItem(name: "count", value: "5"),
      URLQueryItem(name: "v", value: "5.130")
    ]
    
    var request = URLRequest(url: urlConstructor.url!)
    request.httpMethod = "GET"
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
      
      guard let data = data else {return}
      DispatchQueue.global().async(group: self.myDispatchGroup) {
        
        do {
          
          let items = try JSONDecoder().decode(News.self, from: data).response.items
          let profile = try JSONDecoder().decode(News.self, from: data).response.profiles
          let group = try JSONDecoder().decode(News.self, from: data).response.groups
          let nextFrom = try JSONDecoder().decode(News.self, from: data).response.nextFrom
          
          self.myDispatchGroup.notify(queue: DispatchQueue.main){
            completion(items, profile, group, nextFrom)
          }
          
          
        } catch {
          print(error)
        }
        
      }
      
    })
    task.resume()
    myDispatchGroup.notify(queue: DispatchQueue.main){
      
    }
  }
}
