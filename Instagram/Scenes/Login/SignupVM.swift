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
            self.upload(profileImage: image, of: user, completion: completion)
            
        }
    }
    
    
    fileprivate func upload(profileImage: UIImage?, of user: User, completion: @escaping(_ status: Bool) -> Void) {
                
        guard let image = profileImage,
        let uploadData = image.jpegData(compressionQuality: 0.3) else {
            completion(false)
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_image/\(user.uid)")
        
        storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
            
            if let error = error {
                print("Image upload failed, \(error)")
                completion(false)
                
            } else {
                storageRef.downloadURL { (url, error) in
                    
                    if let error = error {
                        print("Image download url not recieved,\(error)")
                        completion(false)
                    } else {
                        guard let downloadUrl = url?.absoluteString else {
                            completion(false)
                            return
                        }
                        
                        print("Image uploaded successfully, \(downloadUrl)")
                        
                        let userDate = [
                            "username": user.username,
                            "imageUrl": downloadUrl
                        ]
                        self.save(uid: user.uid, userDate: userDate, completion: completion)
                    }
                }
            }
        }
    }
    
    fileprivate func save(uid: String, userDate: [String : String], completion: @escaping(_ status: Bool) -> Void) {
        
        let values = [uid: userDate]
        
        Database.database().reference().child("users").updateChildValues(values) { (error, ref) in

            if let error = error {
                print("Failed to save user data, \(error)")
                completion(false)
            } else {
                print("Successfully saved user, \(uid)")
                completion(true)
            }
        }
    }
}
