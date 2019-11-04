//
//  LoginViewController.swift
//  Almate
//
//  Created by Qiarra on 30/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login Page"
        // Do any additional setup after loading the view.
    }

    func login(loginMethod: String) {
        switch loginMethod {
            case "google":
                GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().signIn()
            default:
                return
        }
    }
}
