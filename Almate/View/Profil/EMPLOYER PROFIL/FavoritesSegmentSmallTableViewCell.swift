//
//  FavoritesSegmentSmallTableViewCell.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 21/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FavoritesSegmentSmallTableViewCell: UITableViewCell {

    @IBOutlet weak var skillTagsCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        skillTagsCollection.delegate = self
        skillTagsCollection.dataSource = self
        skillTagsCollection.register(UINib(nibName: "BusinessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "businessCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "IllustratorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "illustratorCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "ResearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "researchCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "FigmaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "figmaCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "SketchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sketchCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "WireframingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wireframingCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "SwitchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "switchCollectionViewCell")
        skillTagsCollection.register(UINib(nibName: "MoreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moreCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FavoritesSegmentSmallTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = skillTagsCollection.dequeueReusableCell(withReuseIdentifier: "businessCollectionViewCell", for: indexPath as IndexPath) as! BusinessCollectionViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell = skillTagsCollection.dequeueReusableCell(withReuseIdentifier: "illustratorCollectionViewCell", for: indexPath as IndexPath) as! IllustratorCollectionViewCell
            return cell
        } else if indexPath.row == 2 {
            let cell = skillTagsCollection.dequeueReusableCell(withReuseIdentifier: "researchCollectionViewCell", for: indexPath as IndexPath) as! ResearchCollectionViewCell
            return cell
        } else if indexPath.row == 3 {
            let cell = skillTagsCollection.dequeueReusableCell(withReuseIdentifier: "figmaCollectionViewCell", for: indexPath as IndexPath) as! FigmaCollectionViewCell
            return cell
        } else if indexPath.row == 4 {
            let cell = skillTagsCollection.dequeueReusableCell(withReuseIdentifier: "sketchCollectionViewCell", for: indexPath as IndexPath) as! SketchCollectionViewCell
            return cell
        } else {
            let cell = skillTagsCollection.dequeueReusableCell(withReuseIdentifier: "moreCollectionViewCell", for: indexPath as IndexPath) as! MoreCollectionViewCell
            return cell
        }
    }
    
    
}
