//
//  ForeCastCell.swift
//  smart_city
//
//  Created by Apple on 9/17/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ForeCastCell: UITableViewCell {

    
    @IBOutlet weak var value: UILabel!
    
    @IBOutlet weak var environmentPrameter: UILabel!
    @IBOutlet weak var background: RoundedView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
