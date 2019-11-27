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
        newsCollection.register(UINib(nibName: "NewsNoPhotoCell", bundle: nil), forCellWithReuseIdentifier: "newsNoPhotoCell")
        newsCollection.register(UINib(nibName: "NewsOnePhotoCell", bundle: nil), forCellWithReuseIdentifier: "newsOnePhotoCell")
        newsCollection.register(UINib(nibName: "NewsTwoPhotoCell", bundle: nil), forCellWithReuseIdentifier: "newsTwoPhotoCell")
        newsCollection.register(UINib(nibName: "NewsThreePhotoCell", bundle: nil), forCellWithReuseIdentifier: "newsThreePhotoCell")
        newsCollection.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "newsCell")
        
        newsCollection.delegate = self
        newsCollection.dataSource = self
        
        if let layout = newsCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: newsCollection.frame.width - 50, height: 10)
        }
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
