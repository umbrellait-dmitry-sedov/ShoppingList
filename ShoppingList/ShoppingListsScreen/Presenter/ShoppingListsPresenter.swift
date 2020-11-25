//
//  ShoppingListPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import Foundation
import Firebase

class ShoppingListsPresenter {
    weak var viewController: ShoppingListsViewController?
    
    var shoppingLists = [ShoppingList]()

    init(viewController: ShoppingListsViewController) {
        self.viewController = viewController
        
    }
    
    func addList(_ list: ShoppingList) {
        shoppingLists.append(list)
    }
    
    func logOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaultsService.shared.removeValue(forKey: UserDefaultsService.shared.userKey)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
}



