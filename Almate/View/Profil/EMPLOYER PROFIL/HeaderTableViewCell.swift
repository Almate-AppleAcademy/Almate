//
//  HeaderTableViewCell.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 21/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        contentView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
    }
}
