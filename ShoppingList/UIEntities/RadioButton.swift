//
//  RadioButton.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import UIKit

final class RadioButton: UIButton {
    
    private let imageForButtonCompleted = UIImage(systemName: "circle.fill",
                                                  withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    private let imageForButtonNotCompleted = UIImage(systemName: "circle",
                                                     withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
    
    var completed = false {
        didSet {
            setImage(completed == true ? imageForButtonCompleted : imageForButtonNotCompleted,
                                     for: .normal)
        }
    }
}
