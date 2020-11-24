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
}
