//
//  JobsView.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 07/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobsView: UIView {

    @IBOutlet var jobListTable: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        jobListTable.register(UINib(nibName: "JobCell", bundle: nil), forCellWithReuseIdentifier: "jobCell")
//        jobListTable.delegate = self as! UICollectionViewDelegate
        jobListTable.dataSource = self
        
    }
}

extension JobsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath as IndexPath) as! JobCell
        cell.jobLocation.text = "msfasl"
        return cell
    }
    
    
}

extension JobsView: UICollectionViewDelegate {
    
}
