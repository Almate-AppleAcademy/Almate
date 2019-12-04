//
//  PeopleView.swift
//  Almate
//
//  Created by Qiarra on 05/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseFirestore

class PeopleView: UIView {
    
    @IBOutlet weak var peopleCollection: UICollectionView!
    @IBOutlet weak var peopleCount: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    var delegate: PeopleViewDelegate?
    var dataPeople: [User] = []
    var documents: [QueryDocumentSnapshot]?
    
    override func awakeFromNib() {
        peopleCollection.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "peopleCell")
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
        peopleCount.text = "20 people in Apple Academy"
        
        filterButton.layer.shadowColor = UIColor.black.cgColor
        filterButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        filterButton.layer.shadowRadius = 7.0
        filterButton.layer.shadowOpacity = 20/100
        filterButton.layer.cornerRadius = 20
        
       // headerView.isUserInteractionEnabled = true
    }
    
    @IBAction func tapProfile(_ sender: UIButton) {
        print("hilih gi")
    }
    
    @IBAction func taapProfile(_ sender: UIButton) {
        delegate?.didTapProfileIcon()
        print("hilih gi")
    }
    
}

extension PeopleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPeople.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath as IndexPath) as! PeopleCell
        let data = dataPeople[indexPath.row]
        cell.namePeopleCell.text = "\(data.firstName) \(data.lastName) "
//        cell.imgPeopleCell.image = userImage[indexPath.row]
        cell.genPeopleCelll.text = data.userGeneration
        cell.occupationPeopleCelll.text = data.userOccupation
        cell.imgPeopleCell.sd_setImage(with: URL(string: data.userImage))
        cell.skillData(data.tagSkill)
//        cell.btnSaveContact.imageView?.image = UIImage(named: "save-filled")
        let _: UIImage = cell.btnSaveContact.currentImage ?? UIImage(named: "save-unfilled")!
        cell.didTapSaveContact = {
            () in
            var localState = userLocal[indexPath.row]
            let data =
                UserLocal(fullname: "\(data.firstName) \(data.lastName)", userGraduation: data.userGeneration,
                          userOccupation: data.userOccupation, userSkills: data.tagSkill, userImage: ((cell.imgPeopleCell!.image?.pngData())!))
//            (profileimg?.image)!.pngData()
            if (!localState) {
                localState = !localState
                self.delegate?.tappedSaveContact(.create, data)
                let cell = collectionView.cellForItem(at: indexPath) as? PeopleCell
                cell?.btnSaveContact.imageView?.image = UIImage(named: "save-filled")
            } else {
                localState = !localState
                cell.btnSaveContact.imageView?.image = UIImage(named: "save-unfilled")
                self.delegate?.tappedSaveContact(.delete, data)
                print("unfilled")
            }
        }
        return cell
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
    
    }
    
    
}

extension PeopleView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.didSelectItemAt(dataPeople[indexPath.row], self.documents![indexPath.row])
    }
}

extension PeopleView: PeopleViewInput {
    func displayPeople(_ data: [User]?,_ documents: [QueryDocumentSnapshot]) {
        if let data = data {
            self.dataPeople = data
            self.peopleCollection.reloadData()
        } else { return }
        self.documents = documents
    }
}

protocol PeopleViewDelegate {
    func didSelectItemAt(_ dataPeople: User, _ documents: QueryDocumentSnapshot)
    func didTapProfileIcon()
    func tappedSaveContact(_ state: UserCoreDataState,_ data: UserLocal)
}

protocol PeopleViewInput {
    func displayPeople(_ data: [User]?, _ documents: [QueryDocumentSnapshot])
}

enum UserCoreDataState {
    case delete, create
}

let userName = ["Thomas Raharja", "Chandrawinata", "Gilang Kesuma", "Jeje Iskandar", "Tiberias Jaya", "Kirana Ginanjar", "Thomas Raharja", "Chandrawinata", "Gilang Kesuma", "Jeje Iskandar", "Tiberias Jaya", "Kirana Ginanjar"]

let userGrad = ["Cohort 1", "Cohort 2", "Cohort 1", "Cohort 2", "Cohort 1", "Cohort 2", "Cohort 1", "Cohort 2", "Cohort 1", "Cohort 2", "Cohort 1", "Cohort 2"]

