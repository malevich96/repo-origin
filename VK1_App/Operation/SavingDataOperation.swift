//
//  SavingDataOperation.swift
//  VK1_App
//
//  Created by Анатолий Левин on 15.06.2021.
//

import Foundation
import RealmSwift

class SavingDataOperation<T: Object & Codable>: Operation {
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
            let outputData = parseDataOperation.outputData else { return }
        
       do {
            let realm = try Realm()
        let oldValues = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldValues)
            realm.add(outputData)
            try realm.commitWrite()
            print("Completed Saving")
        } catch {
            print(error)
        }
    }
}
