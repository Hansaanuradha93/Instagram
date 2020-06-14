import UIKit

class IGTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [createMainNC(), createProfileNC()]
    }
}


// MARK: - Methods
extension IGTabBar {
    
    private func createProfileNC() -> UINavigationController {
        
        let profileVC = ProfileVC.create(viewModel: ProfileVC())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_unselected"), selectedImage: UIImage(named: "profile_selected"))
        return UINavigationController(rootViewController: profileVC)
    }
    
    private func createMainNC() -> UINavigationController {
        
        let profileVC = UIViewController()
//        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_unselected"), selectedImage: UIImage(named: "profile_selected"))
        return UINavigationController(rootViewController: profileVC)
    }
}
