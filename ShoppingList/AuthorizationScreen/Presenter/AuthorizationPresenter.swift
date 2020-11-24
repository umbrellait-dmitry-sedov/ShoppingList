//
//  AuthorizationPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import Firebase

class AuthorizationPresenter {
    
    let db = Firestore.firestore()

    private weak var authorizatonView: AuthorizationViewController!
    private weak var verificationView: VerificationViewController!
    
    init(viewController: AuthorizationViewController) {
        self.authorizatonView = viewController
    }
    
    init(viewController: VerificationViewController) {
        self.verificationView = viewController
    }
    
    /// Получаем ID для подтверждения номера телефона
    public func getVerificationID(phoneNumber: String) {
        Auth.auth().useAppLanguage()
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber,
                                                       uiDelegate: nil) { verificationID, error in
            if error != nil {
                self.authorizatonView.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            self.db.collection("users").addDocument(data: [
                "id": "\(verificationID ?? "")",
                "name": self.authorizatonView.nameTextField.text ?? "",
                "phoneNumber": "\(phoneNumber)"
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: ")
                }
            }
            
            // Сохраняем его в UserDefaults для метода auth
            UserDefaults.standard.setValue(verificationID, forKey: "authVerificationID")
        }
    }
    
    /// Функция для входа в наше приложение
    public func auth(verificationCode: String) {
        /// ID нужен для создания кредов и входа по ним
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                //self.verificationView.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            else {
                /// Здесь уже юзер залогинился
                /// Алерт нужен для проверки, что пользователь авторизовался успешно
                //self.verificationView.showAlert(title: "Success", message: "YEAH")
                print(authResult.debugDescription)
            }
        }
    }
}
