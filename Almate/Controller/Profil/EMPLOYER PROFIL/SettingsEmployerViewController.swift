//
//  SettingsEmployerViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 22/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class SettingsEmployerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        self.navigationItem.title = "Settings"
        self.navigationItem.rightBarButtonItem = doneBtn

        
        
        // Do any additional setup after loading the view.
    }

    @objc func donePressed(){
        self.dismiss(animated: true, completion: nil)
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
