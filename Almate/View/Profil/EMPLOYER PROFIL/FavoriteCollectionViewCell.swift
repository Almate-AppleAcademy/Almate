//
//  FavoriteCollectionViewCell.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 21/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var peopleSavedOutlet: UIImageView!
    @IBOutlet weak var skillTagCollectionView: UICollectionView!
    
    @IBOutlet var skillsTagnya: EmployerSkillCollectionViewCell!
    
    let skillTags = ["Swift", "Java", "C++", "Kotlin", "Ruby", "Sketch", "SAP HR"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        skillTagCollectionView.register(UINib(nibName: "skillsTagnya", bundle: nil), forCellWithReuseIdentifier: "skillTagDiEmployer")
        // Initialization code
    }
}

extension FavoriteCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillTagDiEmployer", for: indexPath) as! FavoriteCollectionViewCell
        return  cell
    }
}
