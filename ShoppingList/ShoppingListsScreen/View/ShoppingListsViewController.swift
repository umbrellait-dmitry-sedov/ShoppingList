//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import UIKit

class ShoppingListsViewController: UICollectionViewController {
    
    var presenter: ShoppingListsPresenter!
    
    let itemsPerRow: CGFloat = 3
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
        
        let imageFromAddButton = UIImage(systemName: "plus.square.on.square.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageFromAddButton, style: .plain, target: self, action: #selector(addListButtonAction))
    }
    
    @objc func addListButtonAction() {
        let ac = UIAlertController(title: nil, message: "Please enter the name of the list", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] action in
            guard let name = ac.textFields?[0].text else { return }
            self?.presenter.shoppingLists.append(ShoppingList(name: name, goods: [nil]))
            self?.collectionView.reloadData()
        }))
        present(ac, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.shoppingLists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ShoppingListsCell
        
        let list = presenter.shoppingLists[indexPath.item]

        cell.label.text = list.name
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension ShoppingListsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth: CGFloat = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
