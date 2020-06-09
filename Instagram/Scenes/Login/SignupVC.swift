import UIKit

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
    let signupButton = IGButton(backgroundColor: UIColor.appColor(.blue), title: "Sign Up")
    
    
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
    
    fileprivate func configureViewController() { view.backgroundColor = .white }
    
    
    fileprivate func configureTextFields() {
        
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerX: nil, centerY: nil, paddingTop: 20, paddingLeading: 40, paddingBottom: 0, paddingTrailing: 40, paddingCenterX: 0, paddingCenterY: 0, width: 0, height: 200)
    }
    
    
    fileprivate func configurePlusPhotoButton() {
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, paddingCenterX: 0, paddingCenterY: 0, width: 140, height: 140)
    }
}
