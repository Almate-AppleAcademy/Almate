//
//  SkillCell.swift
//  Almate
//
//  Created by Qiarra on 11/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class SkillCell: UICollectionViewCell {
    
    @IBOutlet weak var skillLabel: UILabel!
    
    override func layoutSubviews() {
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 11
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.masksToBounds = true
//        self.contentView.layer.borderWidth = 0.5
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

}
