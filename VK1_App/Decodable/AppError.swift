//
//  AppError.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.06.2021.
//

import Foundation


enum ServerError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectUrl
}
