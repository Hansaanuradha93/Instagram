import UIKit

class ProfileVC: UIViewController {

    // MARK: Properties
    var viewModel: MainVM!
    
    
    static func create(viewModel: MainVM) -> ProfileVC {
        let viewController = ProfileVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
