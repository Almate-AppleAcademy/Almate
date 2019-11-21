//
//  EmployerView.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerView: UIView {


    @IBOutlet weak var linkedinButtonOutlet: UIButton!
    @IBOutlet weak var telpButtonOutlet: UIButton!
    @IBOutlet weak var mailButtonOutlet: UIButton!
    @IBOutlet weak var profileEmployerView: UIView!
    @IBOutlet weak var savedEmployerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileEmployerView.alpha = 0
        
        
    }
    

    /*
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
