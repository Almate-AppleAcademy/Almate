//
//  JobDetailViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 08/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobDetailViewController: UIViewController {

    @IBOutlet var jobDetailView: JobDetailView!
    @IBOutlet var backToJobBtn: UIButton!
    var dataJob: Job?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataJob = dataJob {
            jobDetailView.displayJobDetail(dataJob: dataJob)
        }
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        //navigationController?.navigationBar.prefersLargeTitles = true
        // navigationItem.title = "Detail"
        //  navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.largeTitleDisplayMode = .never
        //create a new button
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "bookmark unenabled"), for: UIControl.State.normal)
        //add function for button
        button.addTarget(self, action: #selector(bookmarkPressed), for: UIControl.Event.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    @IBAction func backToJobBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @objc func bookmarkPressed() {
        print("yakin")
    }
    
    
    @IBAction func applyJob(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "Success", message: "You have applied this job.", preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    

}
