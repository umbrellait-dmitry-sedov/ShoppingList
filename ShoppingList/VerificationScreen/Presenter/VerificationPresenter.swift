//
//  VerificationPresenter.swift
//  ShoppingList
//
//  Created by Fedor Prokhorov on 24.11.2020.
//

import Firebase

final class VerificationPresenter {
    
    let db = Firestore.firestore()
    
    private weak var viewController: VerificationViewController?
    
    init(viewController: VerificationViewController) {
        self.viewController = viewController
    }
    
    /// Функция для входа в наше приложение
    func auth(with authorizationData: AuthorizationData, verificationCode: String, completion: @escaping () -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: authorizationData.verificationId, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            //1. Получаем пользователя из firebase
            if let firebaseUser = authResult?.user {
                //2. Локально создаем модель пользоваетеля
                let user = User(id: firebaseUser.uid,
                                name: authorizationData.name,
                                phoneNumber: authorizationData.phoneNumber)
                //3. Создаем запись в firebase в коллекции users
                self.db.collection("users").document(user.id).setData(user.asDictionary) { (error) in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        //4. Сохраняем в локальное хранилище User'а
                        UserDefaultsService.shared.setValue(user, forKey: UserDefaultsService.shared.userKey)
                        completion()
                    }
                }
            }
        }
    }
    
}
