//
//  ServerError.swift
//  VK1_App
//
//  Created by Анатолий Левин on 31.05.2021.
//

import Foundation

enum ServerError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
}
