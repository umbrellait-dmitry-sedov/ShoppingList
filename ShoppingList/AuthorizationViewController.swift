//
//  ViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 17.11.2020.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    var loginTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var registrationButton: UIButton!
    var stackView: UIStackView!
    
    var presenter: AuthorizationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthorizationPresenter(viewController: AuthorizationViewController())
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .orange
        
        title = "Authorization"
        
        loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "login, email or phone number"
        loginTextField.backgroundColor = .white
        loginTextField.layer.cornerRadius = 5
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 5
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        registrationButton = UIButton()
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle("Registration", for: .normal)
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        addSubviews()
        setupConstraints()
    }
    
    @objc func buttonAction() {
        self.presenter.logic()
    }
    
    func addSubviews() {
        self.stackView.addArrangedSubview(loginTextField)
        self.stackView.addArrangedSubview(passwordTextField)
        self.stackView.addArrangedSubview(loginButton)
        
        self.view.addSubview(stackView)
        self.view.addSubview(registrationButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.20),
            
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
 
        ])
    }
}

