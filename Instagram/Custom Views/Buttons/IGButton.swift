import UIKit

class IGButton: UIButton {
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(backgroundColor: UIColor, title: String, image: UIImage? = nil) {
        self.init(frame: .zero)
        setup(backgroundColor: backgroundColor, title: title, image: image)
    }
}


// MARK: - Methods
extension IGButton {
    
    func setup(backgroundColor: UIColor, title: String, image: UIImage? = nil) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.setImage(image, for: .normal)
    }
    
    
    private func configure() {
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        setTitleColor(.white, for: .normal)
    }
}
