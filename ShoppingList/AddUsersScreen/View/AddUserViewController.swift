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
    var array = [String: Any]()
    
    var presenter: AddUsersPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    self.array = document.data()
                    let user = User(
                        id: self.array["name"] as? String ?? "",
                        name: self.array["phoneNumber"] as? String ?? "",
                        phoneNumber: self.array["id"] as? String ?? "")
                    print(user)
                    self.presenter.users.append(user)
                    
                }
                self.tableView.reloadData()
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
        
        cell.textLabel?.text = presenter.users[indexPath.row].name
        
        return cell
    }
}
