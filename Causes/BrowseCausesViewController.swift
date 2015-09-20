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
    
    
    let ref = Firebase(url:"https://causes.firebaseio.com/Causes")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        track()
    }
    
    func track() {
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            print("-----.VALUE-----")
            print(snapshot.value)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            print("-----CHILD ADDED-----")
            print(snapshot.value.objectForKey("description"))
            print(snapshot.value.objectForKey("title"))
        })
        
        
    }
    
    
    

}
