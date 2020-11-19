//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var listPresenter: ListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listPresenter = ListPresenter(viewController: ListTableViewController())
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .addImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addListButtonAction))

        tableView.register(ListCell.self, forCellReuseIdentifier: "tableCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPresenter.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ListCell
        
        let list = listPresenter.lists[indexPath.row]
        cell.itemLabel.text = list.item
        cell.completed = list.completed
        cell.priceTextField.text = list.price
        
        return cell
    }
    
    @objc func addListButtonAction() {
        let ac = UIAlertController(title: nil, message: "Please enter the name of your purchase", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] action in
            guard let name = ac.textFields?[0].text else { return }
            self?.listPresenter.lists.append(List(item: name, completed: true, price: "")) // In Presenter
            self?.tableView.reloadData()
        }))
        present(ac, animated: true)
    }
}

extension UIImage {
    static let addImage = UIImage(systemName: "plus.square.on.square.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
}
