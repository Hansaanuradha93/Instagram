import UIKit
import Firebase

class ProfileVC: UICollectionViewController {

    // MARK: Properties
    var viewModel: ProfileVC!
    
    
    static func create(viewModel: ProfileVC) -> ProfileVC {
        let layout = UICollectionViewFlowLayout()
        let viewController = ProfileVC(collectionViewLayout: layout)
        viewController.viewModel = viewModel
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.title = Auth.auth().currentUser?.email
        
        fetchUserData()
    }
    
    
    fileprivate func fetchUserData() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userRef = Database.database().reference().child("users").child(uid)
        
        userRef.observe(DataEventType.value, with: { (snapshot) in
          let userDict = snapshot.value as? [String : AnyObject] ?? [:]
          print(userDict)
        })
    }
}
