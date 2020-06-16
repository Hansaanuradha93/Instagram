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
    
    
    let plusPhotoButton = IGButton(backgroundColor: .white, title: Strings.empty, image: Asserts.plusPhoto.withRenderingMode(.alwaysOriginal))
    let emailTextField = IGTextField(placeholder: Strings.email)
    let usernameTextField = IGTextField(placeholder: Strings.username)
    let passwordTextField = IGTextField(placeholder: Strings.password, isSecureTextEntry: true)
    let signupButton = IGButton(backgroundColor: UIColor.appColor(.lightBlue), title: Strings.signUp, isEnabled: false)
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configurePlusPhotoButton()
        configureTextFields()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPlusPhotoButton()
    }
}

// MARK: - Methods
extension SignupVC {
    
    @objc fileprivate func handleInput() {
        
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
            usernameTextField.text?.count ?? 0 > 0 &&
            passwordTextField.text?.count ?? 0 >=  6
        
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
        
        let user = User(uid: Strings.empty, email: email, username: username, profileImageUrl: Strings.empty)
        signInWith(user: user, password: password, profileImage: plusPhotoButton.imageView?.image)
    }
    
    
    @objc fileprivate func handlePlusPhoto() { showImagePicker() }
    
    
    fileprivate func setupPlusPhotoButton() { plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2 }
    
    
    fileprivate func showImagePicker() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    
    fileprivate func signInWith(user: User, password: String, profileImage: UIImage?) {
        
        view.hidePreloader()
        viewModel.signInWith(user: user, password: password, image: profileImage) { [weak self] status in
            guard let self = self else { return }
            self.view.hidePreloader()
            if status {
                print("Status: \(status)")
            } else {
                // Error signed in
                print("Status: \(status)")
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
        signupButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    
    fileprivate func configurePlusPhotoButton() {

        plusPhotoButton.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        
        view.addSubview(plusPhotoButton)
        
        plusPhotoButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, paddingCenterX: 0, paddingCenterY: 0, width: 140, height: 140)
    }
}


// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension SignupVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: ImagePicker.EditedImage.key)] as? UIImage {
            plusPhotoButton.setImage(editedImage, for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: ImagePicker.OriginalImage.key)] as? UIImage {
            plusPhotoButton.setImage(originalImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
