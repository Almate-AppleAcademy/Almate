//
//  ProfileViewController.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @IBAction func editPressed(_ sender: UIButton) {
        self.present(UINavigationController(rootViewController: EditProfileViewController()), animated: true, completion: nil)
        
    }
    
    @IBAction func linkedinPressed(_ sender: UIButton) {
        if let url = URL(string: "https://www.linkedin.com/in/slamet-riyadi-06a603155/")
        {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func phonePressed(_ sender: UIButton) {
        
    }
    @IBAction func emailPressed(_ sender: UIButton) {
        if let url = URL(string: "mailto:slametngeblog@gmail.com"){
        UIApplication.shared.open(url)
        }
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
