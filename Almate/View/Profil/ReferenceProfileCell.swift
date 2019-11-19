//
//  ReferenceCell.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 13/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class ReferenceProfileCell: UICollectionViewCell {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var namaUser: UILabel!
    @IBOutlet weak var angkatanUser: UILabel!
    @IBOutlet weak var kerjaanUser: UILabel!
    @IBOutlet weak var quoteUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        quoteUser.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

}
