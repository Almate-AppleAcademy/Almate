//
//  UpdatepassViewController.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 16/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class UpdatepassViewController: UIViewController {

    
    @IBOutlet var updateView: UpdatepassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView.updatepassViewDelegate = self
        // Do any additional setup after loading the view.
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

extension UpdatepassViewController: UpdatepassViewDelegate {
    func didTappedChangePassword(_ passAcc: String) {
        Auth.auth().currentUser?.updatePassword(to: passAcc) { (error)
        in
        if let error = error
        {
            print("Failed to change password", error.localizedDescription)
            return
        }
            print("Successfully change password with firebase")
        }
    }
    
    func didTappedCancel() {
        let controller = SettingsViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(LoginViewController(), animated: true)

        print("dah kepencet")
    }
    
    
}
