//
//  User.swift
//  Camera
//
//  Created by Apple on 16/9/2.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import Foundation
import Firebase



struct User {
    
    let key:String!
    let telephone:String! //content = telephone
    let name:String!   // addedByuser = name
    let itemRef:FIRDatabaseReference?
    
    init (telephone:String, name:String, key:String = ""){
        self.key = key
        self.telephone = telephone
        self.name = name
        self.itemRef = nil
    }
    
    init (snapshot:FIRDataSnapshot){
        key = snapshot.key
        itemRef = snapshot.ref
        
        
        if let userTelephone = snapshot.value!["telephone"] as? String{
            telephone = userTelephone
        }
        else{
            telephone = ""
        }
        
        if let user = snapshot.value!["name"] as? String{
            name = user
        }
        else{
            name = ""
        }
    }
}
