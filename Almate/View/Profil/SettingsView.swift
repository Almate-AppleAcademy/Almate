//
//  SettingsView.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 26/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    var settingViewDelegate : SettingViewDelegate?
    
    @IBOutlet weak var cpassButtonOut: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func cpassButton(_ sender: Any) {
        settingViewDelegate?.didTappedChangePassword()
    }
    
        @IBAction func signoutButton(_ sender: Any) {
            settingViewDelegate?.didTappedSignOut()
    }
    
}

protocol SettingViewDelegate {
    func didTappedChangePassword()
    func didTappedSignOut()
}
