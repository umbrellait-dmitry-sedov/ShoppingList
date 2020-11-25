//
//  Product.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import Foundation

struct Product: Codable {
    
    var item: String?
    
    var completed: Bool
    
    var price: String?
    
}
