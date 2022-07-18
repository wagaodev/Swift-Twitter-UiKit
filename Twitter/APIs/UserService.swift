//
//  UserService.swift
//  Twitter
//
//  Created by Wagner Barboza Goulart on 18/07/22.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshoot in
            guard let dictionary = snapshoot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            
            print("DEBUG: Username is \(user.username)")
            print("DEBUG: Fullname is \(user.fullname)")
             
        }
    }
}
