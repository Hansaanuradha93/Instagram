import UIKit

class IGTextField: UITextField {

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    convenience init(placeholder: String, isSecureTextEntry: Bool = false) {
        self.init()
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
    }
}


// MARK: - Methods
extension IGTextField {
    
    private func configure() {
        
        borderStyle = .roundedRect
        
        textColor = .label
        tintColor = .label
        font = UIFont.systemFont(ofSize: 14)
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
    }
}
