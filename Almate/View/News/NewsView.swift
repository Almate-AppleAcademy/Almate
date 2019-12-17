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
    var didLike: Bool?
    var likeStates: [Bool] = []
    
    var dataPost: [LocalPost] = [] {
        didSet {
            self.newsCollection.reloadData()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsCollection.register(UINib(nibName: "NewsNoPhotoCell", bundle: nil), forCellWithReuseIdentifier: "newsNoPhotoCell")
        newsCollection.register(UINib(nibName: "NewsOnePhotoCell", bundle: nil), forCellWithReuseIdentifier: "newsOnePhotoCell")
        newsCollection.register(UINib(nibName: "NewsTwoPhotosCell", bundle: nil), forCellWithReuseIdentifier: "newsTwoPhotosCell")
        newsCollection.register(UINib(nibName: "NewsThreePhotosCell", bundle: nil), forCellWithReuseIdentifier: "newsThreePhotosCell")
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
        
        var data = dataNews[indexPath.row]
        if data.newsPhoto.count == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsNoPhotoCell", for: indexPath) as! NewsNoPhotoCell
            cell.captionOutlet.text = data.newsText
            cell.dateOutlet.text = data.newsDate
            cell.likesButtonOutlet.setTitle("\(String(data.newsLike)) likes", for: .normal)
            if likeStates.count == 0 {
                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
            } else {
                if likeStates[indexPath.row] {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                } else {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                }
            }
             cell.didLikeComment = {
                            () in
                            let documentID = self.documents[indexPath.row]
                            let dataLocal = NewsLikeLocal(postId: documentID.documentID)
                            if self.didLike == true && self.likeStates.count != 0 && self.likeStates[indexPath.row]{
                                data.newsLike -= 1
                                self.didLike = false
                                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                                self.delegate?.didLikePost(.delete, dataLocal, data.newsLike, documentID: documentID.documentID)
                                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                                print(self.likeStates)

                            } else {
            //                    data.newsLike += 1
                                self.didLike = true
                                cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                                self.delegate?.didLikePost(.create, dataLocal, data.newsLike, documentID: documentID.documentID)
                                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                                print(self.likeStates)
                            }
                                
                        }
            return cell
        } else if data.newsPhoto.count == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
            cell.captionOutlet.text = data.newsText
            cell.dateOutlet.text = data.newsDate
            cell.postImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[0]))
            cell.likesButtonOutlet.setTitle("\(String(data.newsLike)) likes", for: .normal)
            if likeStates.count == 0 {
                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
            } else {
                if likeStates[indexPath.row] {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                } else {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                }
            }
            
            cell.didTapComment = {
                () in
                self.delegate?.didTapComment(self.documents[indexPath.row])
            }
             cell.didLikeComment = {
                            () in
                            let documentID = self.documents[indexPath.row]
                            let dataLocal = NewsLikeLocal(postId: documentID.documentID)
                            if self.didLike == true && self.likeStates.count != 0 && self.likeStates[indexPath.row]{
                                data.newsLike -= 1
                                self.didLike = false
                                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                                self.delegate?.didLikePost(.delete, dataLocal, data.newsLike, documentID: documentID.documentID)
                                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                                print(self.likeStates)

                            } else {
            //                    data.newsLike += 1
                                self.didLike = true
                                cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                                self.delegate?.didLikePost(.create, dataLocal, data.newsLike, documentID: documentID.documentID)
                                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                                print(self.likeStates)
                            }
                                
                        }
            return cell
        } else if data.newsPhoto.count == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsTwoPhotosCell", for: indexPath) as! NewsTwoPhotosCell
            cell.captionOutlet.text = data.newsText
            cell.dateOutlet.text = data.newsDate
            cell.firstImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[0]))
            cell.secondImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[1]))
            cell.likesButtonOutlet.setTitle("\(String(data.newsLike)) likes", for: .normal)
            if likeStates.count == 0 {
                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
            } else {
                if likeStates[indexPath.row] {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                } else {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                }
            }
            
            cell.didTapComment = {
                () in
                self.delegate?.didTapComment(self.documents[indexPath.row])
            }
             cell.didLikeComment = {
                            () in
                            let documentID = self.documents[indexPath.row]
                            let dataLocal = NewsLikeLocal(postId: documentID.documentID)
                            if self.didLike == true && self.likeStates.count != 0 && self.likeStates[indexPath.row]{
                                data.newsLike -= 1
                                self.didLike = false
                                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                                self.delegate?.didLikePost(.delete, dataLocal, data.newsLike, documentID: documentID.documentID)
                                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]

                            } else {
            //                    data.newsLike += 1
                                self.didLike = true
                                cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                                self.delegate?.didLikePost(.create, dataLocal, data.newsLike, documentID: documentID.documentID)
                                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                            }
                                
                        }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsThreePhotosCell", for: indexPath) as! NewsThreePhotosCell
            cell.captionOutlet.text = data.newsText
            cell.dateOutlet.text = data.newsDate
            cell.firstImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[0]))
            cell.secondImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[1]))
            cell.thirdImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[2]))
            cell.likesButtonOutlet.setTitle("\(String(data.newsLike)) likes", for: .normal)
            if likeStates.count == 0 {
                cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
            } else {
                if likeStates[indexPath.row] {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                } else {
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                }
            }
            cell.didTapComment = {
                () in
                self.delegate?.didTapComment(self.documents[indexPath.row])
            }
            cell.didLikeComment = {
                () in
                let documentID = self.documents[indexPath.row]
                let dataLocal = NewsLikeLocal(postId: documentID.documentID)
                if self.didLike == true && self.likeStates.count != 0 && self.likeStates[indexPath.row]{
                    data.newsLike -= 1
                    self.didLike = false
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-unfilled"), for: .normal)
                    self.delegate?.didLikePost(.delete, dataLocal, data.newsLike, documentID: documentID.documentID)
                    self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                    print(self.likeStates)
                } else {
                    self.didLike = true
                    cell.likesButtonOutlet.setImage(UIImage(named: "heart-filled"), for: .normal)
                    self.delegate?.didLikePost(.create, dataLocal, data.newsLike, documentID: documentID.documentID)
                    self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
                    print(self.likeStates)
                }
                    
            }
            return cell
        }
        
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath as IndexPath) as! NewsCell
//        let data = dataNews[indexPath.row]
//        cell.captionOutlet.text = data.newsText
//        cell.dateOutlet.text = data.newsDate
//        cell.postImageOutlet.sd_setImage(with: URL(string: data.newsPhoto[indexPath.row]))
//        cell.likesButtonOutlet.setTitle("\(data.newsLike.stringValue) likes", for: .normal)
//
//        cell.didTapComment = {
//            () in
//            self.delegate?.didTapComment(self.documents[indexPath.row])
//        }
//        return cell
    }
    
    
}

extension NewsView: UICollectionViewDelegate {
    
}

extension NewsView: NewsViewInput{
    func displayNews(_ data: [Post]?, _ documents: [QueryDocumentSnapshot], _ likeStates: [Bool]) {
        if let data = data{
            self.dataNews = data
            self.likeStates = likeStates
            self.newsCollection.reloadData()
        } else {return}
        self.documents = documents
    }
    
    
}

protocol NewsViewDelegate{
    func didTapComment(_ documents: QueryDocumentSnapshot?)
    func didLikePost(_ state: NewsCoreDataState, _ data: NewsLikeLocal, _ likeCount: Int, documentID: String)
}

protocol NewsViewInput{
    func displayNews(_ data: [Post]?, _ documents: [QueryDocumentSnapshot], _ likeStates: [Bool])
}

enum NewsCoreDataState {
    case delete, create
}
