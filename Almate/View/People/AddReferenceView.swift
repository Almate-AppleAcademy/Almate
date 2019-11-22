//
//  AddReferenceView.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 21/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class AddReferenceView: UIView {
    
    @IBOutlet weak var referenceTxtView: UITextView!
    @IBOutlet weak var peopleStalkedLbl: UILabel!
    @IBOutlet weak var peopleNgestalkLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        referenceTxtView.layer.cornerRadius = 10
        referenceTxtView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        referenceTxtView.layer.borderWidth = 0.5
        referenceTxtView.text = "Write something here..."
        referenceTxtView.textColor = UIColor.darkGray
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
