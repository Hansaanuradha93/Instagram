import UIKit

class IGTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [createProfileNC()]
    }
}


// MARK: - Methods
extension IGTabBar {
    
    private func createProfileNC() -> UINavigationController {
        
        let profileVC = ProfileVC.create(viewModel: ProfileVC())
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        return UINavigationController(rootViewController: profileVC)
    }
}
