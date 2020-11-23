//
//  AuthorizationPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import Firebase
import FirebaseAuth

class AuthorizationPresenter {
    
    private let view: AuthorizationView
    
    init(_ view: AuthorizationView) {
        self.view = view
    }
    
    public func getVerificationID(phoneNumber: String) {
        Auth.auth().useAppLanguage()
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber,
                                                       uiDelegate: nil) { verificationID, error in
            if error != nil {
                self.view.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            UserDefaults.standard.setValue(verificationID, forKey: "authVerificationID")
        }
    }
    
    public func auth(verificationCode: String) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                self.view.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            else {
                // User is signed in
                self.view.showAlert(title: "Success", message: "YEAH")
//                let shoppingListVC = ShoppingListsViewController()
//                navigationController?.pushViewController(shoppingListVC, animated: true)
            }
            
        }
    }
    
}
