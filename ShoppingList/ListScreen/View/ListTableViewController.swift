//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let presenter: ListPresenter
    
    init(presenter: ListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .addImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addListButtonAction))

        tableView.register(ListCell.self, forCellReuseIdentifier: "tableCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ListCell
        let product = presenter.products[indexPath.row]
        cell.delegate = self
        cell.setProduct(product)
        return cell
    }
    
    @objc func addListButtonAction() {
        let ac = UIAlertController(title: nil, message: "Please enter the name of your purchase", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] action in
            guard let name = ac.textFields?[0].text else { return }
            self?.presenter.addProduct(Product(item: name, completed: false, price: ""))
            self?.tableView.reloadData()
        }))
        present(ac, animated: true)
    }
}

extension ListTableViewController: ListCellDelegate {
    
    func cellDidChangePrice(_ cell: ListCell, product: Product) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        presenter.editlist(product, at: indexPath.row)
    }
    
}
