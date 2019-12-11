//
//  NewsNoPhotoCell.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 27/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class NewsNoPhotoCell: UICollectionViewCell {

    @IBOutlet weak var coImageOutlet: UIImageView!
    @IBOutlet weak var coNameOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var captionOutlet: UILabel!
    @IBOutlet weak var likesButtonOutlet: UIButton!
    @IBOutlet weak var commentButtonOutlet: UIButton!
    
    var didTapComment: (() -> ())?
    var didLikeComment: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.captionOutlet.preferredMaxLayoutWidth = self.captionOutlet.frame.width
        
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 15/100
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    
    @IBAction func didTappedComment(_ sender: UIButton) {
        didTapComment?()
    }
    @IBAction func didLikedComment(_ sender: UIButton) {
        didLikeComment?()
    }
    

}
