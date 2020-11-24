//
//  AddUsersViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 24.11.2020.
//

import UIKit
import Firebase

class AddUserViewController: UITableViewController {
    
    var presenter: AddUsersPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = AddUsersPresenter(viewController: self)
        
        presenter.fetchData()

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
