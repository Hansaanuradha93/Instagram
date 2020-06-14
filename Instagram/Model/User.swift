import Foundation
import Firebase

struct User {
    
    // MARK: Properties
    let uid: String
    let email: String
    let username: String
    let profileImageUrl: String
    
    
    // MARK: Initializers
    init(uid: String, email: String, username: String, profileImageUrl: String) {
        self.uid = uid
        self.email = email
        self.username = username
        self.profileImageUrl = profileImageUrl
    }
    
    
    init(snapshot: DataSnapshot) {
        let userDict = snapshot.value as? [String : AnyObject] ?? [:]
        let uid = Auth.auth().currentUser?.uid ?? ""
        let email = (userDict["email"] as? String) ?? ""
        let username = (userDict["username"] as? String) ?? ""
        let profileImageUrl = (userDict["imageUrl"] as? String) ?? ""
        self.init(uid: uid, email: email, username: username, profileImageUrl: profileImageUrl)
    }
}
