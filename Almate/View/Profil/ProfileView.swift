//
//  ProfileView.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

var workAngka: Int = 5

class ProfileView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    var dataUser: User? {
        didSet {
//            referenceCollection.reloadData()
            if let data = dataUser {
                nameLbl.text = "\(data.firstName) \(data.lastName)"
                companyLbl.text = data.userOccupation
                profileImage.sd_setImage(with: URL(string: data.userImage))
            }
            workCollection.reloadData()
            skillCollection.reloadData()
        }
    }
    
    // MARK: PeopleContact, u can set the label or others inside didSet
    var dataPeopleContact: UserContact? {
        didSet {
            if let data = dataPeopleContact {
                self.locationLbl.text = data.userLocation
            }
        }
    }
    
    // MARK: People Education, u can set the label or others inside didSet
    var dataPeopleEducation: [Education]? {
        didSet {
            self.educationTable.reloadData()
        }
    }
    
    // MARK: PeopleExperience
    var dataPeopleExperience: [Experience]? {
        didSet {
            self.experienceTable.reloadData()
        }
    }
    
    // MARK: Perpare data List Reference and Users Reference
    var dataUsersReference: [User]? = []
    var dataReference: [Reference]? = []
    
        let skillTags = ["Swift", "Java", "C++", "Kotlin", "Ruby", "Sketch", "SAP HR"]
        let listIntitusi = ["Yale University", "SMAN 3 Jakarta"]
        let listTanggalInstitusi = ["2015 - 2019", "2012 - 2015"]
        let listPerusahaan = ["PT. Pertamina", "Apple Indonesia"]
        let listTanggalPerusahaan = ["Mar 2016 - Present", "2014 - 2016"]
        let listNamaAlumni = ["Rizal W.", "Abraham L.", "Mirza F.", "Lunggo S.F"]
        let listAngkatanAlumni = ["Cohort 1", "Cohort 2", "Cohort 2", "Cohort 1", "Cohort 2"]
        let listKerjaanAlumni = ["UX Designer", "UX Designer", "General Manager", "Product Manager", "Programmer"]
        let listJobTitle = ["UX Designer","Programmer", "Product Designer"]
        let listJobPerusahaan = ["Spotify", "Spotify", "Spotify"]
         let listLokasiPerusahaan = ["Jakarta", "Jakarta", "Jakarta"]
        
        
        @IBOutlet weak var transparentView: UIView!
        
        @IBOutlet weak var profileView: UIView!
        @IBOutlet weak var savedView: UIView!

      
        @IBOutlet weak var garisMenu: UIImageView!
        @IBOutlet weak var garisMenuDua: UIImageView!
        
        @IBOutlet weak var editBtn: UIButton!
        
        @IBOutlet weak var darkView: UIView!
        @IBOutlet weak var workCollection: UICollectionView!
        @IBOutlet weak var skillCollection: UICollectionView!
        @IBOutlet weak var educationTable: UITableView!
        @IBOutlet weak var experienceTable: UITableView!
        @IBOutlet weak var referenceCollection: UICollectionView!
        
        
        @IBOutlet weak var peopleListCollection: UICollectionView!
        @IBOutlet weak var jobsListCollection: UICollectionView!
        @IBOutlet weak var jobsSavedCollection: UICollectionView!
        
        @IBOutlet weak var workNumber: UILabel!
        @IBOutlet weak var aboutLbl: UILabel!
        @IBOutlet weak var linkedinBtn: UIButton!
        @IBOutlet weak var phoneBtn: UIButton!
        @IBOutlet weak var emailBtn: UIButton!
        @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
        override func awakeFromNib() {
            
            garisMenuDua.alpha = 0
            savedView.alpha = 0
            transparentView.alpha = 0.8
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = transparentView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            transparentView.addSubview(blurEffectView)
            
            
            
            skillCollection.register(UINib(nibName: "SkillProfileCell", bundle: nil), forCellWithReuseIdentifier: "skillProfileCell")
            workCollection.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
            educationTable.register(UINib(nibName: "EducationProfileCell", bundle: nil), forCellReuseIdentifier: "educationProfileCell")
            experienceTable.register(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: "experienceCell")
            referenceCollection.register(UINib(nibName: "ReferenceProfileCell", bundle: nil), forCellWithReuseIdentifier: "referenceProfileCell")
                
            peopleListCollection.register(UINib(nibName: "PeopleListCell", bundle: nil), forCellWithReuseIdentifier: "peopleListCell")
            jobsListCollection.register(UINib(nibName: "JobsListCell", bundle: nil), forCellWithReuseIdentifier: "jobsListCell")
            jobsSavedCollection.register(UINib(nibName: "JobsListCell", bundle: nil), forCellWithReuseIdentifier: "jobsListCell")
            
            skillCollection.dataSource = self
            skillCollection.delegate = self
            workCollection.dataSource = self
            workCollection.delegate = self
            experienceTable.dataSource = self
            experienceTable.delegate = self
            peopleListCollection.dataSource = self
            peopleListCollection.delegate = self
            jobsListCollection.dataSource = self
            jobsListCollection.delegate = self
            jobsSavedCollection.dataSource = self
            jobsSavedCollection.delegate = self
            referenceCollection.delegate = self
            referenceCollection.dataSource = self
            educationTable.dataSource = self
            
            
            

            aboutLbl.sizeToFit()
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let data = dataUser, let dataReference = dataReference {
                if collectionView == workCollection{
                    return data.work.count
                }else if collectionView == skillCollection{
                    return data.tagSkill.count
                }else if collectionView == referenceCollection{
                    return dataReference.count
                }else if collectionView == peopleListCollection {
                    return 4
                }else if collectionView == jobsListCollection{
                    return 3
                }else{
                    return 2
                }
            } else {
                return 0
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let data = dataUser, let dataReference = dataReference, let dataPeople = dataUsersReference {
                if collectionView == workCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath as IndexPath) as! ProfileCell
                    workNumber.text = "(\(data.work.count))"
                    cell.workButton.imageView?.sd_setImage(with: URL(string: data.work[indexPath.row]))
                return cell
                } else if collectionView == skillCollection{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillProfileCell", for: indexPath) as! SkillProfileCell
                    cell.skillLbl.text = data.tagSkill[indexPath.row]
                    return cell
                }else if collectionView == referenceCollection{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "referenceProfileCell", for: indexPath) as! ReferenceProfileCell
                    cell.namaUser.text = "\(dataPeople[indexPath.row].firstName) \(dataPeople[indexPath.row].lastName)"
                    cell.angkatanUser.text = dataPeople[indexPath.row].userGeneration
                    cell.quoteUser.text = dataReference[indexPath.row].referenceText
                    cell.userImg.sd_setImage(with: URL(string: dataPeople[indexPath.row].userImage))
                    return cell
                }else if collectionView == peopleListCollection{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleListCell", for: indexPath as IndexPath) as! PeopleListCell
                    cell.nameLbl.text = listNamaAlumni[indexPath.row]
                    cell.angkatanLbl.text = listAngkatanAlumni[indexPath.row]
                    cell.jobTitleLbl.text = listKerjaanAlumni[indexPath.row]
                    
                    return cell
                }else if collectionView == jobsListCollection{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobsListCell", for: indexPath as IndexPath) as! JobsListCell
                    cell.jobTitleLbl.text = listJobTitle[indexPath.row]
                    cell.companyLbl.text = listJobPerusahaan[indexPath.row]
                    cell.locationLbl.text = listLokasiPerusahaan[indexPath.row]
                    return cell
                }else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobsListCell", for: indexPath as IndexPath) as! JobsListCell
                    cell.jobTitleLbl.text = listJobTitle[indexPath.row]
                    cell.companyLbl.text = listJobPerusahaan[indexPath.row]
                    cell.locationLbl.text = listLokasiPerusahaan[indexPath.row]
                    return cell
                }
            } else {
                return UICollectionViewCell()
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let dataExperience = dataPeopleExperience, let dataEducation = dataPeopleEducation {
                if tableView == educationTable {
                    return dataEducation.count
                } else if tableView == experienceTable {
                    return dataExperience.count
                } else {
                    return 0
                }
            } else {
                return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let dataEducation = dataPeopleEducation, let dataExperience = dataPeopleExperience {
                if tableView == educationTable {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "educationProfileCell", for: indexPath as IndexPath) as! EducationProfileCell
                    cell.institusiLbl.text = dataEducation[indexPath.row].educationName
                    cell.tanggalLbl.text = "\(dataEducation[indexPath.row].educationYearStart) - \(dataEducation[indexPath.row].educationYearEnd)"
                    return cell
                } else if tableView == experienceTable {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath as IndexPath) as! ExperienceCell
                    cell.perusahaanLbl.text = dataExperience[indexPath.row].companyName
                    cell.tanggalLbl.text =  "\(dataExperience[indexPath.row].dateStart) - \(dataExperience[indexPath.row].dateEnd)"
                    return cell
                } else {
                     let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath as IndexPath) as! ExperienceCell
                               return cell
                }
            } else {
                return UITableViewCell()
            }
        }
        /*
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func draw(_ rect: CGRect) {
            // Drawing code
        }
        */

}

extension ProfileView: ProfileViewInput {
    func displayReference(_ dataReference: [Reference]?, _ dataUsers: [User]?) {
        if let dataReference = dataReference, let dataUsers = dataUsers {
            self.dataUsersReference = dataUsers
            self.dataReference = dataReference
            self.referenceCollection.reloadData()
        }
    }
}

protocol ProfileViewInput {
    func displayReference(_ dataReference: [Reference]?,_ dataUsers: [User]?)
}
