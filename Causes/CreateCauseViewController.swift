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
        

    
    
    @IBAction func printText(sender: AnyObject) {
        
        if textInput.text.characters.count != 0 {
            let postRef = self.ref.childByAppendingPath("Causes")
            let post1Ref = postRef.childByAutoId()
            
            let newCause = [
                "title": self.causeTitle.text,
                "description": self.textInput.text
            ]
            
            post1Ref.setValue(newCause)
        }
    }
    
    //------------------------
    // MARK: View delegates
    //------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInput.delegate = self

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
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
