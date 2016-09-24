//
//  LoginViewController.swift
//  Camera
//
//  Created by Apple on 16/8/16.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
/*
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail"
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword")
        
        if(userEmailStored == userEmail){
            if (userPasswordStored == userPassword){
                //login successfully
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedin")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else{
                displayMyAlertMessage("Password do not match username!")
            }
 
        }
*/
        if self.userEmailTextField.text == "" || self.userPasswordTextField.text == ""
        {
            displayMyAlertMessage("All fields required!")
        }
        else
        {
            FIRAuth.auth()?.signInWithEmail(self.userEmailTextField.text!, password: self.userPasswordTextField.text!, completion:
                {(user,error) in
                    if error == nil
                    {
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedin")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        self.performSegueWithIdentifier("SigninToProtectedPage", sender: self)
                        /*
                        let myViewController:ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
                        
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        
                        appDelegate.window?.rootViewController = myViewController
                        appDelegate.window?.makeKeyAndVisible()
                        */
                    }
                        
                    else
                    {
                        let myAlert = UIAlertController(title: "WARNING", message: error?.localizedDescription, preferredStyle:.Alert)
                        
                        let okAction = UIAlertAction(title:"ok", style: .Cancel, handler: nil)
                        
                        myAlert.addAction(okAction)
                        
                        self.presentViewController(myAlert, animated:true, completion:nil)
                    }
            })
            
        }
    }

    func displayMyAlertMessage (userMessage:String)
    {
        let myAlert = UIAlertController(title: "WARNING", message: userMessage, preferredStyle:.Alert)
        
        let okAction = UIAlertAction(title:"ok", style: .Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        presentViewController(myAlert, animated:true, completion:nil)
    }

}


//log out
//try! FIRAuth.auth()?.signOut()


