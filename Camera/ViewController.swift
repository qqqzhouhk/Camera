//
//  ViewController.swift
//  Camera
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

// MARK: - Properties
    var dbRef:FIRDatabaseReference!
    var users = [User]()
    var filteredUsers = [User]()
    var searchController: UISearchController!
    var resultsController = UITableViewController()
    
    @IBOutlet weak var tableView: UITableView!

/*
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //filter through the patients
        
        self.filteredUsers = self.users.filter { (user:String) -> Bool in
          return true
        }
        //update the results tableview
        self.resultsController.tableView.reloadData()
    }
*/
    
    func filterContentForSearchText(searchText:String, scope:String = "All"){
        filteredUsers = users.filter { username in
            return username.name.lowercaseString.containsString(searchText.lowercaseString)
            //return username.telephone.lowercaseString.containsString(searchText.lowercaseString)
    }
        self.resultsController.tableView.reloadData()
        //tableView.reloadData()
    }


// MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("users")
        startObservingDB()
        
        //search bar
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        searchController.searchResultsUpdater = self
    }



    func startObservingDB (){
        dbRef.observeEventType(.Value, withBlock: {(snapshot:FIRDataSnapshot) in
            var newusers = [User]()
            
            for users in snapshot.children{
                let userObject = User(snapshot: users as! FIRDataSnapshot)
                newusers.append(userObject)
            }
            
            self.users = newusers
            self.tableView.reloadData()
            
        })  {(error:NSError) in
            print(error.description)
        }
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
        if searchController.active && searchController.searchBar.text != ""{
            return filteredUsers.count
        }

        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        let username: User
        if searchController.active && searchController.searchBar.text != ""{
            username = filteredUsers[indexPath.row]
        } else{
            username = users[indexPath.row]
        }
        
        
        
        
        //self.NameTextField.text = user.name
        //self.TelephoneTextField.text = user.telephone
        
        cell.NameTextField.text=username.name
        cell.TelephoneTextField.text=username.telephone
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let user = users[indexPath.row]
            
            user.itemRef?.removeValue()
        }
    }
}

