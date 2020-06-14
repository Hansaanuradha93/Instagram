import UIKit

class HomeVC: UIViewController {

    // MARK: Properties
    var viewModel: HomeVM!
    
    
    static func create(viewModel: HomeVM) -> HomeVC {
        let viewController = HomeVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
