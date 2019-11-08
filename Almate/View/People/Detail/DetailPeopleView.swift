//
//  DetailPeopleView.swift
//  Almate
//
//  Created by Qiarra on 08/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class DetailPeopleView: UIView {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var companyNameProfile: UILabel!
    @IBOutlet weak var linkedinBtn: UIButton!
    @IBOutlet weak var telponBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var skillsCollection: UICollectionView!
    @IBOutlet weak var aboutProfile: UITextView!
    @IBOutlet weak var educationCollection: UICollectionView!
    @IBOutlet weak var workCollection: UICollectionView!
    
    override func awakeFromNib() {
        
    }
}
