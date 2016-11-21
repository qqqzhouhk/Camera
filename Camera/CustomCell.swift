//
//  CustomCell.swift
//  Camera
//
//  Created by Apple on 16/9/2.
//  Copyright © 2016年 Eriiic. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var TelephoneTextField: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
