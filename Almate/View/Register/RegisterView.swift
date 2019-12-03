//
//  RegisterView.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 28/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    @IBOutlet weak var companyPict: UIImageView!
    @IBOutlet weak var coName: UILabel!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var cohortTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    var registerViewDelegate: RegisterViewDelegate?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if fullNameTF.text!.isEmpty
        {
            print("Email tidak boleh kosong")
        } else if cohortTF.text!.isEmpty{
            print("Cohort tidak boleh kosong")
        } else if emailTF.text!.isEmpty{
            print("Email tidak boleh kosong")
        } else if passTF.text!.isEmpty{
            print("Password tidak boleh kosong")
        } else if passTF.text!.count < 8{
        print("Password tidak boleh kurang dari 8 character")
        } else if confirmPassTF.text != passTF.text{
           print("Password tidak cocok")
        } else{
            registerViewDelegate?.didTappedRegister()
            print("Success")
        }
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
    func didTappedRegister()
}
