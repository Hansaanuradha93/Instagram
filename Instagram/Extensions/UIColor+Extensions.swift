import UIKit

enum AssetsColor: String {
    case lightBlue = "light_blue"
}

extension UIColor {
    static func appColor(_ color: AssetsColor) -> UIColor {
        return UIColor(named: color.rawValue)!
    }
}

