//
//  LoginViewController.swift
//  Causes
//
//  Created by Jonathan Arlauskas on 2015-09-19.
//  Copyright © 2015 Jonathan Arlauskas. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let ref = Firebase(url: "https://causes.firebaseio.com")
    
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    
    @IBOutlet var newUserLabel: UIButton!

    @IBAction func newUserAction(sender: AnyObject){
        if newUserLabel.titleLabel?.text == "New User?" {
            loginLabel.setTitle("Sign up!", forState: UIControlState.Normal)
            newUserLabel.setTitle("Already a user?", forState: UIControlState.Normal)
            
        } else {
            loginLabel.setTitle("Login", forState: UIControlState.Normal)
            newUserLabel.setTitle("New user?", forState: UIControlState.Normal)
        }
    
    }
    
    @IBOutlet var loginLabel: UIButton!

    @IBAction func loginAction(sender: AnyObject) {
        if loginLabel.titleLabel?.text == "Login" {
            login()
        } else {
            signUp()
        }
    }
    
    
    func signUp() {
        ref.createUser(emailText.text!, password: passwordText.text!,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                }
        })
        
    }
    
    func login() {
        
        
    }
    
    
    
    
    
}

