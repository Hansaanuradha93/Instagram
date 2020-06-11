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
            
            let user = User(uid: uid, username: email, profileImageUrl: "")
            completion(self.upload(profileImage: image, of: user))
            
        }
    }
    
    
    fileprivate func upload(profileImage: UIImage?, of user: User) -> Bool {
        
        var result: Bool = false
        
        guard let image = profileImage,
        let uploadData = image.jpegData(compressionQuality: 0.3) else { return result }
        
        let storageRef = Storage.storage().reference().child("profile_image/\(user.uid)")
        
        storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
            
            if let error = error {
                print("Image upload failed, \(error)")
                result = false
                
            } else {
                storageRef.downloadURL { (url, error) in
                    
                    if let error = error {
                        print("Image download url not recieved,\(error)")
                        result = false
                    } else {
                        guard let downloadUrl = url?.absoluteString else {
                            result = false
                            return
                        }
                        
                        print("Image uploaded successfully, \(downloadUrl)")
                        
                        let userDate = [
                            "username": user.username,
                            "imageUrl": downloadUrl
                        ]
                        result = (self.save(uid: user.uid, userDate: userDate))
                    }
                }
            }
        }
        return result
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
