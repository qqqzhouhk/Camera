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
    func updateSearchResults(for searchController: UISearchController) {
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
    
    func filterContentForSearchText(_ searchText:String, scope:String = "All"){
        filteredUsers = users.filter { username in
            return username.name.lowercased().contains(searchText.lowercased())
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
        dbRef.observe(.value, with: {(snapshot:FIRDataSnapshot) in
            var newusers = [User]()
            
            for users in snapshot.children{
                let userObject = User(snapshot: users as! FIRDataSnapshot)
                newusers.append(userObject)
            }
            
            self.users = newusers
            self.tableView.reloadData()
            
        })  {(error:Error) in
            print(error.localizedDescription)
        }
    }
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedin")
        
        if(!isUserLoggedIn)
        {
         self.performSegue(withIdentifier: "SigninToProtectedPage", sender: self)
        }
    }

    
    
    
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedin")
        UserDefaults.standard.synchronize()
         self.performSegue(withIdentifier: "ProtectedViewToSignin", sender: self)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredUsers.count
        }

        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let username: User
        if searchController.isActive && searchController.searchBar.text != ""{
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let user = users[indexPath.row]
            
            user.itemRef?.removeValue()
        }
    }
}

