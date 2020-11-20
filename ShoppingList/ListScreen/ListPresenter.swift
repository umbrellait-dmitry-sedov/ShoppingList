//
//  ListPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 19.11.2020.
//

import Foundation

class ListPresenter {
    weak var viewController: ListTableViewController!
    
    var lists = [List]()

    init(viewController: ListTableViewController) {
        self.viewController = viewController
    }
    
    func addList(_ list: List) {
        lists.append(list)
    }
    
    func editlist(_ list: List, indexPath: IndexPath) {
        lists[indexPath.row] = list
    }
}
