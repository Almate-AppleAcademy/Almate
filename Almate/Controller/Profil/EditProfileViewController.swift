//
//  EditProfileViewController.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 11/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        self.navigationItem.title = "Edit Profile"
        self.navigationItem.rightBarButtonItem = doneBtn
        self.navigationItem.leftBarButtonItem = cancelBtn
        // Do any additional setup after loading the view.
    }
    
    @objc func donePressed(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func cancelPressed(){
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
