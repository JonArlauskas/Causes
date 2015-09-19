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
    
    //------------------------
    // MARK: IB outlets
    //------------------------
    
    @IBOutlet var textInput: UITextView!
    
    @IBAction func printText(sender: AnyObject) {
        
        print(textInput.text)
    }
    
    //------------------------
    // MARK: View delegates
    //------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.delegate = self
    }

    
    //------------------------
    // MARK: Text View delegate methods
    //------------------------
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        //If the text is larger than the maxtext, the return is false
        return textView.text.characters.count + ((text.characters.count) - range.length) <= INPUT_LIMIT
        
    }
}
