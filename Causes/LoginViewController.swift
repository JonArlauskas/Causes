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

    @IBAction func newUserAction(sender: AnyObject) {
        if newUserLabel.titleLabel?.text == "New User?" {
            loginLabel.titleLabel?.text = "Sign Up!"
            
        } else {
            loginLabel.titleLabel?.text = "Login"
        }
    
    }
    
    @IBOutlet var loginLabel: UIButton!
    
    
    @IBAction func loginAction(sender: AnyObject) {
        
        if loginLabel.titleLabel?.text == "Login" {
            
            
        } else {
            
            
        }

    }
    
    
    
    
    
    
    
    
}