let userImage = [UIImage(named:"Photo 28-10-19 02.23.51"), UIImage(named:"Photo 27-10-19 23.36.41"), UIImage(named:"Photo 27-10-19 23.36.17"), UIImage(named:"profile"), UIImage(named:"tiny-profile"), UIImage(named:"Photo 28-10-19 02.23.51"), UIImage(named:"Photo 27-10-19 23.36.41"), UIImage(named:"Photo 27-10-19 23.36.17"), UIImage(named:"profile"), UIImage(named:"tiny-profile"), UIImage(named:"Photo 28-10-19 02.23.51"), UIImage(named:"Photo 27-10-19 23.36.41")]

let userOccu = ["Software Engineer", "Fullstack Developer", "Project Manager", "Quality Asurance", "CTO", "UI/UX Designer", "Mobile Apps Developer", "Data Analyst", "Software Engineer", "Fullstack Developer", "Project Manager", "Quality Asurance"]

let userLocal = [false, false, false, false, false, false, false, false, false, false, false, false]

let userEmail = ["ThomasRaharja@gmail.com", "Chandrawinata@gmail.com", "GilangKesuma@gmail.com", "JejeIskandar@gmail.com", "TiberiasJaya@gmail.com", "KiranaGinanjar@gmail.com", "ThomasRaharja@gmail.com", "Chandrawinata@gmail.com", "GilangKesuma@gmail.com", "JejeIskandar@gmail.com", "TiberiasJaya@gmail.com", "KiranaGinanjar@gmail.com"]

let about = [
    "I’m a seasoned and award-winning agency creative — a passionate leader with a proven track record for translating complex ideas into slick, successful campaigns.",
    "I’ve managed and motivated interdisciplinary teams, both as official in-house go-to gal and A-list agency hotshot.",
    "I’ve built and managed brands from the ground up, worn every hat on the rack, and leapt tall buildings in a single bound",
    "I’m a seasoned and award-winning agency creative — a passionate leader with a proven track record for translating complex ideas into slick, successful campaigns.",
    "I’ve managed and motivated interdisciplinary teams, both as official in-house go-to gal and A-list agency hotshot.",
    "I’ve built and managed brands from the ground up, worn every hat on the rack, and leapt tall buildings in a single bound",
    "I’m a seasoned and award-winning agency creative — a passionate leader with a proven track record for translating complex ideas into slick, successful campaigns.",
    "I’ve managed and motivated interdisciplinary teams, both as official in-house go-to gal and A-list agency hotshot.",
    "I’ve built and managed brands from the ground up, worn every hat on the rack, and leapt tall buildings in a single bound",
    "I’m a seasoned and award-winning agency creative — a passionate leader with a proven track record for translating complex ideas into slick, successful campaigns.",
    "I’ve managed and motivated interdisciplinary teams, both as official in-house go-to gal and A-list agency hotshot.",
    "I’ve built and managed brands from the ground up, worn every hat on the rack, and leapt tall buildings in a single bound"]

let linkedInLink = [
    "https://www.linkedin.com/in/alfian-losari-94357948/", "https://www.linkedin.com/in/mikitani/", "https://www.linkedin.com/in/williamhgates/", "https://www.linkedin.com/in/alfian-losari-94357948/", "https://www.linkedin.com/in/mikitani/", "https://www.linkedin.com/in/williamhgates/","https://www.linkedin.com/in/alfian-losari-94357948/", "https://www.linkedin.com/in/mikitani/", "https://www.linkedin.com/in/williamhgates/","https://www.linkedin.com/in/alfian-losari-94357948/", "https://www.linkedin.com/in/mikitani/", "https://www.linkedin.com/in/williamhgates/"
]

let location = [
    "Jakarta", "Semarang", "Malang", "Sumedang", "New Jersey", "Kendal", "Manila", "Tokyo", "Brazillia", "Abu Dhabi", "Budappest", "Bali"
]

let skills = [
    ["Java", "C++", "Ai", "Cordova"], ["Javascript", "CSS", "Python"], ["Swift", "Ruby", "Cisco", "Mikrotik"], ["Java", "C++", "Ai", "Cordova"], ["Javascript", "CSS", "Python"], ["Swift", "Ruby", "Cisco", "Mikrotik"], ["Java", "C++", "Ai", "Cordova"], ["Javascript", "CSS", "Python"], ["Swift", "Ruby", "Cisco", "Mikrotik"], ["Java", "C++", "Ai", "Cordova"], ["Javascript", "CSS", "Python"], ["Swift", "Ruby", "Cisco", "Mikrotik"]
]
