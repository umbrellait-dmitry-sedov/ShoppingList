//
//  VerificationScreen.swift
//  ShoppingList
//
//  Created by Rezvantsev Viktor on 20.11.2020.
//

import UIKit

class VerificationScreenController: UIViewController {
    
    var codeTextField: UITextField!
    var continueButton: UIButton!
    var stackView: UIStackView!
    
    var presenter: AuthorizationPresenter?		
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AuthorizationPresenter(self)
        
    }
    
    override func loadView() {
        super.loadView()
        title = "Authorization"
        
        view.backgroundColor = .white
        
        codeTextField = UITextField()
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.placeholder = "Enter the verification code"
        codeTextField.backgroundColor = .white
        codeTextField.layer.cornerRadius = 5
        codeTextField.textColor = UIColor.black
        
        continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("VERIFY & CONTINUE", for: .normal)
        continueButton.backgroundColor = .red
        continueButton.layer.cornerRadius = 5
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        addSubviews()
        setupConstraints()
    }
    
    @objc func continueButtonPressed(sender: UIButton!) {
        self.presenter?.auth(verificationCode: codeTextField.text ?? "")
    }
    
    func addSubviews() {
        self.stackView.addArrangedSubview(codeTextField)
        self.stackView.addArrangedSubview(continueButton)
        self.view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.20)
            
        ])
    }

}

extension VerificationScreenController: AuthorizationView {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
