import UIKit
import Firebase

class SignupVC: UIViewController {

    // MARK: Properties
    var viewModel: SignupVM!
    
    
    static func create(viewModel: SignupVM) -> SignupVC {
        let viewController = SignupVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    let plusPhotoButton = IGButton(backgroundColor: .white, title: "", image: #imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal))
    let emailTextField = IGTextField(placeholder: "Email")
    let usernameTextField = IGTextField(placeholder: "Username")
    let passwordTextField = IGTextField(placeholder: "Password", isSecureTextEntry: true)
    let signupButton = IGButton(backgroundColor: UIColor.appColor(.lightBlue), title: "Sign Up", isEnabled: false)
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configurePlusPhotoButton()
        configureTextFields()
    }
}

// MARK: - Methods
extension SignupVC {
    
    @objc fileprivate func handleInput() {
        
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
            usernameTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.appColor(.blue)
        } else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.appColor(.lightBlue)
        }
    }
    
    @objc fileprivate func handleSignUp() {
        
        guard let email = emailTextField.text, !email.isEmpty,
            let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else { return }
        
        signInWith(email: email, password: password)
    }
    
    
    fileprivate func signInWith(email: String, password: String) {
        
        viewModel.signInWith(email: email, password: password) { status in
            if status {
                // User signed in
            } else {
                // Error signed in
            }
        }
    }
    
    
    fileprivate func configureViewController() { view.backgroundColor = .white }
    
    
    fileprivate func configureTextFields() {
        
        view.addSubviews(emailTextField, usernameTextField, passwordTextField)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubviews(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerX: nil, centerY: nil, paddingTop: 20, paddingLeading: 40, paddingBottom: 0, paddingTrailing: 40, paddingCenterX: 0, paddingCenterY: 0, width: 0, height: 200)
        
        emailTextField.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleInput), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleInput), for: .editingChanged)
    }
    
    
    fileprivate func configurePlusPhotoButton() {
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, paddingCenterX: 0, paddingCenterY: 0, width: 140, height: 140)
        signupButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
}
