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
    var delegate: PeopleViewDelegate?
    var dataPeople: [User] = []
    var documents: [QueryDocumentSnapshot]?
    
    override func awakeFromNib() {
        peopleCollection.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "peopleCell")
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
        peopleCount.text = "20 people in Apple Academy"
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

extension PeopleView: UICollectionViewDelegate {
    
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
