//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import UIKit

protocol ShoppingListsViewControllerDelegate: class {
    
    func showVC(products: [Product])
    
    func didLogOut()
    
}

class ShoppingListsViewController: UICollectionViewController {
    
    weak var delegate: ShoppingListsViewControllerDelegate?
    
    var presenter: ShoppingListsPresenter!
    
    let itemsPerRow: CGFloat = 3.0
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ShoppingListsPresenter(viewController: ShoppingListsViewController())
        
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
                                                             action: #selector(addListButtonPressed))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handleLeftItem))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.shoppingLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ShoppingListsCell
        
        let list = presenter.shoppingLists[indexPath.item]

        cell.label.text = list.title
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let products = presenter.shoppingLists[indexPath.row].products
        
        delegate?.showVC(products: products)
    }
    
    @objc private func addListButtonPressed() {
        let ac = UIAlertController(title: nil, message: "Please enter the name of the list", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] action in
            guard let title = ac.textFields?[0].text else { return }
            
            self?.presenter.saveShoppingListToFirestore(with: title) {
                self?.collectionView.reloadData()
            }
            
        }))
        present(ac, animated: true)
    }
    
    @objc private func handleLeftItem(_ item: UIBarButtonItem) {
        presenter.logOut { [weak self] (result) in
            switch result {
            case .success:
                self?.delegate?.didLogOut()
                
            case let .failure(error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
