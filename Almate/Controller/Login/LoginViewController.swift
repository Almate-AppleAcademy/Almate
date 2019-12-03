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

    @IBOutlet var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login Page"
        
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
    }

//    func login(loginMethod: String) {
//        switch loginMethod {
//            case "google":
//                GIDSignIn.sharedInstance()?.presentingViewController = self
//                GIDSignIn.sharedInstance().signIn()
//            default:
//                return
//        }
//    }
//
//        let controller = MainTabBarController(nibName: "MainTabBarController", bundle: nil)
//        self.navigationController?.pushViewController(MainTabBarController(), animated: true)
//

    
    @IBAction func signUpPressed(_ sender: Any) {
        let controller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)

        print("dah kepencet")
    }
}

extension LoginViewController: LoginViewDelegate
{
    func didTappedForgotPassword() {
        
    }
    
    func didTappedSignIn(_ userEmail: String, userPassword: String) {
    }
    
    func didTappedSignUp() {
        let buttonPressed = UIButton(type: .system)
        buttonPressed.addTarget(self, action: #selector(signUpPressed(_:)), for: .touchUpInside)
    
    }
    
    
}
