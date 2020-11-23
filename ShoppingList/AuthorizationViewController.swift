//
//  ViewController.swift
//  ShoppingList
//
//  Created by Dmitry Sedov on 17.11.2020.
//

import UIKit

protocol AuthorizationViewControllerDelegate: class {
    func loginButtonPressed()
}

class AuthorizationViewController: UIViewController {
    
    weak var delegate: AuthorizationViewControllerDelegate?
    
    lazy var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "login, email or phone number"
        loginTextField.backgroundColor = .white
        loginTextField.layer.cornerRadius = 5
        return loginTextField
    }()
    var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 5
        return passwordTextField
    }()
    var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return loginButton
    }()
    var registrationButton: UIButton = {
        let registrationButton = UIButton()
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.setTitle("Registration", for: .normal)
        return registrationButton
    }()
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    var presenter: AuthorizationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthorizationPresenter(viewController: AuthorizationViewController())
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .orange
        title = "Authorization"
        
        addSubviews()
        setupConstraints()
    }
    
    @objc func loginButtonPressed() {
        delegate?.loginButtonPressed()
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

