import UIKit

class HomeVC: UIViewController {

    // MARK: Properties
    var viewModel: MainVM!
    
    
    static func create(viewModel: MainVM) -> HomeVC {
        let viewController = HomeVC()
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
