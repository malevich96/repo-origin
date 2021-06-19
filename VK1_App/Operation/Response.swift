//
//   Response.swift
//  VK1_App
//
//  Created by Анатолий Левин on 15.06.2021.
//

import Foundation

class Response<T: Codable>: Codable {
    let response: Items<T>

}

class Items<T: Codable>: Codable {
    let items: [T]
}

class ResponseJoin: Codable {
    let response: Int
}
