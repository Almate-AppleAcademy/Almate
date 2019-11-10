//
//  JobsViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController, JobViewDelegate {
    
    @IBOutlet var jobView: JobsView!
   

    @IBAction func pindah(_ sender: Any) {
           let vc = JobDetailViewController(nibName: "JobDetailViewController", bundle: nil)
           self.navigationController?.pushViewController(vc, animated: true)
           print("hah")
       }
    override func viewDidLoad() {
        super.viewDidLoad()

    
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Jobs"
    

        navigationController?.setNavigationBarHidden(true, animated: true)
        jobView.delegate = self 
    }

    @IBAction func didTapPostJob(_ sender: UIButton) {
       
       
    }

//    @IBAction func didTapPostJob(_ sender: UIButton) {
//        
//    }
    
   func didSelectItemAt() {
       let controller = JobDetailViewController(nibName: "JobDetailViewController", bundle: nil)
       self.navigationController?.pushViewController(controller, animated: true)
   }

}
