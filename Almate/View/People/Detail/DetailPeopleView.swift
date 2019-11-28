//
//  DetailPeopleView.swift
//  Almate
//
//  Created by Qiarra on 08/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class DetailPeopleView: UIView {
    
    // MARK: People Data, u can set the label or others inside didSet
    var dataPeople: User? {
        didSet {
            if let data = dataPeople {
                self.nameProfile.text = "\(data.firstName) \(data.lastName)"
                self.companyNameProfile.text = data.userOccupation
                self.aboutProfile.text = data.userAbout
                self.imgProfile.sd_setImage(with: URL(string: data.userImage))
                self.skillCount.text = "(\(data.tagSkill.count))"
                self.skillsCollection.reloadData()
            }
        }
    }
    
    // MARK: PeopleContact, u can set the label or others inside didSet
    var dataPeopleContact: UserContact? {
        didSet {
            if let data = dataPeopleContact {
                self.currentLocation.text = data.userLocation
            }
        }
    }
    
    // MARK: People Education, u can set the label or others inside didSet
    var dataPeopleEducation: [Education]? {
        didSet {
            self.educationCollection.reloadData()
        }
    }
    
    // MARK: PeopleExperience
    var dataPeopleExperience: [Experience]? {
        didSet {
            self.experienceCollection.reloadData()
        }
    }
    
    // MARK: Perpare data List Reference and Users Reference
    var dataUsersReference: [User]? = []
    var dataReference: [Reference]? = []
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var linkedinBtn: UIButton!
    @IBOutlet weak var telponBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var companyNameProfile: UILabel!
    @IBOutlet weak var skillCount: UILabel!
    @IBOutlet weak var workCount: UILabel!
    @IBOutlet weak var referenceCount: UILabel!
    @IBOutlet weak var currentLocation: UILabel!
    @IBOutlet weak var aboutProfile: UITextView!
    
    @IBOutlet weak var skillsCollection: UICollectionView!
    @IBOutlet weak var referenceCollection: UICollectionView!
    @IBOutlet weak var educationCollection: UICollectionView!
    @IBOutlet weak var workCollection: UICollectionView!
    @IBOutlet weak var experienceCollection: UICollectionView!
    
    override func awakeFromNib() {
        skillsCollection.register(UINib(nibName: "SkillCell", bundle: nil), forCellWithReuseIdentifier: "skillCell")
        skillsCollection.dataSource = self
        
        educationCollection.register(UINib(nibName: "EducationCell", bundle: nil), forCellWithReuseIdentifier: "educationCell")
        educationCollection.dataSource = self
        
        workCollection.register(UINib(nibName: "WorkCell", bundle: nil), forCellWithReuseIdentifier: "workCell")
        workCollection.dataSource = self
        
        referenceCollection.register(UINib(nibName: "ReferenceCell", bundle: nil), forCellWithReuseIdentifier: "referenceCell")
        referenceCollection.dataSource = self
        
        experienceCollection.register(UINib(nibName: "ExperienceCollectionCell", bundle: nil), forCellWithReuseIdentifier: "experienceCollectionCell")
        experienceCollection.dataSource = self
    }
}

extension DetailPeopleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.skillsCollection {
            return (dataPeople?.tagSkill.count)!
        } else if collectionView == self.educationCollection {
            return dataPeopleEducation?.count ?? 0
        } else if collectionView == self.workCollection {
            return dataPeople?.work.count ?? 0
        } else if collectionView == self.referenceCollection {
            return dataUsersReference!.count
        } else if collectionView == self.experienceCollection {
            return dataPeopleExperience?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.skillsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCell", for: indexPath) as! SkillCell
            cell.skillLabel.text = dataPeople?.tagSkill[indexPath.row]
            return cell
        } else if collectionView == self.educationCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educationCell", for: indexPath) as! EducationCell
            if let dataEducation = dataPeopleEducation {
                let data = dataEducation[indexPath.row]
                cell.institutionEducation.text = data.educationName
                cell.yearsEducation.text = "\(data.educationYearStart) - \(data.educationYearEnd)"
                return cell
            } else {
                return cell
            }
        } else if collectionView == self.workCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workCell", for: indexPath) as! WorkCell
            cell.imgWork.sd_setImage(with: URL(string: (dataPeople?.work[indexPath.row])!))
            workCount.text = "(\(dataPeople?.work.count ?? 0))"
            return cell
        } else if collectionView == self.referenceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "referenceCell", for: indexPath) as! ReferenceCell
            if let data = dataUsersReference?[indexPath.row] {
                self.referenceCount.text = "(\(dataReference?.count ?? 0))"
                cell.imgProfileRef.sd_setImage(with: URL(string: data.userImage))
                cell.lblGradProfileRef.text = data.userGeneration
                cell.lblOccupProfileRef.text = data.userOccupation
                cell.lblProfileRef.text = "\(data.firstName) \(data.lastName)"
                cell.textRef.text = dataReference![indexPath.row].referenceText
            }
            return cell
        } else if collectionView == self.experienceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "experienceCollectionCell", for: indexPath) as! ExperienceCollectionCell
            if let data = dataPeopleExperience?[indexPath.row] {
                cell.experienceCompanyName.text = data.companyName
                cell.experiencePeriode.text = "\(data.dateStart) - \(data.dateEnd)"
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension DetailPeopleView: DetailPeopleViewInput {
    
    // MARK: People Reference Data, if u want to set it into cell u need to reload the collection first or if just Outlet u can set it
    func displayReference(_ dataReference: [Reference]?, _ dataUsers: [User]?) {
        self.dataUsersReference = dataUsers
        self.dataReference = dataReference
        self.referenceCollection.reloadData()
    }
}


protocol DetailPeopleViewInput {
    func displayReference(_ dataReference: [Reference]?,_ dataUsers: [User]?)
}
