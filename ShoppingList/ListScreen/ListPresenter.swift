//
//  ListPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import Foundation

class ListPresenter {
    
    weak var viewController: ListTableViewController?
    
    var products = [Product]()

    init(products: [Product]) {
        self.products = products
    }
    
    func addList(_ product: Product) {
        products.append(product)
    }
    
    func editlist(_ product: Product, at index: Int) {
        products[index] = product
    }
}
