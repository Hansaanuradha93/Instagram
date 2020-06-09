import UIKit

class SignupVC: UIViewController {

    //MARK: Properties
    var viewModel: SignupVM!
    
    
    static func create(viewModel: SignupVM) -> SignupVC {
        let viewController = SignupVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        return  button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(plusPhotoButton)
        
        NSLayoutConstraint.activate([
            plusPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 140),
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
