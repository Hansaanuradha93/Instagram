import UIKit

class IGButton: UIButton {
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    convenience init(backgroundColor: UIColor, title: String, image: UIImage? = nil, isEnabled: Bool = true) {
        self.init(frame: .zero)
        setup(backgroundColor: backgroundColor, title: title, image: image, isEnabled: isEnabled)
    }
}


// MARK: - Methods
extension IGButton {
    
    func setup(backgroundColor: UIColor, title: String, image: UIImage?, isEnabled: Bool) {
        
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setImage(image, for: .normal)
        self.isEnabled = isEnabled
    }
    
    
    private func configure() {
        
        layer.cornerRadius = 5
        layer.masksToBounds = false
        clipsToBounds = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        setTitleColor(.white, for: .normal)
    }
}
