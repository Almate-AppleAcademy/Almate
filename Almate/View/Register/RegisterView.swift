//
//  RegisterView.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 28/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class RegisterView: UIView {

    @IBOutlet weak var companyPict: UIImageView!
    @IBOutlet weak var coName: UILabel!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var cohortTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var fnameAlert: UILabel!
    @IBOutlet weak var cohortAlert: UILabel!
    @IBOutlet weak var emailAlert: UILabel!
    @IBOutlet weak var passAlert: UILabel!
    @IBOutlet weak var cpassAlert: UILabel!
    
    
    
    var registerViewDelegate: RegisterViewDelegate?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if fullNameTF.text!.isEmpty && cohortTF.text!.isEmpty && emailTF.text!.isEmpty && passTF.text!.isEmpty && confirmPassTF.text!.isEmpty
        {
            fnameAlert.text = "Name can't be empty"
            cohortAlert.text = "Cohort can't be empty"
            emailAlert.text = "Email can't be empty"
            passAlert.text = "Password can't be empty"
            cpassAlert.text = "Confirm password can't be empty"
        }
        else if fullNameTF.text!.isEmpty == false && cohortTF.text!.isEmpty && emailTF.text!.isEmpty && passTF.text!.isEmpty && confirmPassTF.text!.isEmpty
        {
            fnameAlert.text = ""
            cohortAlert.text = "Cohort can't be empty"
            emailAlert.text = "Email can't be empty"
            passAlert.text = "Password can't be empty"
            cpassAlert.text = "Confirm password can't be empty"
        }
        else if fullNameTF.text!.isEmpty == false && cohortTF.text!.isEmpty == false && emailTF.text!.isEmpty && passTF.text!.isEmpty && confirmPassTF.text!.isEmpty
        {
            fnameAlert.text = ""
            cohortAlert.text = ""
            emailAlert.text = "Email can't be empty"
            passAlert.text = "Password can't be empty"
            cpassAlert.text = "Confirm password can't be empty"
        }
        else if emailTF.text!.isValidEmail() == false
        {
        emailAlert.text = "Email not valid"
        }
        else if fullNameTF.text!.isEmpty == false && cohortTF.text!.isEmpty == false && emailTF.text!.isEmpty  == false && passTF.text!.isEmpty && confirmPassTF.text!.isEmpty
        {
            fnameAlert.text = ""
            cohortAlert.text = ""
            emailAlert.text = ""
            passAlert.text = "Password can't be empty"
            cpassAlert.text = "Confirm password can't be empty"
        } else if passTF.text!.count < 8
        {
            passAlert.text = "Password can't be less than 8 character"
        }
        else if fullNameTF.text!.isEmpty == false && cohortTF.text!.isEmpty == false && emailTF.text!.isEmpty == false && passTF.text!.isEmpty == false && confirmPassTF.text!.isEmpty
        {
            fnameAlert.text = ""
            cohortAlert.text = ""
            passAlert.text = ""
            cpassAlert.text = "Confirm password can't be empty"
        }
        else if confirmPassTF.text! != passTF.text!
        {
            cpassAlert.text = "Password didn't match"
        }
        else
        {
            passAlert.text = ""
            cpassAlert.text = ""
            registerViewDelegate?.didTappedRegister(fullNameTF.text!, cohortNya: cohortTF.text!, emailNya: emailTF.text!, passwordNya: passTF.text!, confirmNya: confirmPassTF.text!)
        }
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        registerViewDelegate?.didTappedCancel()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

protocol RegisterViewDelegate {
    func didTappedRegister(_ namaNya: String, cohortNya:String, emailNya: String, passwordNya: String, confirmNya: String)
    func didTappedCancel()
}
