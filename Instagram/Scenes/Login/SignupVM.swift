import Foundation
import Firebase

class SignupVM {
    
    func signInWith(email: String, password: String, completion: @escaping(_ status: Bool) -> Void) {
        
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
            
            Database.database().reference().child("users").updateChildValues(values) { (error, ref) in
                
                if let error = error {
                    print("Failed to save user data, \(error)")
                    completion(false)
                    return
                }
                
                print("Successfully saved user, \(uid)")
                completion(true)
            }
        }
    }
}
