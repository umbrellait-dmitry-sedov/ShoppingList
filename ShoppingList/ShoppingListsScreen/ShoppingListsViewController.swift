//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import UIKit

class ShoppingListsViewController: UICollectionViewController {
    
    var addListButton: UIButton!
    
    var presenter: ShoppingListsPresenter!
    
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ShoppingListsPresenter(viewController: ShoppingListsViewController())
        
        title = "Shopping Lists"
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView?.delegate = self
        collectionView?.backgroundColor = .orange
    }
    
    override func loadView() {
        super.loadView()
        
        addListButton = UIButton()
        addListButton.translatesAutoresizingMaskIntoConstraints = false
        addListButton.imageView?.image = UIImage(systemName: "plus.square.on.square.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        addListButton.addTarget(self, action: #selector(addListButtonAction), for: .touchUpInside)
        
        let imageFromAddButton = UIImage(systemName: "plus.square.on.square.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageFromAddButton, style: .plain, target: self, action: #selector(addListButtonAction))
        
    }
    
    @objc func addListButtonAction() {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath)
        
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
        sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}
