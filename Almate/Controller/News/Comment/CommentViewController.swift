//
//  CommentViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 12/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBAction func postTapped(_ sender: UIButton) {
        print("POST TAPPED")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
//        self.navigationItem.setHidesBackButton(true, animated:false)

    }

}
