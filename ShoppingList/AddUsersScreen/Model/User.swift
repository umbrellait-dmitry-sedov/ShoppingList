//
//  User.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 24.11.2020.
//

import Foundation

struct User {
    
    var id: String
    
    var name: String
    
    var phoneNumber: String
    
    init(firestoreData: [String: Any]) {
        self.id = firestoreData["id"] as? String ?? ""
        self.name = firestoreData["name"] as? String ?? ""
        self.phoneNumber = firestoreData["phoneNumber"] as? String ?? ""
    }
    
}
