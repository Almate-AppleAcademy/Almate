//
//  FilterViewController.swift
//  Almate
//
//  Created by Qiarra on 14/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationSetup()
    }
    
    func navigationSetup() {
        self.navigationItem.title = "Filter"
        let rightButtonItem = UIBarButtonItem.init(
            title: "Reset",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(leftButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        print("right")
    }
    
    @objc func leftButtonAction(sender: UIBarButtonItem) {
        print("left")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
