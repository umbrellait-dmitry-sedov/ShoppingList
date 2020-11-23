//
//  AuthorizationPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import Firebase
import FirebaseAuth

class AuthorizationPresenter {
    
    // MARK: - Properties
    private let view: AuthorizationView
    
    // MARK: - Initialize
    init(_ view: AuthorizationView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    /// Получаем ID для подтверждения номера телефона
    public func getVerificationID(phoneNumber: String) {
        Auth.auth().useAppLanguage()
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber,
                                                       uiDelegate: nil) { verificationID, error in
            if error != nil {
                self.view.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            /// Сохраняем его в UserDefaults для метода auth
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
                self.view.showAlert(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            else {
                /// Здесь уже юзер залогинился
                /// Алерт нужен для проверки, что пользователь авторизовался успешно
                self.view.showAlert(title: "Success", message: "YEAH")
                print(authResult.debugDescription)
            }
            
        }
    }
    
}
