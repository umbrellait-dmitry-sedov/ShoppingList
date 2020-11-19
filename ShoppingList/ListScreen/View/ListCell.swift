//
//  ListCell.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import UIKit

class ListCell: UITableViewCell {
    var itemLabel: UILabel!
    var completedButton: RadioButton!
    var priceTextField: UITextField!
    var completed: Bool! {
        didSet {
            completedButton.completed = completed
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemLabel = UILabel()
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.textAlignment = .left
        
        priceTextField = UITextField()
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.textAlignment = .right
        
        completedButton = RadioButton()
        completedButton.translatesAutoresizingMaskIntoConstraints = false
        completedButton.addTarget(self, action: #selector(completedButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(itemLabel)
        contentView.addSubview(priceTextField)
        contentView.addSubview(completedButton)
        
        NSLayoutConstraint.activate([
            
            itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            priceTextField.trailingAnchor.constraint(equalTo: completedButton.leadingAnchor, constant: -20),
            priceTextField.topAnchor.constraint(equalTo: self.topAnchor),
            priceTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            completedButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            completedButton.topAnchor.constraint(equalTo: self.topAnchor),
            completedButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
 
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///The method is triggered by pressing the button on the purchase line and switching the colour of the button.
    @objc func completedButtonTapped() {
        completed.toggle()
    }
    
}
