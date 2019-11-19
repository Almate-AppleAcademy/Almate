//
//  JobsViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController {
    
    @IBOutlet var jobView: JobsView!
    //    let tableCellId = "Notif1TableViewCell"
    var requestLocalJob = LocalJob()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Jobs"
        jobView.jobDelegate = self
        //navigationItem.title = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}

extension JobsViewController: JobDelegate {
    func didTapPostJob() {
         let vc = PostJobViewController(nibName: "PostJobViewController", bundle: nil)
                   self.navigationController?.present(vc, animated: true)
                   print("hah")
    }
    

    func tappedSaveJob(_ state: UserCoreDataState, _ data: Admin) {
        print("job-4-almost")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if state == .delete {
            print("job-4-delete")
        } else {
            requestLocalJob.createData(data: data, appDelegate) {
                (message) in
                print("job-4-create")
                print(message)
            }
        }
    }
    
        func didSelectItemAt() {
            let vc = JobDetailViewController(nibName: "JobDetailViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            print("hah")
        }
    
}



