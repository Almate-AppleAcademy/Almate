//
//  EditProfileView.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 11/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EditProfileView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    

    @IBOutlet weak var avaBtn: UIButton!
    @IBOutlet weak var educationTableView: ProfileTableView!
    
    @IBOutlet weak var experienceTableView: ProfileTableView!
    @IBOutlet weak var workCollection: UICollectionView!
    @IBOutlet weak var referenceCollection: UICollectionView!
    @IBOutlet weak var nameTxtF: UITextField!
    @IBOutlet weak var occupTxtF: UITextField!
    @IBOutlet weak var locationTxtF: UITextField!
    @IBOutlet weak var phoneTxtF: UITextField!
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var aboutTxtV: UITextView!
    
    override func awakeFromNib() {

        avaBtn.imageView?.clipsToBounds = true
        avaBtn.imageView?.layer.cornerRadius = 37.5
        
        workCollection.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
        educationTableView.register(UINib(nibName: "EducationCell", bundle: nil), forCellReuseIdentifier: "educationCell")
        experienceTableView.register(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: "experienceCell")
        referenceCollection.register(UINib(nibName: "ReferenceCell", bundle: nil), forCellWithReuseIdentifier: "referenceCell")
        
        educationTableView.dataSource = self
        educationTableView.delegate = self
        experienceTableView.dataSource = self
        experienceTableView.delegate = self
        workCollection.dataSource = self
        workCollection.delegate = self
        referenceCollection.dataSource = self
        referenceCollection.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == workCollection{
        return workAngka
        }
        else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == workCollection{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath as IndexPath) as! ProfileCell
        return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "referenceCell", for: indexPath) as! ReferenceCell
            cell.quoteUser.text = "Nothing really matters... nothing really matters, to me. Anywhere the wind blows..."
            cell.quoteUser.sizeToFit()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == educationTableView{
        return 2
        }
        else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == educationTableView{
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! EducationCell
        
        return tableCell
        }
        else{
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! ExperienceCell
            return tableCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
