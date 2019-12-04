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

    var didTapComment: (() -> ())?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        noPhoto()
        self.captionOutlet.preferredMaxLayoutWidth = self.captionOutlet.frame.width
        
        // Initialization code
        
        
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
    
    func noPhoto() {
        if postImageOutlet.image == nil {
            postImageOutlet.isHidden = true
//            captionOutlet.heightAnchor
//            captionOutlet.frame.height
//            captioframe.size.height = label.frame.height + x
            captionOutlet.frame = CGRect(x: 25, y: 80, width: 334, height: 377)
//            likesButtonOutlet.frame.origin.y = 270
//            commentButtonOutlet.frame.origin.y = 270
            
            
        }
        
        
    }
    @IBAction func didTappedComment(_ sender: UIButton) {
        didTapComment?()
    }
}
