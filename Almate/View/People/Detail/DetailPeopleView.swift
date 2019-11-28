//
//  DetailPeopleView.swift
//  Almate
//
//  Created by Qiarra on 08/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class DetailPeopleView: UIView {
    
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
    
    var dataPeopleContact: UserContact? {
        didSet {
            if let data = dataPeopleContact {
                self.currentLocation.text = data.userLocation
            }
        }
    }
    
    var dataPeopleEducation: [Education]? {
        didSet {
            self.educationCollection.reloadData()
        }
    }
    
    var dataPeopleExperience: [Experience]? {
        didSet {
            self.experienceCollection.reloadData()
        }
    }
    
    var dataPeopleReference: [Reference]? {
        didSet {
            self.referenceCollection.reloadData()
        }
    }
    
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
    
    let arraySkills = ["Swift", "Java", "Kotlin", "Asyncrhonus", "Firestore", "Cocoapods", "J-Pop"]
    let arrayEducations = ["Universitas Indonesia", "SMAN 3 Semarang"]
    let arrayEducationYears = ["2016 - 2020", "2013 - 2016"]
    let arrayWorks = [UIImage(named: "karya1"), UIImage(named: "karya2"),UIImage(named: "karya1"), UIImage(named: "karya2") ]
    let arrayRefName = ["Slamet Riyadi", "Gentar Chandrawinata"]
    let arrayRefImg = [UIImage(named: "profile"), UIImage(named: "tiny-profile")]
    let arrayRefGrad = ["Cohort 2", "Cohort 1"]
    let arrayRefOccu = ["Software Engineer", "iOS Developer"]
    let arrayRefMsg = ["Beliau merupakan orang yang sangat menekuni bidangnya. Leader yang hebat dan bertalenta","Sukses membawa tim kami menyelesaikan belasan project merupakan pencapaian yang luar biasa. Berpengalaman dan Critical Thinking"]
    
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
            let dataUser = dataUsersReference![indexPath.row]
            self.referenceCount.text = "(\(dataReference?.count ?? 0))"
            cell.imgProfileRef.sd_setImage(with: URL(string: dataUser.userImage))
            cell.lblGradProfileRef.text = dataUser.userGeneration
            cell.lblOccupProfileRef.text = dataUser.userOccupation
            cell.lblProfileRef.text = "\(dataUser.firstName) \(dataUser.lastName)"
            return cell
        } else if collectionView == self.experienceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "experienceCollectionCell", for: indexPath) as! ExperienceCollectionCell
            let data = dataPeopleExperience![indexPath.row]
            cell.experienceCompanyName.text = data.companyName
            cell.experiencePeriode.text = "\(data.dateStart) - \(data.dateEnd)"
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension DetailPeopleView: DetailPeopleViewInput {
    func displayReference(_ dataReference: [Reference]?, _ dataUsers: [User]?) {
        self.dataUsersReference = dataUsers
        self.dataReference = dataReference
        self.referenceCollection.reloadData()
    }
}


protocol DetailPeopleViewInput {
    func displayReference(_ dataReference: [Reference]?,_ dataUsers: [User]?)
}
