//
//  UserDefaultsService.swift
//  ShoppingList
//
//  Created by Fedor Prokhorov on 24.11.2020.
//

import Foundation

final class UserDefaultsService {
    
    private let defaults = UserDefaults.standard
    
    static let shared = UserDefaultsService()
    
    let userKey: UserDefaultsService.Key = UserDefaultsService.Key(name: "userKey", type: User.self)
    
    public func setValue<T: Codable>(_ object: T, forKey key: Key<T>) {
        let data = try? PropertyListEncoder().encode(object)
        defaults.set(data, forKey: key.name)
    }
    
    ///Issue an object by key and return the type T for further conversion to the desired type.
    public func getValue<T: Codable>(forKey key: Key<T>) -> T? {
        if let data = defaults.data(forKey: key.name) {
            let value = try? PropertyListDecoder().decode(key.type, from: data)
            return value
        } else {
            return nil
        }
    }
    
    ///Remove the object by key.
    public func removeValue<T: Codable>(forKey key: Key<T>) {
        defaults.removeObject(forKey: key.name)
    }
    
    /// If there is a value by key, it returns true
    public func isValueExists<T: Codable>(forKey key: Key<T>) -> Bool {
        return defaults.object(forKey: key.name) != nil ? true : false
    }
    
}

extension UserDefaultsService {
    
    public struct Key<T> {
        let name: String
        let type: T.Type
        
        init(name: String, type: T.Type) {
            if name.isValid() {
                self.name = name
            } else {
                fatalError("This name is not valid")
            }
            self.type = type
        }
    }
    
}

fileprivate extension String {
    ///Check for the presence of the symbol, if key is valid return true
    func isValid() -> Bool {
        let wrongSymbols = [" ", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", ":", ";"]
            for value in wrongSymbols {
                if self.contains(value) {
                    return false
                }
            }
        return true
    }
}
