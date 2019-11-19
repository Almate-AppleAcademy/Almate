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
    var dataPeople: [Users]?
    var delegate: PeopleViewDelegate?
    
    override func awakeFromNib() {
        peopleCollection.register(UINib(nibName: "PeopleCell", bundle: nil), forCellWithReuseIdentifier: "peopleCell")
        peopleCollection.dataSource = self
        peopleCollection.delegate = self
        peopleCount.text = "20 people in Apple Academy"
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
            //        cell.btnSaveContact.imageView?.image = UIImage(named: "save-filled")
            let _: UIImage = cell.btnSaveContact.currentImage ?? UIImage(named: "save-unfilled")!
            cell.didTapSaveContact = { () in
                var localState = userLocal[indexPath.row]
                let data = Users(email: "myEmail@gg.me", idUser: "12-\(userName[indexPath.row])", name: userName[indexPath.row], generation: userGrad[indexPath.row], occupation: userOccu[indexPath.row], local: !localState,skills: [userOccu[indexPath.row]], image: userImage[indexPath.row]!)
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

extension PeopleView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.didSelectItemAt()
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
    func didSelectItemAt()
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
