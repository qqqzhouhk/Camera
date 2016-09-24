//
//  ViewController.swift
//  Camera
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dbRef:FIRDatabaseReference!
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addUser(sender: AnyObject) {
        
    
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        dbRef = FIRDatabase.database().reference().child("users")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedin")
        
        if(!isUserLoggedIn)
        {
         self.performSegueWithIdentifier("SigninToProtectedPage", sender: self)
        }
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedin")
        NSUserDefaults.standardUserDefaults().synchronize()
         self.performSegueWithIdentifier("ProtectedViewToSignin", sender: self)
        
        
        /*
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("loginView") as LoginViewController
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        AppDelegate.window?.rootViewController = loginViewController
        
        AppDelegate.window?.makeKeyAndVisible()
 */
        
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
}

