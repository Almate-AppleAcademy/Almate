//
//  EmployerViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerViewController: UIViewController {

    var chosenCell: HeaderTableViewCell?
    
    var firstSegment = true
    
    enum CellType {
        case header
        case about
        case people
    }
    
    class Job {
        
    }
    
    class Users {
        
    }
    
    @IBAction func linkedinButtonPressed(_ sender: Any) {
         if let url = URL(string: "https://www.linkedin.com/in/slamet-riyadi-06a603155/")
         {
             UIApplication.shared.open(url)
         }
     }
     @IBAction func employerTelpButtonPressed(_ sender: Any) {
         if let url = URL(string: "tel://+6281274330099"), UIApplication.shared.canOpenURL(url) {
             if #available(iOS 10, *) {
                 UIApplication.shared.open(url)
             } else {
                 UIApplication.shared.openURL(url)
             }
         }
     }
     @IBAction func employerMailButtonPressed(_ sender: Any) {
         if let url = URL(string: "mailto:slametngeblog@gmail.com"){
         UIApplication.shared.open(url)
         }
     }
     
     @IBAction func settingButton(_ sender: Any) {
         self.present(UINavigationController(rootViewController: SettingsEmployerViewController()), animated: true, completion: nil)
     }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var array:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        
//        let nav = self.navigationController?.navigationBar
//        nav?.barStyle = UIBarStyle.default
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerTableViewCell")
        tableView.register(UINib(nibName: "ProfileSegmentTableViewCell", bundle: nil), forCellReuseIdentifier: "profileSegmentTableViewCell")
        tableView.register(UINib(nibName: "ProfileSegmentSmallTableViewCell", bundle: nil), forCellReuseIdentifier: "profileSegmentSmallTableViewCell")
        tableView.register(UINib(nibName: "FavoritesSegmentTableViewCell", bundle: nil), forCellReuseIdentifier: "favoritesSegmentTableViewCell")
        tableView.register(UINib(nibName: "FavoritesSegmentSmallTableViewCell", bundle: nil), forCellReuseIdentifier: "favoritesSegmentSmallTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func setupData() {
        array.removeAll()
        array.append(CellType.header)
        array.append(CellType.about)
        array.append(Job())
        array.append(Job())
        array.append(Job())
        
//        array.append(CellType.people)
//        array.append(Users())
//        array.append(Users())
//        array.append(Users())
    }
    
    
    @IBAction func profileSegmentedTapped(_ sender: Any) {
        if firstSegment == false {
            firstSegment = true
            array.removeAll()
            array.append(CellType.header)
            array.append(CellType.about)
            array.append(Job())
            array.append(Job())
            array.append(Job())
            self.tableView.reloadData()
            
            chosenCell?.profileSegmentMark.isHidden = false
            chosenCell?.favoritesSegmentMark.isHidden = true
        } else {
            
        }
    }
    
    @IBAction func favoritesSegmentedTapped(_ sender: Any) {
        if firstSegment == true {
            firstSegment = false
            array.removeAll()
            array.append(CellType.header)
            array.append(CellType.people)
            array.append(Users())
            array.append(Users())
            array.append(Users())
            self.tableView.reloadData()
            
            chosenCell?.profileSegmentMark.isHidden = true
            chosenCell?.favoritesSegmentMark.isHidden = false
        } else {
            
        }
    }
    
}

extension EmployerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentTableViewCell
        if let type = array[indexPath.row] as? CellType {
            switch type {
            case .header:
                let cell = tableView.dequeueReusableCell(withIdentifier: "headerTableViewCell", for: indexPath) as! HeaderTableViewCell
                chosenCell = cell
                return cell
            case .about:
                let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentTableViewCell
//                chosenCell = cell
                return cell
            case .people:
                let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesSegmentTableViewCell", for: indexPath as IndexPath) as! FavoritesSegmentTableViewCell
//                chosenCell = cell
                return cell
            }
            
        }else if let job =  array[indexPath.row] as? Job {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentSmallTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentSmallTableViewCell
            return cell
        }else if let user =  array[indexPath.row] as? Users {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesSegmentSmallTableViewCell", for: indexPath as IndexPath) as! FavoritesSegmentSmallTableViewCell
            return cell
        }
        
        return  UITableViewCell()
    }
    
    
}

