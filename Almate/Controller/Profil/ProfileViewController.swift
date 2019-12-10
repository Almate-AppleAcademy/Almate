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
    
    @IBOutlet var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
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
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savedPressed(_ sender: UIButton) {
        profileSuperview.savedView.alpha = 1
        profileSuperview.profileView.alpha = 0
        
        profileSuperview.garisMenuDua.alpha = 1
        profileSuperview.garisMenu.alpha = 0
        
        
//        profileSuperview.garisMenu.frame.origin = CGPoint(x: 22, y: 493)
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        let controller = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        self.navigationController?.present(controller, animated: true)
    }

}
