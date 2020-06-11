import UIKit
import Firebase

class SignupVM {
    
    func signInWith(email: String, password: String, image: UIImage?, completion: @escaping(_ status: Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("Authentication failed with error: \(error)")
                completion(false)
                return
            }
            
            guard let uid = authResult?.user.uid else {
                completion(false)
                return
            }
            
            let usernameValues = ["username": email]
            let values = [uid: usernameValues]
            
            
            guard let image = image,
            let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            
            
        
            
            Storage.storage().reference().child("profile_image").putData(uploadData, metadata: nil) { (metaData, error) in
                
                if let error = error {
                    print("Image upload failed, \(error)")
                    return
                }
                
                
                print("Image uploaded successfully")
            }
//            Database.database().reference().child("users").updateChildValues(values) { (error, ref) in
//
//                if let error = error {
//                    print("Failed to save user data, \(error)")
//                    completion(false)
//                    return
//                }
//
//                print("Successfully saved user, \(uid)")
//                completion(true)
//            }
        }
    }
}
