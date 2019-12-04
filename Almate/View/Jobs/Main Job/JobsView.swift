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
        cell.jobLocation.text = jobLocation[indexPath.row]
        cell.jobTitle.text = jobTitle[indexPath.row]
        cell.companyName.text = companyName[indexPath.row]
        cell.jobPicture.image = logoImage[indexPath.row]
        cell.didTapSaveContact = {
            () in
            print("job-2")
            var localState = userLocalJob[indexPath.row]
            let data = LocalAdmin(email: "jobEmail\(indexPath.row)@gg.me", password: "password-ex\(indexPath.row)")
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
    func tappedSaveJob(_ state: UserCoreDataState,_ data: LocalAdmin)
    func didSelectItemAt()
    func didTapPostJob()
}

let userLocalJob = [false, false, false, false, false, false, false, false, false, false]

let jobTitle = ["IOS Developer", "UX Engineer", "UI Designer", "Product Owner", "Senior Software Developer", "IOS Developer", "UI DEsigner", "Project Manager", "UI Designer", "IOS Developer", "Bussiness Analyst", "Co-Founder"]

let companyName = ["Tokopedia", "Traveloka", "BCA", "Gojek", "Shopee", "Bukalapak", "Tiket.com", "MyRepublic", "Airbnb", "Twitter", "OLX", "blibli"]

let logoImage = [UIImage(named:"Photo 27-10-19 18.08.15"), UIImage(named:"Photo 27-10-19 18.08.43"), UIImage(named:"Photo 27-10-19 18.09.23"), UIImage(named:"Photo 27-10-19 18.10.11"), UIImage(named:"Photo 27-10-19 18.13.33"), UIImage(named:"Photo 27-10-19 18.17.20"), UIImage(named:"Photo 27-10-19 18.18.40"), UIImage(named:"Photo 27-10-19 20.14.56"), UIImage(named:"Photo 27-10-19 20.17.31"), UIImage(named:"Photo 27-10-19 20.17.57"), UIImage(named:"Photo 27-10-19 23.19.30"), UIImage(named:"Photo 27-10-19 23.19.59")]

let jobLocation = ["Jakarta, Indonesia", "Jakarta,Indonesia", "Bandung, Indonesia", "Jakarta,Indonesi", "Jakarta,Indonesi", "Jakarta,Indonesi", "Bandung, Indonesia", "Surabaya, Indonesia", "Bekasi, Indonesia", "Kalimantan, Indonesia", "Bali, Indonesia", "Jogja, Indonesia"]
