//
//  ForgotpassViewController.swift
//  Almate
//
//  Created by Gabriella Gracia MT on 10/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class ForgotpassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelPressedForgot(_ sender: Any) {
            let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.navigationController?.pushViewController(LoginViewController(), animated: true)

            print("dah kepencet")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
