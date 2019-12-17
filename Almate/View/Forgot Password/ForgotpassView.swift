//
//  ForgotpassView.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 10/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Firebase

class ForgotpassView: UIView {

    var forgotViewDelegate : ForgotViewDelegate?
    
    @IBOutlet weak var emailForgot: UITextField!
    @IBOutlet weak var registerButtonOut: UIButton!
    
    override class func awakeFromNib() {
         super.awakeFromNib()
         //registerButtonOut.isEnabled = false
     }
    
    @IBAction func resetPass(_ sender: Any) {
        let button = UIButton()
        button.isEnabled = false
        button.alpha = 0.3
        
        if emailForgot.text!.isValidationEmail() == false {
            print("email tidak valid!")
        }
        else if emailForgot.text!.isEmpty
        {
            print("email tidak boleh kosong")
        }
        else
        {
            forgotViewDelegate?.didTappedResetPassword(emailForgot.text!)
            button.isEnabled = true
            print("success")
        }
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        forgotViewDelegate?.didTappedCancel()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
protocol ForgotViewDelegate {
    func didTappedResetPassword(_ emailAcc: String)
    func didTappedCancel()
}

extension String {
    func isValidationEmail() -> Bool {
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
