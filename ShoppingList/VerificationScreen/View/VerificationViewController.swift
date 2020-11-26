//
//  VerificationScreen.swift
//  ShoppingList
//
//  Created by Rezvantsev Viktor on 20.11.2020.
//

import UIKit

protocol VerificationViewControllerDelegate: class {
    func showShoppingListVC()
}

class VerificationViewController: UIViewController {
    
    lazy var codeTextField: UITextField = {
        let codeTextField = UITextField()
        codeTextField.translatesAutoresizingMaskIntoConstraints = false
        codeTextField.placeholder = "Enter the verification code"
        codeTextField.backgroundColor = .white
        codeTextField.layer.cornerRadius = 5
        codeTextField.textColor = UIColor.black
        return codeTextField
    }()
    lazy var continueButton: UIButton = {
        let continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("VERIFY & CONTINUE", for: .normal)
        continueButton.backgroundColor = .red
        continueButton.layer.cornerRadius = 5
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        return continueButton
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    var presenter: VerificationPresenter?
    
    weak var delegate: VerificationViewControllerDelegate?
    
    private let authorizationData: AuthorizationData
    
    private var verificationCode: String {
        return codeTextField.text ?? ""
    }
    
    init(authorizationData: AuthorizationData) {
        self.authorizationData = authorizationData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = VerificationPresenter(viewController: self)
    }
    
    override func loadView() {
        super.loadView()
        title = "Authorization"
        
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Methods
    
    @objc func continueButtonPressed(sender: UIButton!) {
        presenter?.auth(with: authorizationData, verificationCode: verificationCode, completion: { [weak self] in
            self?.delegate?.showShoppingListVC()
        })
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertController, animated: true)
    }
}
