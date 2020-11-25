//
//  UIImage+.swift
//  ShoppingList
//
//  Created by Fedor Prokhorov on 20.11.2020.
//

import UIKit

extension UIImage {
    
    static let addImage = UIImage(systemName: "plus.square.on.square.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    static let humanAddImage = UIImage(systemName: "person.badge.plus.fill",
                                       withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
}
