//
//  NewsView.swift
//  Almate
//
//  Created by Qiarra on 01/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class NewsView: UIView {

    @IBOutlet weak var newsCollection: UICollectionView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsCollection.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "newsCell")
        newsCollection.delegate = self
        newsCollection.dataSource = self
    }

}

extension NewsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath as IndexPath) as! NewsCell
        
//        cell.coNameOutlet.text = "Jing"
        return cell
    }
    
    
}

extension NewsView: UICollectionViewDelegate {
    
}
