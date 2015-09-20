//
//  CreateCauseViewController.swift
//  Causes
//
//  Created by Jonathan Arlauskas on 2015-09-19.
//  Copyright © 2015 Jonathan Arlauskas. All rights reserved.
//

import UIKit
import Firebase

class CreateCauseViewController: UIViewController, UITextViewDelegate {
    
    //------------------------
    // MARK: Global Variables
    //------------------------
    
    let INPUT_LIMIT = 100
    let ref = Firebase(url: "https://causes.firebaseio.com")
    let userRef = Firebase(url: " https://causes.firebaseio.com/Users")
    var user: User?
    var path : String?
    
    //------------------------
    // MARK: IB outlets
    //------------------------
    
    @IBOutlet var causeTitle: UITextField!
    @IBOutlet var textInput: UITextView!
    
    
    //------------------------
    // MARK: Actions
    //------------------------
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
        
    @IBAction func logout(sender: AnyObject) {
        ref.unauth()
        self.performSegueWithIdentifier("logout", sender: self)
    }
        

    
    
    @IBAction func saveCause(sender: AnyObject) {
        if textInput.text.characters.count != 0 {
            let postRef = self.ref.childByAppendingPath("Causes")
            let post1Ref = postRef.childByAutoId()
            
            let newCause = [
                "title": self.causeTitle.text,
                "description": self.textInput.text,
                "creator": self.user?.email
            ]
            
            post1Ref.setValue(newCause)
            fillMyCause(newCause)
        }
    }
    
    // Fill user object with current users data
    func userFill(){
        ref.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
                
                let temp = self.user?.email
                let temp1 = temp!.componentsSeparatedByString("@")[0]
                self.path = temp1.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            }
        }
    }
    
    
    func fillMyCause(input:[String: String!]) {
        
        let postRef = self.ref.childByAppendingPath("Users/" + path! + "/MyCauses")
        let post1Ref = postRef.childByAppendingPath(causeTitle.text)
        post1Ref.setValue(input)
        
    }
    
    //------------------------
    // MARK: View lifecycle
    //------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInput.delegate = self
        
        // Puts cursor in top left of textview
        self.automaticallyAdjustsScrollViewInsets = false

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        userFill()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Login transition check
        let user = ref.authData
        if user == nil{
            self.performSegueWithIdentifier("logout", sender: self)
        }
    }

    
    //------------------------
    // MARK: Text View delegate methods
    //------------------------
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + ((text.characters.count) - range.length) <= INPUT_LIMIT
    }
}
