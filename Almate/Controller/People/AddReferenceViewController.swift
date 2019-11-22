//
//  AddReferenceViewController.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 21/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class AddReferenceViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var addReferenceSuperview: AddReferenceView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Reference"
        self.navigationController?.navigationBar.isHidden = true
        addReferenceSuperview.referenceTxtView.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func postPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray{
            textView.text = nil
          textView.textColor = UIColor.black
        }
    }
    
   func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write something here..."
            textView.textColor = UIColor.darkGray
        }
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
