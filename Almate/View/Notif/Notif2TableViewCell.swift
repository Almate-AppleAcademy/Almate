//
//  Notif2TableViewCell.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class Notif2TableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictOutlet: UIImageView!
    @IBOutlet weak var notificationOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
