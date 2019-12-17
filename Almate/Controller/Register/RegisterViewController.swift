//
//  RegisterViewController.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 28/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

     @IBOutlet var registerView: RegisterView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
        registerView.registerViewDelegate = self
          // Do any additional setup after loading the view.
      }

//      @IBAction func cancelPressed(_ sender: Any) {
//          let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
//          self.navigationController?.pushViewController(LoginViewController(), animated: true)
//
//          print("dah kepencet")
//      }

}

extension RegisterViewController: RegisterViewDelegate {
    func didTappedRegister(_ namaNya: String, cohortNya: String, emailNya: String, passwordNya: String, confirmNya: String) {
        
        Auth.auth().createUser(withEmail: emailNya, password: passwordNya) { (user, error) in
            if let error = error
            {
                let alert = UIAlertController(title: "Can't be regiter", message: "The email address is already in use by another account.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.destructive, handler: nil))
                
                print("Failed to create user", error.localizedDescription)
                return
                
            } else {
                let alert = UIAlertController(title: "Success", message: "Thankyou for register, we will verify your data within 3X24 hours.", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.destructive, handler: nil))

                self.present(alert, animated: true, completion: nil)
                print("Successfully created user with firebase")
            }
        }
    }
    
    func didTappedCancel() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)

        print("dah kepencet")
    }
}
