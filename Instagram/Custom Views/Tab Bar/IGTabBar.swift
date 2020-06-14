import UIKit

class IGTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [createHomeNC(), createProfileNC()]
    }
}


// MARK: - Methods
extension IGTabBar {
    
    private func createHomeNC() -> UINavigationController {
        
        let homeVC = HomeVC.create(viewModel: HomeVM())
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home_unselected"), selectedImage: UIImage(named: "home_selected"))
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    private func createProfileNC() -> UINavigationController {
        
        let profileVC = ProfileVC.create(viewModel: ProfileVC())
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile_unselected"), selectedImage: UIImage(named: "profile_selected"))
        return UINavigationController(rootViewController: profileVC)
    }
}
