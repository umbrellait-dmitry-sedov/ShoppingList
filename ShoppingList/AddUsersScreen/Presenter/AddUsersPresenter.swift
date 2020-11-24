//
//  AddUsersPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 24.11.2020.
//

import Foundation
import Firebase

class AddUsersPresenter {
    
    let db = Firestore.firestore()
    
    weak var viewController: AddUserViewController?
    
    var users = [User]()

    init(viewController: AddUserViewController) {
        self.viewController = viewController
    }
    
    func fetchData(completion: @escaping () -> Void) {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if let documents = querySnapshot?.documents {
                for document in documents {
                    let user = User(firestoreData: document.data())
                    print(user)
                    self.addUsers(user: user)
                }
                completion()
            }
        }
    }
    
    func addUsers(user: User) {
        users.append(user)
    }
}
