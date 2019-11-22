//
//  PeopleListCell.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleListCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
let arraySkills = ["Swift", "Java", "Kotlin", "Asyncrhonus", "Firestore", "Cocoapods", "J-Pop"]
    
    @IBOutlet weak var skillPeopleCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 15/100
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        skillPeopleCollection.register(UINib(nibName: "SkillCell", bundle: nil), forCellWithReuseIdentifier: "skillCell")
        
        skillPeopleCollection.dataSource = self
        skillPeopleCollection.delegate = self
        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySkills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCell", for: indexPath) as! SkillCell
        cell.skillLabel.text = arraySkills[indexPath.row]
        return cell
    }

}
