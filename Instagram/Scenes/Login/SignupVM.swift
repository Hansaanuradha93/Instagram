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
            
            guard let image = image,
            let uploadData = image.jpegData(compressionQuality: 0.3) else { return }
            
            let storageRef = Storage.storage().reference().child("profile_image/\(uid)")
        
            storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                
                if let error = error {
                    print("Image upload failed, \(error)")
                    return
                }
                
                storageRef.downloadURL { (url, error) in
                    
                    if let error = error {
                        print("Image download url not recieved,\(error)")
                        return
                    }
                    
                    guard let downloadUrl = url?.absoluteString else { return }
                    print("Image uploaded successfully, \(downloadUrl)")
                    
                    let userDate = [
                        "username": email,
                        "imageUrl": downloadUrl
                    ]
                    
                    completion(self.save(uid: uid, userDate: userDate))
                }
            }
        }
    }
    
    fileprivate func save(uid: String, userDate: [String : String]) -> Bool {
        
        let values = [uid: userDate]
        var result: Bool = false
        
        Database.database().reference().child("users").updateChildValues(values) { (error, ref) in

            if let error = error {
                print("Failed to save user data, \(error)")
                result = false
            } else {
                print("Successfully saved user, \(uid)")
                result = true
            }
        }
        return result
    }
}
