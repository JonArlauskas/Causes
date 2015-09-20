//
//  BrowseCausesViewController.swift
//  Causes
//
//  Created by Jonathan Arlauskas on 2015-09-19.
//  Copyright © 2015 Jonathan Arlauskas. All rights reserved.
//

import Firebase
import UIKit

class BrowseCausesViewController: UIViewController {
    
    //------------------------
    // MARK: Global Variables
    //------------------------
    
    let ref = Firebase(url:"https://causes.firebaseio.com/Causes")
    let mainRef = Firebase(url: "https://causes.firebaseio.com")
    var causeObject: CauseObject?
    var causeList : [CauseObject] = []
    var user: User?
    var count : Int?
    var path : String?
    
    //------------------------
    // MARK: IB outlets
    //------------------------
    @IBOutlet var causeTitle: UILabel!
    @IBOutlet var causeInfo: UITextView!
    
    //------------------------
    // MARK: View lifecycle
    //------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        track()
        userFill()
    }
    
    //------------------------
    // MARK: Actions
    //------------------------
    @IBAction func decline(sender: AnyObject) {
        count = count! + 1
        if count == 0 {
            self.causeInfo.text = ""
            self.causeTitle.text = " No more nearby causes"
        }
        else if count <= causeList.count-1 {
        setDisplay()
        } else {
            self.causeInfo.text = ""
            self.causeTitle.text = " No nearby causes"
        }

    }
    
    @IBAction func accept(sender: AnyObject) {
        
        let newCause = [
            "title": causeTitle.text,
            "description": causeInfo.text,
            "creator" : causeList[count!].creator! as String
        ]
        
        let postRef = self.mainRef.childByAppendingPath("Users/" + path! + "/MyCauses")
        let post1Ref = postRef.childByAppendingPath(causeTitle.text)
        post1Ref.setValue(newCause)
        
        
        
    }
    
    func userFill() {
        ref.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
                print(self.user)
                let temp = self.user?.email
                let temp1 = temp!.componentsSeparatedByString("@")[0]
                self.path = temp1.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            }
        }
    }
    
    
    func track() {
        
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
           
            print("-----.VALUE-----")
            let enumerator = snapshot.children
            while let objs = enumerator.nextObject() as? FDataSnapshot {
            
                let causeObj = CauseObject()
                causeObj.info = objs.value.objectForKey("description") as? String
                causeObj.title = objs.value.objectForKey("title") as? String
                causeObj.creator = objs.value.objectForKey("creator") as? String
                
                self.causeList.append(causeObj)
            }
            self.setDisplay()
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    
    
    func setDisplay() {
        if causeList.count != 0 {
        let currentDisplay = causeList[count!]
        
        self.causeInfo.text = currentDisplay.info
        self.causeTitle.text = currentDisplay.title
        }
 
    }
}
