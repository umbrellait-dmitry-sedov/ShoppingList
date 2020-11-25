//
//  ShippingListsModel.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import Foundation

struct ShoppingList {
    
    let id: String
    
    var title: String
    
    let products: [Product]
    
    let users: [String]
    
    var asDictionary: [String: Any] {
        return [
            "id": id,
            "name": title,
            "products": products,
            "users": users
        ]
    }
    
}

