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
            print("Authentication successful: \(authResult?.user.refreshToken ?? "")")
            completion(true)
        }
    }
}
