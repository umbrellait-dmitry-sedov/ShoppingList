//
//  AddUsersViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 24.11.2020.
//

import UIKit
import Firebase

class AddUserViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var presenter: AddUsersPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        presenter = AddUsersPresenter(viewController: self)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        return cell
    }
}
