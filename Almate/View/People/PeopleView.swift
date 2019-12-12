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
    var dataPeopleSaved: [UserLocal] = []
    var likeStates: [Bool] = []
    var documents: [QueryDocumentSnapshot]?
    var didLike: Bool?
    
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
        cell.namePeopleCell.text = "\(data.firstName) \(data.lastName)"
        cell.genPeopleCelll.text = data.userGeneration
        cell.occupationPeopleCelll.text = data.userOccupation
        cell.imgPeopleCell.sd_setImage(with: URL(string: data.userImage))
        cell.skillData(data.tagSkill)
        if likeStates.count == 0 {
            cell.btnSaveContact.setImage(UIImage(named: "save-unfilled"), for: .normal)
        } else {
            if likeStates[indexPath.row] {
                cell.btnSaveContact.setImage(UIImage(named: "save-filled"), for: .normal)
            } else { cell.btnSaveContact.setImage(UIImage(named: "save-unfilled"), for: .normal) }
        }
        cell.didTapSaveContact = {
            () in
            let userId = self.documents![indexPath.row]
            let data =
                UserLocal(fullname: "\(data.firstName) \(data.lastName)", userGraduation: data.userGeneration,
                          userOccupation: data.userOccupation, userSkills: NSArray(array: data.tagSkill) as! [NSString], userImage: ((cell.imgPeopleCell!.image?.pngData())!), userId: userId.documentID)
            let cell = collectionView.cellForItem(at: indexPath) as? PeopleCell
            if self.likeStates.count != 0 && self.likeStates[indexPath.row] {
                cell?.btnSaveContact.setImage(UIImage(named: "save-unfilled"), for: .normal)
                self.delegate?.tappedSaveContact(.delete, data)
                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
            } else {
                self.delegate?.tappedSaveContact(.create, data)
                cell?.btnSaveContact.setImage(UIImage(named: "save-filled"), for: .normal)
                self.likeStates[indexPath.row] = !self.likeStates[indexPath.row]
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
    func getPeopleSaved(_ data: [UserLocal]?) {
        if let data = data {
            self.dataPeopleSaved = data
        }
    }
    
    func displayPeople(_ data: [User]?,_ documents: [QueryDocumentSnapshot], _ likeStates: [Bool]) {
        if let data = data {
            self.dataPeople = data
            self.likeStates = likeStates
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
    func displayPeople(_ data: [User]?, _ documents: [QueryDocumentSnapshot], _ likeStates: [Bool])
    func getPeopleSaved(_ data: [UserLocal]?)
}

enum UserCoreDataState {
    case delete, create
}
