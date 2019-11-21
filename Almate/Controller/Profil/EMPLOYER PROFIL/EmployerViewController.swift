//
//  EmployerViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerViewController: UIViewController {

    enum CellType{
        case header
        case about
        case people
    }
    
    class Job{
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    var array:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerTableViewCell")
        tableView.register(UINib(nibName: "ProfileSegmentTableViewCell", bundle: nil), forCellReuseIdentifier: "profileSegmentTableViewCell")
        tableView.register(UINib(nibName: "ProfileSegmentSmallTableViewCell", bundle: nil), forCellReuseIdentifier: "profileSegmentSmallTableViewCell")
        
        tableView.separatorStyle = .none
    }
    
    func setupData(){
        array.removeAll()
        array.append(CellType.header)
        array.append(CellType.about)
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
        array.append(Job())
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
                return cell
            case .about:
                let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentTableViewCell
                return cell
            case .people:
                let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentTableViewCell
                return cell
            }
            
        }else if let job =  array[indexPath.row] as? Job {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentSmallTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentSmallTableViewCell
            return cell
        }else if let user =  array[indexPath.row] as? Users {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileSegmentTableViewCell", for: indexPath as IndexPath) as! ProfileSegmentTableViewCell
            return cell
        }
        
        return  UITableViewCell()
    }
    
    
}
