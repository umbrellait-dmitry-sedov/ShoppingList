//
//  SceneDelegate.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 17.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator!
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        //let vc = ListTableViewController(presenter: ListPresenter(products: []))
        //let navigationController = UINavigationController(rootViewController: vc)
        //window.rootViewController = navigationController
        
      
        coordinator = Coordinator(window: window)
        coordinator.showShoppingListsScreen()
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

