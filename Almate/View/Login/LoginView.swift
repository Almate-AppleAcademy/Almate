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
    
    @IBOutlet weak var coPhotoOutlet: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    var loginViewDelegate: LoginViewDelegate?
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func forgotPassButton(_ sender: Any) {
        loginViewDelegate?.didTappedForgotPassword()
    }
    
    @IBAction func signInButton(_ sender: Any) {
        if emailTextField.text!.isEmpty {
            print("email tidak boleh kosong!")
        }else if passTextField.text!.isEmpty {
            print("password tidak boleh kosong")
        } else if passTextField.text!.count < 8 {
            print("password tidak boleh kurang dari  8")
        } else {
        loginViewDelegate?.didTappedSignIn(emailTextField.text!, userPassword: passTextField.text!)

            print("sukses")
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {

        loginViewDelegate?.didTappedSignUp()
    }
    
    
    
//    @IBAction func didTapGoogleLogin(_ sender: UIButton) {
//        //MARK: Error: 0.1 when called SignInSharedInst when login action in other class
//        //MARK: ASK 1
//        loginVC.login(loginMethod: "google") // this line error
//    }

}

protocol LoginViewDelegate {
    func didTappedForgotPassword()
    
    func didTappedSignIn(_ userEmail: String, userPassword: String)
    
    func didTappedSignUp()
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

