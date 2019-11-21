//
//  EmployerViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerTableViewCell")
        
    }


}

extension EmployerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerTableViewCell", for: indexPath as IndexPath) as! HeaderTableViewCell
        
        return cell
    }
    
    
}
