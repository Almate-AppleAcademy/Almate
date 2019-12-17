//
//  JobsView.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 07/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class JobsView: UIView {
    
    @IBOutlet var jobListTable: UICollectionView!
    @IBOutlet var postJobBtn: UIButton!
    var jobDelegate: JobDelegate?
    @IBOutlet var filterButton: UIButton!
    
    var likesState: [Bool] = []
    var documents: [QueryDocumentSnapshot]?
    var jobsData: [Job]?
    var didLike = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        jobListTable.register(UINib(nibName: "JobCell", bundle: nil), forCellWithReuseIdentifier: "jobCell")
        jobListTable.allowsMultipleSelection = true
        jobListTable.dataSource = self
        jobListTable.delegate = self
        
//        filterButton.layer.shadowColor = UIColor.black.cgColor
//        filterButton.layer.shadowOffset = CGSize(width: 0, height: 3)
//        filterButton.layer.shadowRadius = 7.0
//        filterButton.layer.shadowOpacity = 20/100
//        filterButton.layer.cornerRadius = 20
    }
    @IBAction func postJobBtn(_ sender: UIButton) {
        jobDelegate?.didTapPostJob()
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
            if likesState.count == 0 {
                cell.bookmarkBtn.setImage(UIImage(named: "save-unfilled"), for: .normal)
            } else {
                if likesState[indexPath.row] {
                    cell.bookmarkBtn.setImage(UIImage(named: "save-filled"), for: .normal)
                } else { cell.bookmarkBtn.setImage(UIImage(named: "save-unfilled"), for: .normal) }
            }
            cell.didTapSaveContact = {
                (button) in
                let data = JobLocal(jobTitle: data.jobTitle, companyName: data.jobCompanyName, companyLocation: data.jobLocation, companyImage: (cell.jobPicture.image?.pngData())!, documentID: self.documents![indexPath.row].documentID)
                
                print(self.documents![indexPath.row].documentID)
                if self.likesState.count != 0 && self.likesState[indexPath.row] {
                    cell.bookmarkBtn.setImage(UIImage(named: "save-unfilled"), for: .normal)
                    self.jobDelegate?.tappedSaveJob(.delete, data)
                    self.likesState[indexPath.row] = !self.likesState[indexPath.row]
                } else {
                    cell.bookmarkBtn.setImage(UIImage(named: "save-filled"), for: .normal)
                    self.jobDelegate?.tappedSaveJob(.create, data)
                    self.likesState[indexPath.row] = !self.likesState[indexPath.row]
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
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return (collectionView.indexPathsForSelectedItems?.count ?? 0) < 2
    }
}

extension JobsView: JobViewInput {
    func displayJobs(_ data: [Job]?, documents: [QueryDocumentSnapshot], _ likeState: [Bool]) {
        if let data = data {
            self.jobsData = data
            self.likesState = likeState
            self.jobListTable.reloadData()
        } else { return }
        self.documents = documents
    }
}

protocol JobDelegate {
    func tappedSaveJob(_ state: UserCoreDataState,_ data: JobLocal)
    func didSelectItemAt()
    func didTapPostJob()
    func didTapDetailJob(dataJob: Job)
}

protocol JobViewInput {
    func displayJobs(_ data: [Job]?, documents: [QueryDocumentSnapshot],_ likeState: [Bool])
}

let userLocalJob = [false, false, false, false, false, false, false, false, false, false]

let jobTitle = ["IOS Developer", "UX Engineer", "UI Designer", "Product Owner", "Senior Software Developer", "IOS Developer", "UI DEsigner", "Project Manager", "UI Designer", "IOS Developer", "Bussiness Analyst", "Co-Founder"]

let companyName = ["Tokopedia", "Traveloka", "BCA", "Gojek", "Shopee", "Bukalapak", "Tiket.com", "MyRepublic", "Airbnb", "Twitter", "OLX", "blibli"]

let logoImage = [UIImage(named:"Photo 27-10-19 18.08.15"), UIImage(named:"Photo 27-10-19 18.08.43"), UIImage(named:"Photo 27-10-19 18.09.23"), UIImage(named:"Photo 27-10-19 18.10.11"), UIImage(named:"Photo 27-10-19 18.13.33"), UIImage(named:"Photo 27-10-19 18.17.20"), UIImage(named:"Photo 27-10-19 18.18.40"), UIImage(named:"Photo 27-10-19 20.14.56"), UIImage(named:"Photo 27-10-19 20.17.31"), UIImage(named:"Photo 27-10-19 20.17.57"), UIImage(named:"Photo 27-10-19 23.19.30"), UIImage(named:"Photo 27-10-19 23.19.59")]

let jobLocation = ["Jakarta, Indonesia", "Jakarta,Indonesia", "Bandung, Indonesia", "Jakarta,Indonesi", "Jakarta,Indonesi", "Jakarta,Indonesi", "Bandung, Indonesia", "Surabaya, Indonesia", "Bekasi, Indonesia", "Kalimantan, Indonesia", "Bali, Indonesia", "Jogja, Indonesia"]
