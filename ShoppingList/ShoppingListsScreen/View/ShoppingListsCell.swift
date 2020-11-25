//
//  ShoppingListsCell.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import UIKit

protocol ShoppingListsCellDelegate: class {
    func didTapEdit(_ cell: ShoppingListsCell)
}

class ShoppingListsCell: UICollectionViewCell {
    
    weak var delegate: ShoppingListsCellDelegate?
    
    lazy var cellTitle: UILabel = {
        let cellTitle = UILabel()
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.numberOfLines = 0
        cellTitle.textAlignment = .center
        return cellTitle
    }()
    lazy var editButton: UIButton = {
        let editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        editButton.setImage(.dots, for: .normal)
        return editButton
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellTitle.textColor = UIColor.white
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(cellTitle)
        contentView.addSubview(editButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            editButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.25),
            editButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25),
            editButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            cellTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cellTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            cellTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
 
        ])
    }
    
    @objc private func editButtonPressed() {
        delegate?.didTapEdit(self)
    }
}

