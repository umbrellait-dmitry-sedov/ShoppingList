import UIKit

protocol AuthorizationViewControllerDelegate: class {
    
    func didRecieveVerificationId(authorizationData: AuthorizationData)
    
}

class AuthorizationViewController: UIViewController {
    
    var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Enter the name"
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 5
        nameTextField.textColor = UIColor.black
        return nameTextField
    }()
    var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Enter the phone number"
        loginTextField.backgroundColor = .white
        loginTextField.layer.cornerRadius = 5
        loginTextField.textColor = UIColor.black
        return loginTextField
    }()
    var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return loginButton
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
    
    var presenter: AuthorizationPresenter?
    
    weak var delegate: AuthorizationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthorizationPresenter(viewController: self)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .orange
        
        title = "Authorization"

        addSubviews()
        setupConstraints()
    }
    
    @objc func loginButtonPressed(sender: UIButton!) {
        presenter?.getVerificationID(phoneNumber: loginTextField.text ?? "", completion: { [weak self] (result) in
            switch result {
            case let .success(data):
                let authorizationData = AuthorizationData(verificationId: data.1,
                                                          phoneNumber: data.0,
                                                          name: self?.nameTextField.text ?? "")
                self?.delegate?.didRecieveVerificationId(authorizationData: authorizationData)
                
            case let .failure(error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        })
    }
    
    func addSubviews() {
        self.stackView.addArrangedSubview(nameTextField)
        self.stackView.addArrangedSubview(loginTextField)
        self.stackView.addArrangedSubview(loginButton)
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
