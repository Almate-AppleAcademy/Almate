//
//  PeopleView.swift
//  Almate
//
//  Created by Qiarra on 05/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleView: UIView {
    
    @IBOutlet weak var peopleCollection: UICollectionView!
    @IBOutlet weak var peopleCount: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    var dataPeople: [Users]?
    var delegate: PeopleViewDelegate?
    
    override func awakeFromNib() {
        peopleCollection.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "peopleCell")
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
        peopleCount.text = "20 people in Apple Academy"
        headerView.isUserInteractionEnabled = true
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
        return dataPeople!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = dataPeople?[indexPath.row] {
            peopleCount.text = "\(dataPeople!.count) people in Apple Academy"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell", for: indexPath as IndexPath) as! PeopleCell
            cell.namePeopleCell.text = data.name
            cell.imgPeopleCell.image = data.imageUser
            cell.genPeopleCelll.text = data.generation
            cell.occupationPeopleCelll.text = data.occupation
            cell.arraySkills = data.tagSkill
            //        cell.btnSaveContact.imageView?.image = UIImage(named: "save-filled")
            let _: UIImage = cell.btnSaveContact.currentImage ?? UIImage(named: "save-unfilled")!
            cell.didTapSaveContact = { () in
                var localState = userLocal[indexPath.row]
                let data = Users(email: "myEmail@gg.me", idUser: "12-\(userName[indexPath.row])", name: userName[indexPath.row], generation: userGrad[indexPath.row], occupation: userOccu[indexPath.row], local: !localState, about: about[indexPath.row], linkedIn: linkedInLink[indexPath.row], noPhone: "081711128121", location: location[indexPath.row], skills: [userOccu[indexPath.row]], image: userImage[indexPath.row]!)
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
        } else {
            return UICollectionViewCell()
        }
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
    
    }
    
    
}

extension PeopleView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.didSelectItemAt(self.dataPeople?[indexPath.row])
    }
}

extension PeopleView: PeopleInput {
    func displayDataPeople(data: [Users]) {
        self.dataPeople = data
        self.peopleCollection.reloadData()
    }
}

protocol PeopleInput {
    func displayDataPeople(data: [Users])
}

protocol PeopleViewDelegate {
    func didSelectItemAt(_ detailPeopleData: Users?)
    func didTapProfileIcon()
    func tappedSaveContact(_ state: UserCoreDataState,_ data: Users)
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
