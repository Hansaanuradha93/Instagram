import UIKit

class SignupVC: UIViewController {

    //MARK: Properties
    var viewModel: SignupVM!
    
    
    static func create(viewModel: SignupVM) -> SignupVC {
        let viewController = SignupVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
