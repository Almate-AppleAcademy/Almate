//
//  DetailPeopleViewController.swift
//  Almate
//
//  Created by Qiarra on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class DetailPeopleViewController: UIViewController {
    
    @IBOutlet var detailPeopleVoew: DetailPeopleView!
    var dataPeople: Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        detailPeopleVoew.dataPeople = dataPeople
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
    }
    
    @IBAction func didTapLinkeIdn(_ sender: Any) {
        if let url = URL(string: (dataPeople?.linkedIn)!) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapEmail(_ sender: Any) {
        if let url = URL(string: "mailto:\((dataPeople?.email)!)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapTelpon(_ sender: UIButton) {
        // Check Condition if telpon not nill
        // if data.telpon != nil {
        //  if !user.allowTelpon {
        //
        //  }
        // } else {
        //
        // }
        
        if let url = URL(string: "tel://081291617355"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
