import UIKit

class ProfileVC: UIViewController {

    // MARK: Properties
    var viewModel: ProfileVC!
    
    
    static func create(viewModel: ProfileVC) -> ProfileVC {
        let viewController = ProfileVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
