//
//  LoginView.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginView: UIView {
    
    let loginVC = LoginViewController()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func didTapGoogleLogin(_ sender: UIButton) {
        //MARK: Error: 0.1 when called SignInSharedInst when login action in other class
        //MARK: ASK 1
        loginVC.login(loginMethod: "google") // this line error
    }
}
