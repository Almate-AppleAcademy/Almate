//
//  SkillProfileCell.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class SkillProfileCell: UICollectionViewCell {

    @IBOutlet weak var labelMaxWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var skillLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.2800000012, green: 0.2800000012, blue: 0.2800000012, alpha: 1)
        self.labelMaxWidthConstraint.constant = UIScreen.main.bounds.width - 6 * 2 - 6 * 2
        // Initialization code
    }

}
