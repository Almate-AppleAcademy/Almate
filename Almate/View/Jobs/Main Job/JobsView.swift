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
    @IBOutlet var postJobBtn: UIButton!
    var jobDelegate: JobDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        jobListTable.register(UINib(nibName: "JobCell", bundle: nil), forCellWithReuseIdentifier: "jobCell")
        jobListTable.delegate = self
        jobListTable.dataSource = self
        
    }
    @IBAction func postJobBtn(_ sender: UIButton) {
        post()
    }
}

extension JobsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath as IndexPath) as! JobCell
        cell.jobLocation.text = "Jakarta"
        cell.didTapSaveContact = {
            () in
            print("job-2")
            var localState = userLocalJob[indexPath.row]
            let data = Admin(email: "jobEmail\(indexPath.row)@gg.me", password: "password-ex\(indexPath.row)")
            if (!localState) {
                localState = !localState
                print("job-2")
                self.jobDelegate?.tappedSaveJob(.create, data)
                //TODO : Change image Save Button
            } else {
                localState = !localState
                self.jobDelegate?.tappedSaveJob(.delete, data)
                //TODO : Change image Save Button
                print("unfilled")
            }
        }
        return cell
    }
}

extension JobsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        jobDelegate?.didSelectItemAt()
    }
    func post(){
        jobDelegate?.didTapPostJob()
    }
}

protocol JobDelegate {
    func tappedSaveJob(_ state: UserCoreDataState,_ data: Admin)
    func didSelectItemAt()
    func didTapPostJob()
}

let userLocalJob = [false, false, false, false, false, false, false, false, false, false]
