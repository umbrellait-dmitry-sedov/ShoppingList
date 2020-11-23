//
//  ShoppingListsScreenCoordinator.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 20.11.2020.
//

import UIKit

final class Coordinator {
    
    private weak var navigationController: UINavigationController?
    private var window: UIWindow!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showStartScreen() {
        let vc = AuthorizationViewController()
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController = navigationController
        window.rootViewController = navigationController
    }
    
    func showShoppingListsScreen() {
        let vc = ShoppingListsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showListScreen(products: [Product]) {
        let presenter = ListPresenter(products: products)
        let vc = ListTableViewController(presenter: presenter)
        presenter.viewController = vc
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension Coordinator: AuthorizationViewControllerDelegate {
    func loginButtonPressed() {
        showShoppingListsScreen()
    }
}

extension Coordinator: ShoppingListsViewControllerDelegate {
    func showVC(products: [Product]) {
        showListScreen(products: products)
    }
}
