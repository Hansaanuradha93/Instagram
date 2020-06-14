import Foundation
import Firebase

class ProfileVM {
    
    var user: User?
    
    func fetchUserData(completion: @escaping(_ status: Bool) -> Void) {
       
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        let userRef = Database.database().reference().child("users").child(uid)
        
        userRef.observeSingleEvent(of: DataEventType.value, with: { [weak self] snapshot in
            guard let self = self else {
                completion(false)
                return
            }
            self.user = User(snapshot: snapshot)
            completion(true)
        }) { error in
            print("User fetching failed, \(error)")
            completion(false)
        }
    }
}
