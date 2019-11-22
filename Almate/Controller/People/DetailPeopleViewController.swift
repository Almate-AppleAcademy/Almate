//
//  DetailPeopleViewController.swift
//  Almate
//
//  Created by Qiarra on 06/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore


class DetailPeopleViewController: UIViewController {
    
    var dataPeople: User?
    var dataContactPeople: UserContact?
    var documents: QueryDocumentSnapshot?
    var requestRemoteData = RemotePeople()
    
    @IBOutlet weak var detailPeopleView: DetailPeopleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        detailPeopleView.dataPeople = dataPeople
        
        requestRemoteData.loadPeopleEducation(documents: documents!) { (dataEducation) in
            print(dataEducation)
            
            self.requestRemoteData.loadPeopleExperience(documents: self.documents!) { (dataExperience) in
                print(dataExperience)
                
                self.requestRemoteData.loadPeopleDetail(documents: self.documents!) { (dataContact) in
                    self.dataContactPeople = dataContact
                    self.detailPeopleView.dataPeopleContact = dataContact
                }
            }
        }
    }
    
    @IBAction func didTapLinkeIdn(_ sender: Any) {
        if let linkedInURL = dataContactPeople?.userLinkedIn {
            if let url = URL(string: linkedInURL) {
                UIApplication.shared.open(url)
            }
        } else { print("LinkedIn URL Not Found") }
    }
    
    @IBAction func didTapEmail(_ sender: Any) {
        if let userEmail = dataContactPeople?.userEmail {
            if let url = URL(string: "mailto:\(userEmail)") {
                UIApplication.shared.open(url)
            }
        } else { print("User Email Not Found") }
    }
    
    @IBAction func didTapTelpon(_ sender: UIButton) {
        // Check Condition if telpon not nill
        // if data.telpon != nil {
        //  if !user.allowTelpon {
        //
        //  }
        // } else {
        //
        // }
        
        if let userPhone = dataContactPeople?.userPhone {
            if let url = URL(string: "tel://\(userPhone)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else { print("User Number Not Found")}
    }
}
