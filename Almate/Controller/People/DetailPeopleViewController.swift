//
//  DetailPeopleViewController.swift
//  Almate
//
//  Created by Qiarra on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class DetailPeopleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never 
    }
    
    @IBAction func didTapLinkeIdn(_ sender: Any) {
       if let url = URL(string: "https://www.linkedin.com/in/slamet-riyadi-06a603155/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapEmail(_ sender: Any) {
        if let url = URL(string: "mailto:slametngeblog@gmail.com") {
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
    @IBAction func addReferencePressed(_ sender: UIButton) {
        let controller = AddReferenceViewController(nibName: "AddReferenceViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
//        self.navigationController?.popViewController(animated: Bool)
        
        
        print("K")
    }
}
