//
//  addUserViewController.swift
//  Camera
//
//  Created by Apple on 16/9/14.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class addUserViewController: UIViewController {

    var dbRef:FIRDatabaseReference!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("users")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addPatients(_ sender: AnyObject) {
        let telephone = self.telephoneTextField.text
        let name = self.nameTextField.text
        let user = User(telephone: telephone!, name: name!)
        
        let userRef = self.dbRef.child(self.nameTextField.text!.lowercased())
        
        userRef.setValue(user.toAnyObject())
        
    }


}
