//
//  UpdatepassView.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 16/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class UpdatepassView: UIView {

    var updatepassViewDelegate: UpdatepassViewDelegate?
    
    @IBOutlet weak var changepassOut: UILabel!
    @IBOutlet weak var newpassOut: UILabel!
    @IBOutlet weak var cnewpassOut: UILabel!
    @IBOutlet weak var newpassTF: UITextField!
    @IBOutlet weak var cnewpassTF: UITextField!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func changePassButton(_ sender: Any) {
        if cnewpassTF.text!.isEmpty{
            print("password tidak boleh kosong")
        } else if cnewpassTF.text!.count < 8 {
            print("password tidak boleh kurang dari 8")
        } else {
            updatepassViewDelegate?.didTappedChangePassword(cnewpassTF.text!)
        }
    }
    

    //    @IBAction func cancelButton(_ sender: Any) {
//        updatepassViewDelegate?.didTappedCancel()
//    }
}

protocol UpdatepassViewDelegate {
    func didTappedChangePassword(_ passAcc: String)
    func didTappedCancel()
}


