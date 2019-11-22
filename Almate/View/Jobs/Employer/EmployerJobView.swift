//
//  EmployerJobView.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 19/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerJobView: UIView {

    @IBOutlet var jobOpeningsTable: UICollectionView!
    var jobOpeningsDelegate: JobOpeningsDelegate?
    @IBOutlet var postAJobBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        jobOpeningsTable.register(UINib(nibName: "JobEmployerCell", bundle: nil), forCellWithReuseIdentifier: "jobEmployerCell")
        jobOpeningsTable.delegate = self
        jobOpeningsTable.dataSource = self
    }
    @IBAction func postAJobBtn(_ sender: Any) {
        tapPost()
    }
    
}

extension EmployerJobView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobEmployerCell", for: indexPath as IndexPath) as! JobEmployerCell
       
        cell.didtapEdit = {
            () in
            self.tapEdit()
        }
        return cell
    }
    
}

extension EmployerJobView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        jobOpeningsDelegate?.didSelectItemAt()
    }
    func tapEdit(){
        jobOpeningsDelegate?.didTappedEdit()
    }
    func tapPost(){
        jobOpeningsDelegate?.didTappedPostJob()
    }
}

protocol JobOpeningsDelegate{
    func didSelectItemAt()
    func didTappedEdit()
    func didTappedPostJob()
}
