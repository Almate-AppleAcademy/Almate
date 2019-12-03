//
//  PeopleCell.swift
//  Almate
//
//  Created by Qiarra on 05/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleCell: UICollectionViewCell {

    @IBOutlet weak var imgPeopleCell: UIImageView!
    @IBOutlet weak var namePeopleCell: UILabel!
    @IBOutlet weak var genPeopleCelll: UILabel!
    @IBOutlet weak var occupationPeopleCelll: UILabel!
    @IBOutlet weak var skillCollection: UICollectionView!
    @IBOutlet weak var btnSaveContact: UIButton!
   
    //THIS IS INSIDE CELL
    //MARK: STEP 1 - Create Variable for action button cell
    var didTapSaveContact : (()->())?
    var skills: [String]?
    
    var arraySkills: [String]? {
        didSet {
            skillCollection.reloadData()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        imgPeopleCell.layer.cornerRadius = 15
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 10/100
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        skillCollection.register(UINib(nibName: "SkillCell", bundle: nil), forCellWithReuseIdentifier: "skillCell")
        skillCollection.dataSource = self
    }
    
    // MARK: STEP 2 - Make Button actionable
    @IBAction func didTappedSaveContact(_ sender: UIButton) {
        // MARK: STEP 3 - Call the variable inside function action
        didTapSaveContact?()
    }
    
    func skillData(_ dataSkill: [String]?) {
        if let dataSkill = dataSkill {
            self.skills = dataSkill
            self.skillCollection.reloadData()
        } else {
            print("skills not found")
        }
    }
}

extension PeopleCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySkills!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCell", for: indexPath) as! SkillCell
        cell.skillLabel.text = skills![indexPath.row]
        return cell
    }
}
