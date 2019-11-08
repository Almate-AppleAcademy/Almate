//
//  NewsCell.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var coImageOutlet: UIImageView!
    @IBOutlet weak var coNameOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var captionOutlet: UILabel!
    @IBOutlet weak var postImageOutlet: UIImageView!
    @IBOutlet weak var likesButtonOutlet: UIButton!
    @IBOutlet weak var commentButtonOutlet: UIButton!
    @IBOutlet weak var shareButtonOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
