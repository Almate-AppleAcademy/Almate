//
//  LoginViewController.swift
//  Almate
//
//  Created by Qiarra on 30/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login Page"
        
        navigationController?.navigationBar.isHidden = true
        loginView.loginViewDelegate = self
    }

/*    func login(loginMethod: String) {
        switch loginMethod {
            case "google":
                GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().signIn()
            default:
                return
        }
    }

        let controller = MainTabBarController(nibName: "MainTabBarController", bundle: nil)
        self.navigationController?.pushViewController(MainTabBarController(), animated: true)
*/

    
    @IBAction func forgotPressed(_ sender: Any) {
        let controller = ForgotpassViewController(nibName: "ForgotpassViewController", bundle: nil)
        self.navigationController?.pushViewController(ForgotpassViewController(), animated: true)

    }

//    @IBAction func signInPressed(_ sender: Any) {
//        let controller =  MainTabBarController(nibName: "MainTabBarController", bundle: nil)
//        self.navigationController?.pushViewController(MainTabBarController(), animated: true)
//    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let controller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)

        print("dah kepencet")
    }
}

extension LoginViewController: LoginViewDelegate
{
    func didTappedForgotPassword() {
        let buttonPressed = UIButton(type: .system)
        buttonPressed.addTarget(self, action: #selector(forgotPressed(_:)), for: .touchUpInside)
    }
    
    func didTappedSignIn(_ userEmail: String, userPassword: String) {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword)  { (user, error)
        in
        if let error = error
        {
            print("Failed to login user", error.localizedDescription)
            return
        }
            let controller =  MainTabBarController(nibName: "MainTabBarController", bundle: nil)
            self.navigationController?.pushViewController(MainTabBarController(), animated: true)
            print("Successfully login user with firebase")
        }  
    }
    
    func didTappedSignUp() {
        let buttonPressed = UIButton(type: .system)
        buttonPressed.addTarget(self, action: #selector(signUpPressed(_:)), for: .touchUpInside)
    
    }
    
    
}


