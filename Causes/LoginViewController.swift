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
    
    //-------------------------
    // MARK: Global Variables
    //------------------------
    
    let ref = Firebase(url: "https://causes.firebaseio.com")
    
    //------------------------
    // MARK: IB outlets and actions
    //------------------------
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    @IBOutlet var newUserLabel: UIButton!
    @IBAction func newUserAction(sender: AnyObject){
        if newUserLabel.titleLabel?.text == "New User?" {
            loginLabel.setTitle("Sign up!", forState: .Normal)
            newUserLabel.setTitle("Already a user?", forState: .Normal)
        } else if newUserLabel.titleLabel?.text == "Already a user?" {
            loginLabel.setTitle("Login", forState: .Normal)
            newUserLabel.setTitle("New user?", forState: .Normal)
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
    
    //------------------------
    // MARK: Actions
    //------------------------
    func signUp() {
        ref.createUser(emailText.text!, password: passwordText.text!,
            withValueCompletionBlock: { error, result in
                if error != nil {
                     print("-----Already user with this email-----")
                    self.displayAlert("Error!", message: "Account for this email already exists!")
                } else {
                    let uid = result["uid"] as? String
                    print("-----Signed up-----")
                    print("Successfully created user account with uid: \(uid)")
                    
                    // User data to add to DB
                    let newUser = [
                        "email": self.emailText.text!,
                        "causes": []
                    ]
                    
                    let postRef = self.ref.childByAppendingPath("Users")
                    let post1Ref = postRef.childByAutoId()
                    post1Ref.setValue(newUser)
                    self.login()
                }
        })

        
    }
    
    func login() {
        ref.authUser(emailText.text!, password: passwordText.text!,
            withCompletionBlock: { error, authData in
                if error != nil {
                    print("-----Incorrect info-----")
                    self.displayAlert("Error!", message: "Incorrect login information!")
                } else {
                    print("-----Logged in-----")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
        })
        
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //------------------------
    // MARK: View delegates
    //------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
}

