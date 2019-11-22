//
//  JobDetailViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 08/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobDetailViewController: UIViewController {

    @IBOutlet var backToJobBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        
        //navigationController?.navigationBar.prefersLargeTitles = true
       // navigationItem.title = "Detail"
      //  navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.largeTitleDisplayMode = .never
        
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
    

}
