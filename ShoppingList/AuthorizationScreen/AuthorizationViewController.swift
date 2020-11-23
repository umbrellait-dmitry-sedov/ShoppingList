import UIKit

protocol AuthorizationViewControllerDelegate: class {
    func loginButtonPressed()
}

class AuthorizationViewController: UIViewController {
    
    // MARK: - Properties
    
    var loginTextField: UITextField!
    var loginButton: UIButton!
    var stackView: UIStackView!
    var continueButton: UIButton!
    
    var presenter: AuthorizationPresenter?
    
    weak var delegate: AuthorizationViewControllerDelegate?
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AuthorizationPresenter(self)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .orange
        
        title = "Authorization"
        
        loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Enter the phone number"
        loginTextField.backgroundColor = .white
        loginTextField.layer.cornerRadius = 5
        loginTextField.textColor = UIColor.black
        
        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Methods
    
    @objc func loginButtonPressed(sender: UIButton!) {
        self.presenter?.getVerificationID(phoneNumber: loginTextField.text ?? "")
        delegate?.loginButtonPressed()
    }
    
    
    func addSubviews() {
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
    
}

// MARK: - Extensions

extension AuthorizationViewController: AuthorizationView {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true, completion: nil)
    }
}
