//
//  SearchView.swift
//  Almate
//
//  Created by Qiarra on 16/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class SearchView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var newsCollection: UICollectionView!
    @IBOutlet var peopleCollection: UICollectionView!
    @IBOutlet var jobsCollection: UICollectionView!
    
    override func awakeFromNib() {
        
    }
}

//extension SearchView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//}

extension SearchView: UICollectionViewDelegate {
    
}
