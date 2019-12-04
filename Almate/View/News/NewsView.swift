//
//  NewsView.swift
//  Almate
//
//  Created by Qiarra on 01/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseFirestore

class NewsView: UIView {

    @IBOutlet weak var newsCollection: UICollectionView!
    var delegate: NewsViewDelegate?
    var dataNews:  [Post] = []
    var documents: [QueryDocumentSnapshot] = []
    
    
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
        return dataNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath as IndexPath) as! NewsCell
        let data = dataNews[indexPath.row]
        cell.captionOutlet.text = data.newsText
        cell.dateOutlet.text = data.newsDate
        cell.postImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[indexPath.row]))
        cell.likesButtonOutlet.setTitle("\(data.newsLike.stringValue) likes", for: .normal)
        
        cell.didTapComment = {
            () in
            self.delegate?.didTapComment(self.documents[indexPath.row])
        }
        return cell
    }
    
    
}

extension NewsView: UICollectionViewDelegate {
    
}

extension NewsView: NewsViewInput{
    func displayNews(_ data: [Post]?, _ documents: [QueryDocumentSnapshot]) {
        if let data = data{
            self.dataNews = data
            self.newsCollection.reloadData()
        } else {return}
        self.documents = documents
    }
    
    
}

protocol NewsViewDelegate{
    func didTapComment(_ documents: QueryDocumentSnapshot?)
}

protocol NewsViewInput{
    func displayNews(_ data: [Post]?, _ documents: [QueryDocumentSnapshot])
}
