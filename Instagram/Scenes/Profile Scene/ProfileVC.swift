import UIKit
import Firebase

class ProfileVC: UICollectionViewController {

    // MARK: Properties
    var viewModel: ProfileVM!
    
    
    static func create(viewModel: ProfileVM) -> ProfileVC {
        let layout = UICollectionViewFlowLayout()
        let viewController = ProfileVC(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        fetchUserData()
    }
}


// MARK: - Methods
extension ProfileVC {
    
    fileprivate func configureViewController() { collectionView.backgroundColor = .white }
    
    
    fileprivate func fetchUserData() {
        
        viewModel.fetchUserData { [weak self] status in
            if status {
                guard  let self = self else { return }
                self.navigationItem.title = self.viewModel.user?.username ?? ""
            }
        }
    }
}
