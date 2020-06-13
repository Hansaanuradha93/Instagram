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
                print("Profile image upload failed, \(error)")
                completion(false)
                
            } else {
                
                let downloadUrl = self.getDownloadUrl(storageReference: storageRef, completion: completion)
                let newUser = User(uid: user.uid, username: user.username, profileImageUrl: downloadUrl)
                self.save(user: newUser, completion: completion)
            }
        }
    }
    
    
    fileprivate func getDownloadUrl(storageReference: StorageReference, completion: @escaping(_ status: Bool) -> Void) -> String {
        
        var profileImageUrl: String = ""
        
        storageReference.downloadURL { (url, error) in
            
            if let error = error {
                print("Profile image download url not recieved,\(error)")
                completion(false)
            } else {
                guard let downloadUrl = url?.absoluteString else {
                    completion(false)
                    return
                }
                
                print("Profile image uploaded successfully, \(downloadUrl)")
                profileImageUrl = downloadUrl
            }
        }
        return profileImageUrl
    }
    
    
    fileprivate func save(user: User, completion: @escaping(_ status: Bool) -> Void) {
        
        let userData = [
            "username": user.username,
            "imageUrl": user.profileImageUrl
        ]
        let uid = user.uid
        let values = [uid: userData]
        
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