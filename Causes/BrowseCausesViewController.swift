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
    var causeObject: CauseObject?
    var causeList : [CauseObject] = []
    var count : Int?
    
    //------------------------
    // MARK: IB outlets
    //------------------------
    @IBOutlet var causeTitle: UILabel!
    @IBOutlet var causeInfo: UITextView!
    
    //------------------------
    // MARK: View delegates
    //------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        track()
    }
    
    //------------------------
    // MARK: Actions
    //------------------------
    @IBAction func decline(sender: AnyObject) {
        count = count! + 1
        if count <= causeList.count-1 {
        setDisplay()
        } else {
            print("DONE")
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
                
                self.causeList.append(causeObj)
            }
            self.setDisplay()
            }, withCancelBlock: { error in
                print(error.description)
        })
        
//        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
//            print("-----CHILD ADDED-----")
//            print(snapshot.value.objectForKey("description"))
//            print(snapshot.value.objectForKey("title"))
//            self.causeInfo.text = snapshot.value.objectForKey("description") as? String
//            self.causeTitle.text = snapshot.value.objectForKey("title") as? String
//        })
    }
    
    
    
    func setDisplay() {
        dump(causeList)
        let currentDisplay = causeList[count!]
        
        self.causeInfo.text = currentDisplay.info
        self.causeTitle.text = currentDisplay.title
 
    }
}
