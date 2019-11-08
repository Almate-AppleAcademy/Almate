//
//  PeopleView.swift
//  Almate
//
//  Created by Qiarra on 05/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleView: UIView {
    
    @IBOutlet weak var lblCountPeople: UILabel!
    @IBOutlet weak var peopleCollection: UICollectionView!
    var delegate: PeopleViewDelegate?
    
    override func awakeFromNib() {
        peopleCollection.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "peopleCell")
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
    }
}

extension PeopleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath as IndexPath) as! PeopleCell
        cell.namePeopleCell.text = "Munawaroh"
        cell.imgPeopleCell.image = UIImage(named: "profile")
        cell.genPeopleCelll.text = "FEB/17"
        cell.occupationPeopleCelll.text = "Kuli Bangunan"
        return cell
    }
}

extension PeopleView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.didSelectItemAt()
    }
}

protocol PeopleViewDelegate {
    func didSelectItemAt()
}

