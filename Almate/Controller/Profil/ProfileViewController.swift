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
    var remoteProfile = RemoteProfile()
    var localJob = LocalJob()
    var dataContact: UserContact?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        // TODO: This DocumentID actually from local user defaults that value saved after user login, Dummy
        remoteProfile.loadUser(documentID: "LRWDmCoOc71P7MtaLBoa", completion: { (data) in
            self.profileSuperview.dataUser = data
            
            self.remoteProfile.loadPeopleDetail(documentID: "LRWDmCoOc71P7MtaLBoa") { (dataContact) in
                self.profileSuperview.dataPeopleContact = dataContact
                self.dataContact = dataContact
                
                self.remoteProfile.loadPeopleEducation(documentID: "LRWDmCoOc71P7MtaLBoa") { (dataEducation) in
                    self.profileSuperview.dataPeopleEducation = dataEducation
                    
                    self.remoteProfile.loadPeopleExperience(documentID: "LRWDmCoOc71P7MtaLBoa") { (dataExperience) in
                        self.profileSuperview.dataPeopleExperience = dataExperience
                        
                        self.remoteProfile.loadPeopleReference(documentID: "LRWDmCoOc71P7MtaLBoa") { (dataReference, dataPeople) in
                            self.profileSuperview.displayReference(dataReference, dataPeople)
                        }
                    }
                }
            }
        })
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        localJob.readData(appDelegate) { (dataJob) in
            self.profileSuperview.dataJobLocal = dataJob
            
            self.localJob.readDataPeople(appDelegate) { (dataPeople) in
                self.profileSuperview.dataPeopleLocal = dataPeople
            }
        }
    }
    
    
    @IBAction func editPressed(_ sender: UIButton) {
        self.present(UINavigationController(rootViewController: EditProfileViewController()), animated: true, completion: nil)
        
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func linkedinPressed(_ sender: UIButton) {
        if let dataContact = dataContact, let url = URL(string: dataContact.userLinkedIn) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func phonePressed(_ sender: UIButton) {
        //        if let dataC
        //
                if let userPhone = dataContact?.userPhone {
                    if let url = URL(string: "tel://\(userPhone)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else { print("User Number Not Found")}
    }
    @IBAction func emailPressed(_ sender: UIButton) {
        if let dataContact = dataContact, let url = URL(string: "mailto:\(dataContact.userEmail)") {
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
        self.present(UINavigationController(rootViewController: SettingsViewController()), animated: true, completion: nil)
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
