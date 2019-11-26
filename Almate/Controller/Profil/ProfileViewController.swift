//
//  ProfileViewController.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileSuperview: ProfileView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
    }

    
    @IBAction func editPressed(_ sender: UIButton) {
        self.present(UINavigationController(rootViewController: EditProfileViewController()), animated: true, completion: nil)
        
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func profilePressed(_ sender: UIButton) {
        profileSuperview.profileView.alpha = 1
        profileSuperview.savedView.alpha = 0
        
        profileSuperview.garisMenu.alpha = 1
        profileSuperview.garisMenuDua.alpha = 0
        
        
//        profileSuperview.garisMenu.frame.origin = CGPoint(x: 217, y: 493)
            
    }
    
    @IBAction func doneProfilePressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func savedPressed(_ sender: UIButton) {
        profileSuperview.savedView.alpha = 1
        profileSuperview.profileView.alpha = 0
        
        profileSuperview.garisMenuDua.alpha = 1
        profileSuperview.garisMenu.alpha = 0
        
        
//        profileSuperview.garisMenu.frame.origin = CGPoint(x: 22, y: 493)
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        let controller = SettingViewController(nibName: "SettingsViewController", bundle: nil)
        self.navigationController?.present(controller, animated: true)
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
