//
//  User.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 24.11.2020.
//

import Foundation

struct User: Codable {
    
    var id: String
    
    var name: String
    
    var phoneNumber: String
    
    init(firestoreData: [String: Any]) {
        self.id = firestoreData["id"] as? String ?? ""
        self.name = firestoreData["name"] as? String ?? ""
        self.phoneNumber = firestoreData["phoneNumber"] as? String ?? ""
    }
    
    init(id: String, name: String, phoneNumber: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "phoneNumber": phoneNumber
        ]
    }
    
}
