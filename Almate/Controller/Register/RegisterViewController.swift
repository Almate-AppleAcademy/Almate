//
//  RegisterViewController.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 28/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

     @IBOutlet var registerView: RegisterView!
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Do any additional setup after loading the view.
      }

      @IBAction func cancelPressed(_ sender: Any) {
          let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
          self.navigationController?.pushViewController(LoginViewController(), animated: true)

          print("dah kepencet")
      }

}
