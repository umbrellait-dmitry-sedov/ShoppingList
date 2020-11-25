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
    
    private let db = Firestore.firestore()

    init(viewController: ShoppingListsViewController) {
        self.viewController = viewController
    }
    
    func addList(_ list: ShoppingList) {
        shoppingLists.append(list)
    }
    
    func removeList(index: Int) {
        shoppingLists.remove(at: index)
    }
    
    func saveShoppingList(with title: String, completion: @escaping () -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let list = ShoppingList(id: UUID().uuidString, title: title, products: [], users: [userID])
        
        self.db.collection("shoppingLists").document(title).setData(list.asDictionary) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                self.addList(list)
                completion()
            }
        }
    }
    
    func removeShoppingList(from cell: ShoppingListsCell, index: Int) {
        
        guard let title = cell.cellTitle.text else { print("2"); return }
        
        db.collection("shoppingLists").document(title).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.removeList(index: index)
                print("cell delete")
            }
        }
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



