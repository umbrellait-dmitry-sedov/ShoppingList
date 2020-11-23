//
//  ShoppingListPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import Foundation

class ShoppingListsPresenter {
    weak var viewController: ShoppingListsViewController!
    
    var shoppingLists = [ShoppingList]()

    init(viewController: ShoppingListsViewController) {
        self.viewController = viewController
        
    }
    
    func addList(_ list: ShoppingList) {
        shoppingLists.append(list)
    }
}



