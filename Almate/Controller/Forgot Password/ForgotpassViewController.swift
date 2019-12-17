//
//  ForgotpassViewController.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 10/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class ForgotpassViewController: UIViewController {

    @IBOutlet var forgotpassView: ForgotpassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotpassView.forgotViewDelegate = self
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func cancelPressedForgot(_ sender: Any) {
//            let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
//            self.navigationController?.pushViewController(LoginViewController(), animated: true)
//
//            print("dah kepencet")
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ForgotpassViewController: ForgotViewDelegate {
    func didTappedResetPassword(_ emailAcc: String) {
        Auth.auth().sendPasswordReset(withEmail: emailAcc) { (error)
        in
            if let error = error
            {
                print("user with email \(emailAcc) are not register yet", error.localizedDescription)
                return
            }
            else
            {
                let alert = UIAlertController(title: "Success", message: "We will send a link to your email .", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                print("Successfully reset password  with firebase")
            }
        }
    }
    
    func didTappedCancel() {
        let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        
    }
}
