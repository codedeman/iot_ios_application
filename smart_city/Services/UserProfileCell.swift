//
//  UserProfileCell.swift
//  smart_city
//
//  Created by Apple on 9/30/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet weak var stateLbl: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var switchState: UISwitch!
    
    @IBAction func switchMode(_ sender: Any) {
        
        if switchState.isOn{
        
        
        }else{
        
        
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
