//
//  FilterValueCell.swift
//  Almate
//
//  Created by Qiarra on 14/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterValueCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonValue: UIButton!
    var didTapValue: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didTapFilterValue(_ sender: UIButton) {
        
    }
    
}
