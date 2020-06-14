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
        collectionView.backgroundColor = .white        
        fetchUserData()
    }
    
    
    fileprivate func fetchUserData() {
        
        viewModel.fetchUserData { [weak self] status in
            if status {
                guard  let self = self else { return }
                self.navigationItem.title = self.viewModel.user?.username ?? ""
            }
        }
    }
}
