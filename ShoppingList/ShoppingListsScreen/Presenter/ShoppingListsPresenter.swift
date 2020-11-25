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
    ///Функция сохраняет документ с пустыми значения, присваивая только имя списка. Служит для создания нового списка.
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
    ///Функция переименовывает поле titile у обьекта shoppingList.
    func renameShoppingList(from cell: ShoppingListsCell, index: Int, newName: String, completion: @escaping () -> Void) {
        
        guard let title = cell.cellTitle.text else { return }
        
        let ref = db.collection("shoppingLists").document(title)

        // Set the "capital" field of the city 'DC'
        ref.updateData([
            "name": newName
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                self.shoppingLists[index].title = newName
                completion()
            }
        }
    }
    
    ///Функция удаляет документ полностью по его индексу и названию.
    func removeShoppingList(from cell: ShoppingListsCell, index: Int, completion: @escaping () -> Void) {
        
        guard let title = cell.cellTitle.text else { return }
        
        db.collection("shoppingLists").document(title).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.removeList(index: index)
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



