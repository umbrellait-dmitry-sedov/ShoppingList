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
    
    func saveShoppingListToFirestore(with title: String, completion: @escaping () -> Void) {
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



