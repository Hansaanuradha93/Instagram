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
        homeVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.homeUnselected, selectedImage: Asserts.homeSelected)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    private func createProfileNC() -> UINavigationController {
        
        let profileVC = ProfileVC.create(viewModel: ProfileVM())
        profileVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.profileUnselected, selectedImage: Asserts.profileSelected)
        return UINavigationController(rootViewController: profileVC)
    }
}
