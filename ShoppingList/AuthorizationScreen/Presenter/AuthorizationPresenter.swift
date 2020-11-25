//
//  AuthorizationPresenter.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 18.11.2020.
//

import Firebase

class AuthorizationPresenter {
    
    typealias GetVerificationIDSuccess = (String, String)
    
    let db = Firestore.firestore()

    private weak var authorizatonView: AuthorizationViewController?
    
    init(viewController: AuthorizationViewController) {
        self.authorizatonView = viewController
    }
    
    /// Получаем ID для подтверждения номера телефона
    func getVerificationID(phoneNumber: String, completion: @escaping (Result<GetVerificationIDSuccess, Error>) -> Void) {
        Auth.auth().useAppLanguage()
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let verificationId = verificationID {
                completion(.success((phoneNumber, verificationId)))
            }
        }
    }
    
}
