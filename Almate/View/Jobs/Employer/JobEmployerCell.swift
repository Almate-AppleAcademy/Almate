//
//  JobEmployerCell.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobEmployerCell: UICollectionViewCell {
    
//    var jobEmployerDelegate: JobEmployerDelegate?
    var didtapEdit : (()->())?
    @IBOutlet var editJob: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func editJobBtn(_ sender: Any) {
       didtapEdit?()
    }
    
}

//extension JobEmployerCell{
//    func edit(){
//        jobEmployerDelegate?.didTappedEdit()
//    }
//
//}

//protocol  JobEmployerDelegate{
//    func didTappedEdit()
//}
