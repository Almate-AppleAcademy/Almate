//
//  JobCell.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 07/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobCell: UICollectionViewCell {

    @IBOutlet var jobPicture: UIImageView!
    @IBOutlet var jobTitle: UILabel!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var jobLocation: UILabel!
    @IBOutlet var bookmarkBtn: UIButton!
    
    var isSaved: Bool? {
        didSet {
            // set color according to state
            if isSaved! {
                self.bookmarkBtn.setBackgroundImage(UIImage(named: "save-filled"), for: .highlighted)
            } else {
                self.bookmarkBtn.setBackgroundImage(UIImage(named: "save-unfilled"), for: .highlighted)
            }
//            self.bookmarkBtn.imageView?.image = self.isSelected ? UIImage(named: "save-filled") : UIImage(named: "save-unfilled")
        }
    }
    
    var didTapSaveContact : ((_ sender: UIButton)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 15/100
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    @IBAction func didTappedSaveContact(_ sender: UIButton) {
        // MARK: STEP 3 - Call the variable inside function action
        didTapSaveContact?(sender)
    }
}
