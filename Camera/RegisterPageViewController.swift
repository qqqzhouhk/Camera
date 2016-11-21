//
//  RegisterPageViewController.swift
//  Camera
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit
import Firebase

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        
        //check if password matchs
        if(userPasswordTextField.text != repeatPasswordTextField.text)
        {
            //display message
            displayMyAlertMessage("Passwords do not match!")
            return
        }
/*
        //store data
        
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        //Display message with confirmation
        let myAlert = UIAlertController(title: "Thank You", message: "registion is completed!", preferredStyle:.Alert)
        
        let okAction = UIAlertAction(title:"ok", style: .Default){
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        presentViewController(myAlert, animated:true,completion:nil)
        
*/
        
        // check for empty fields
        if self.userEmailTextField.text == "" || self.userPasswordTextField.text == ""
        {
            displayMyAlertMessage("All fields are required!")
            return
        }
        //creat userEmail and userPassword
        else
        {
            FIRAuth.auth()?.createUser(withEmail: self.userEmailTextField.text!, password: self.userPasswordTextField.text!, completion: {
                (user,error) in
                
                if error == nil
                {
                    
                    //Display message with confirmation
                    let myAlert = UIAlertController(title: "Thank You", message: "registion is completed!", preferredStyle:.alert)
                    
                    let okAction = UIAlertAction(title:"ok", style: .default){
                        action in
                        UserDefaults.standard.set(true, forKey: "isUserLoggedin")
                        UserDefaults.standard.synchronize()
                        
                        self.performSegue(withIdentifier: "SignupViewToProtectedView", sender: self)
                    }
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated:true,completion:nil)
                    
                }
                    //display error message
                else
                {
                    let myAlert = UIAlertController(title: "WARNING", message: error?.localizedDescription, preferredStyle:.alert)
                    let okAction = UIAlertAction(title:"ok", style: .cancel, handler: nil)
                    
                    myAlert.addAction(okAction)
                    
                    self.present(myAlert, animated:true, completion:nil)
                }
                
            })
        }
        
    }

    
    
    
    func displayMyAlertMessage (_ userMessage:String)
    {
        let myAlert = UIAlertController(title: "WARNING", message: userMessage, preferredStyle:.alert)
        
        let okAction = UIAlertAction(title:"ok", style: .default, handler: nil)
        
        myAlert.addAction(okAction)
        
        present(myAlert, animated:true, completion:nil)
    }
    


}
