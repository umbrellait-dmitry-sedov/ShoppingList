//
//  ListCell.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import UIKit

protocol ListCellDelegate: class {
    func cellDidChangePrice(_ cell: ListCell, list: List)
}

class ListCell: UITableViewCell {
    
    weak var delegate: ListCellDelegate?
    
    var itemLabel: UILabel!
    var completedButton: RadioButton!
    var priceTextField: UITextField!
    var completed: Bool! {
        didSet {
            completedButton.completed = completed
        }
    }
    
    var listPresenter: ListPresenter!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemLabel = UILabel()
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.textAlignment = .left
        
        priceTextField = UITextField()
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.textAlignment = .right
        priceTextField.keyboardType = .numberPad
        priceTextField.placeholder = "Enter the price"
        addDoneButtonOnKeyboard()
        
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
    
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        priceTextField.inputAccessoryView = doneToolbar
    }
    ///This method is worked out when the price value is entered and the button is pressed.
    @objc func doneButtonAction(){
        delegate?.cellDidChangePrice(self, list: List(item: itemLabel.text, completed: completed, price: priceTextField.text))
        priceTextField.resignFirstResponder()
    }
    
    ///The method is triggered by pressing the button on the purchase line and switching the colour of the button.
    @objc func completedButtonTapped() {
        completed.toggle()
        delegate?.cellDidChangePrice(self, list: List(item: itemLabel.text, completed: completed, price: priceTextField.text))
    }
}
