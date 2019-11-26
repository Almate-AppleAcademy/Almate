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
    
    var dataPost: [Post] = [] {
        didSet {
            self.newsCollection.reloadData()
        }
    }
    
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
        return dataPost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath as IndexPath) as! NewsCell
        
        cell.coNameOutlet.text = dataPost[indexPath.row].postNameProfile
        cell.captionOutlet.text = dataPost[indexPath.row].postText
        cell.postImageOutlet.image = dataPost[indexPath.row].postImageProfile
        cell.likesButtonOutlet.setTitle(" 12 likes", for: .normal)
        return cell
    }
    
    
}

extension NewsView: UICollectionViewDelegate {
    
}
