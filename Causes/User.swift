//
//  User.swift
//  Causes
//
//  Created by Jonathan Arlauskas on 2015-09-20.
//  Copyright © 2015 Jonathan Arlauskas. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid : String
    let email : String
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
