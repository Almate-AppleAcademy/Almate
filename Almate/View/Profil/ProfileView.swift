//
//  ProfileView.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

var workAngka: Int = 5

class ProfileView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var workCollection: UICollectionView!
    @IBOutlet weak var workNumber: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var linkedinBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    
    override func awakeFromNib() {
        
        print("hehe")
        
        workNumber.text = "(\(workAngka))"
    workCollection.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        workCollection.dataSource = self
        workCollection.delegate = self
        
        

        aboutLbl.sizeToFit()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workAngka
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath as IndexPath) as! ProfileCell
        return cell
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
