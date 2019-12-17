//
//  LoginView.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIView {
   
    
    let loginVC = LoginViewController()
    
    @IBOutlet weak var coPhotoOutlet: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailValidationAlert: UILabel!
    @IBOutlet weak var passValidationAlert: UILabel!
    
    var loginViewDelegate: LoginViewDelegate?
    
    
    
       override func awakeFromNib() {
           super.awakeFromNib()
           

       }
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
        if emailTextField.text!.isEmpty && passTextField.text!.isEmpty
        {
            emailValidationAlert.text = "Your email can't be empty"
            passValidationAlert.text = "Password can't be empty"
        }
        else if emailTextField.text!.isValidEmail() == false
        {
            emailValidationAlert.text = "Your email is not valid!"
        }
        else if passTextField.text!.isEmpty && emailTextField.text!.isEmpty == false
        {
            emailValidationAlert.text = ""
            passValidationAlert.text = "Password can't be empty"
        }
        else if passTextField.text!.count < 8
        {
            passValidationAlert.text = "Password should be more that 8 characters"
        }
        else
        {
            emailValidationAlert.text = ""
            passValidationAlert.text = ""
            loginViewDelegate?.didTappedSignIn(emailTextField.text!, userPassword: passTextField.text!)
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

