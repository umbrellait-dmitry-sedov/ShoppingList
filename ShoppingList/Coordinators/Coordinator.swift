//
//  ShoppingListsScreenCoordinator.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 20.11.2020.
//

import UIKit

final class Coordinator {
    
    private let navigationController = UINavigationController()
    private var window: UIWindow!
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
    }
    
    func start() {
        // Проверяем, авторизован ли пользователь
        if UserDefaultsService.shared.isValueExists(forKey: UserDefaultsService.shared.userKey) {
            showShoppingListsScreen()
        } else {
            showStartScreen()
        }
    }
    
    func showStartScreen() {
        let vc = AuthorizationViewController()
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showVerificationScreen(authorizationData: AuthorizationData) {
        let vc = VerificationViewController(authorizationData: authorizationData)
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showShoppingListsScreen() {
        let vc = ShoppingListsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showListScreen(products: [Product]) {
        let presenter = ListPresenter(products: products)
        let vc = ListTableViewController(presenter: presenter)
        vc.delegate = self
        presenter.viewController = vc
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAddUserScreen() {
        let vc = AddUserViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
}

// MARK: - AuthorizationViewControllerDelegate

extension Coordinator: AuthorizationViewControllerDelegate {
    
    func didRecieveVerificationId(authorizationData: AuthorizationData) {
        showVerificationScreen(authorizationData: authorizationData)
    }
    
}

// MARK: - ShoppingListsViewControllerDelegate

extension Coordinator: ShoppingListsViewControllerDelegate {
    
    func showVC(products: [Product]) {
        showListScreen(products: products)
    }
    
    func didLogOut() {
        start()
    }
    
}

// MARK: - VerificationViewControllerDelegate

extension Coordinator: VerificationViewControllerDelegate {
    func showShoppingListVC() {
        showShoppingListsScreen()
    }
}

// MARK: - ListTableViewControllerDelegate

extension Coordinator: ListTableViewControllerDelegate {
    func showAddUserVC() {
        showAddUserScreen()
    }
}
