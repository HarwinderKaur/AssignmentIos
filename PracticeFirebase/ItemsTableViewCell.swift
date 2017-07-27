//
//  ItemsTableViewCell.swift
//  PracticeFirebase
//
//  Created by Ramandeep Singh on 2017-07-20.
//  Copyright © 2017 Ramandeep Singh. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

  
    @IBOutlet weak var itemLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
