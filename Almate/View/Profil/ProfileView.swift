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
    
    override func awakeFromNib() {
        
        garisMenuDua.alpha = 0
        savedView.alpha = 0
        
        workNumber.text = "(\(workAngka))"
    workCollection.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        educationTable.register(UINib(nibName: "EducationCell", bundle: nil), forCellReuseIdentifier: "educationCell")
        experienceTable.register(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: "experienceCell")
        referenceCollection.register(UINib(nibName: "ReferenceCell", bundle: nil), forCellWithReuseIdentifier: "referenceCell")
            
        peopleListCollection.register(UINib(nibName: "PeopleListCell", bundle: nil), forCellWithReuseIdentifier: "peopleListCell")
        jobsListCollection.register(UINib(nibName: "JobsListCell", bundle: nil), forCellWithReuseIdentifier: "jobsListCell")
        jobsSavedCollection.register(UINib(nibName: "JobsListCell", bundle: nil), forCellWithReuseIdentifier: "jobsListCell")
        
        
        
        
        workCollection.dataSource = self
        workCollection.delegate = self
        educationTable.dataSource = self
        educationTable.delegate = self
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
        
        
        

        aboutLbl.sizeToFit()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workCollection{
            return workAngka
        }else if collectionView == referenceCollection{
            return 1
        }else if collectionView == peopleListCollection{
            return 4
        }else if collectionView == jobsListCollection{
            return 3
        }else{
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == workCollection{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath as IndexPath) as! ProfileCell
        return cell
        }else if collectionView == referenceCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "referenceCell", for: indexPath) as! ReferenceCell
            return cell
        }else if collectionView == peopleListCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleListCell", for: indexPath as IndexPath) as! PeopleListCell
            return cell
        }else if collectionView == jobsListCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobsListCell", for: indexPath as IndexPath) as! JobsListCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jobsListCell", for: indexPath as IndexPath) as! JobsListCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == educationTable{
            return 2
        }else if tableView == experienceTable{
            return 2
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == educationTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath as IndexPath) as! EducationCell
            return cell
        }else if tableView == experienceTable{
            let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath as IndexPath) as! ExperienceCell
            return cell
        }else{
             let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath as IndexPath) as! ExperienceCell
                       return cell
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
