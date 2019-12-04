//
//  DetailPeopleView.swift
//  Almate
//
//  Created by Qiarra on 08/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class DetailPeopleView: UIView {
    
    var dataPeople: LocalUsers? {
        didSet {
            if let name = dataPeople?.name {
                nameProfile.text = name
                companyNameProfile.text = dataPeople?.occupation
                currentLocation.text = dataPeople?.location
                aboutProfile.text = dataPeople?.about
                imgProfile.image = dataPeople?.imageUser
                skillsCollection.reloadData()
            }
        }
    }
    
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
        
//        nameProfile.text = dataPeople?.name
    }
}

extension DetailPeopleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.skillsCollection {
            return (dataPeople?.tagSkill!.count)!
        } else if collectionView == self.educationCollection {
            return arrayEducations.count
        } else if collectionView == self.workCollection {
            return arrayWorks.count
        } else if collectionView == self.referenceCollection {
            return arrayRefName.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.skillsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCell", for: indexPath) as! SkillCell
            cell.skillLabel.text = dataPeople?.tagSkill![indexPath.row]
            skillCount.text = "(\((dataPeople?.tagSkill!.count)!))"
            return cell
        } else if collectionView == self.educationCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "educationCell", for: indexPath) as! EducationCell
            cell.institutionEducation.text = arrayEducations[indexPath.row]
            cell.yearsEducation.text = arrayEducationYears[indexPath.row]
            return cell
        } else if collectionView == self.workCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "workCell", for: indexPath) as! WorkCell
            cell.imgWork.image = arrayWorks[indexPath.row]
            workCount.text = "(\(arrayWorks.count))"
            return cell
        } else if collectionView == self.referenceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "referenceCell", for: indexPath) as! ReferenceCell
            cell.imgProfileRef.image = arrayRefImg[indexPath.row]
            cell.lblGradProfileRef.text = arrayRefGrad[indexPath.row]
            cell.lblOccupProfileRef.text = arrayRefOccu[indexPath.row]
            cell.lblProfileRef.text = arrayRefName[indexPath.row]
            cell.textRef.text = arrayRefMsg[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
