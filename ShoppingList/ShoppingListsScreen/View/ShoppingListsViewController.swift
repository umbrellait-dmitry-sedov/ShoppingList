//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import UIKit

class ShoppingListsViewController: UICollectionViewController {
    
    var shoppingListPresenter: ShoppingListsPresenter!
    
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingListPresenter = ShoppingListsPresenter(viewController: ShoppingListsViewController())
        
        title = "Shopping Lists"
        
        collectionView?.register(ShoppingListsCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView?.delegate = self
        collectionView?.backgroundColor = .orange
    }
    
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .addImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addListButtonAction))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingListPresenter.shoppingLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ShoppingListsCell
        
        let list = shoppingListPresenter.shoppingLists[indexPath.item]

        cell.label.text = list.name
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 10
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let products = shoppingListPresenter.shoppingLists[indexPath.row].products
        
        let presenter = ListPresenter(products: products)
        let vc = ListTableViewController(presenter: presenter)
        presenter.viewController = vc
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addListButtonAction() {
        let ac = UIAlertController(title: nil, message: "Please enter the name of the list", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] action in
            guard let name = ac.textFields?[0].text else { return }
            self?.shoppingListPresenter.shoppingLists.append(ShoppingList(name: name, products: []))
            self?.collectionView.reloadData()
        }))
        present(ac, animated: true)
    }
    
}
