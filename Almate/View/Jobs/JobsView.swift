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
    var jobDelegate: JobDelegate?
    
    var jobsData: [Job]?  {
        didSet {
            self.jobListTable.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        jobListTable.register(UINib(nibName: "JobCell", bundle: nil), forCellWithReuseIdentifier: "jobCell")
        jobListTable.dataSource = self
        jobListTable.delegate = self
    }
}

extension JobsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath as IndexPath) as! JobCell
        if let jobsData = jobsData {
            let data = jobsData[indexPath.row]
            cell.jobLocation.text = data.jobLocation
            cell.jobTitle.text = data.jobTitle
            cell.companyName.text = data.jobCompanyName
            cell.jobPicture.sd_setImage(with: URL(string: data.jobCompanyLogo))
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
        } else {
            // MARK: - ERROR HANDLING IF DATA NOT FOUND
        }
        return cell
    }
}

extension JobsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if let jobsData = jobsData {
            jobDelegate?.didTapDetailJob(dataJob: jobsData[indexPath.row])
        }
    }
}

protocol JobDelegate {
    func tappedSaveJob(_ state: UserCoreDataState,_ data: Admin)
    func didTapDetailJob(dataJob: Job)
}

let userLocalJob = [false, false, false, false, false, false, false, false, false, false]
