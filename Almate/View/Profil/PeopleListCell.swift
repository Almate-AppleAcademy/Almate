//
//  PeopleListCell.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleListCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.cornerRadius = 10
        // Initialization code
    }

}
