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
    
    ///The method accepts the raw value of the index of the selected cell and opens the list of the saved cells.
    func openListBy(identifier: Int) {
        
    }
}



