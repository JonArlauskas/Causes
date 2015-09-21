//
//  MyCausesViewController.swift
//  Causes
//
//  Created by Jonathan Arlauskas on 2015-09-20.
//  Copyright © 2015 Jonathan Arlauskas. All rights reserved.
//

import UIKit
import Firebase

class MyCausesViewController: UITableViewController {
    
    //-------------------------
    // MARK: Global Variables
    //------------------------
    let mainRef = Firebase(url: "https://causes.firebaseio.com")
    let userRef = Firebase(url: "https://causes.firebaseio.com/Users")
    var user : User?
    var path : String?
    var causeObject: CauseObject?
    var myCauseList : [CauseObject] = []
    
    //-------------------------
    // MARK: Actions
    //------------------------
    
    func userFill() {
        mainRef.observeAuthEventWithBlock { authData in
            if authData != nil {
                self.user = User(authData: authData)
                let temp = self.user?.email
                let temp1 = temp!.componentsSeparatedByString("@")[0]
                self.path = temp1.stringByReplacingOccurrencesOfString(".", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            }
        }
    }
    
    func track() {
        let newRef = userRef.childByAppendingPath("\(self.path)/MyCauses")
        newRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let enumerator = snapshot.children
            while let objs = enumerator.nextObject() as? FDataSnapshot {
                
                let causeObj = CauseObject()
                print(causeObj)
                causeObj.info = objs.value.objectForKey("description") as? String
                causeObj.title = objs.value.objectForKey("title") as? String
                causeObj.creator = objs.value.objectForKey("creator") as? String
                
                self.myCauseList.append(causeObj)
            }
            dump(self.myCauseList)
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    //-------------------------
    // MARK: Tableview delegate 
    //------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCauseList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let causeItem = myCauseList[indexPath.row]
        cell?.textLabel?.text = causeItem.title
        cell?.detailTextLabel?.text = causeItem.creator

        
        return cell!
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            
        }
    }
    
    //-------------------------
    // MARK: View lifecycle
    //------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userFill()

        track()
    }


}
