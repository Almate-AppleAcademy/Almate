//
//  EmployerJobViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 19/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerJobViewController: UIViewController, UIActionSheetDelegate {

    @IBOutlet var jobEmployerView: EmployerJobView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        jobEmployerView.jobOpeningsDelegate = self
         navigationController?.setNavigationBarHidden(true, animated: true)
    }


   
}

extension EmployerJobViewController: JobOpeningsDelegate{
    func didTappedEdit() {
        
        let alertController = UIAlertController(title: "Alert", message: "This is an alert.", preferredStyle: .alert)

        let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }

        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }

        let action3 = UIAlertAction(title: "Destructive", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed the destructive");
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func didSelectItemAt() {
        let vc = JobDetailViewController(nibName: "JobDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("hah")
    }
    
    
    
}

