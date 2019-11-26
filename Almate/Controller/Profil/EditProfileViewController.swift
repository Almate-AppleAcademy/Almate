//
//  EditProfileViewController.swift
//  Almate
//
//  Created by Mirza Fachreza 2 on 11/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet var editProfile: EditProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelPressed))
        self.navigationItem.title = "Edit Profile"
        self.navigationItem.rightBarButtonItem = doneBtn
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        editProfile.nameTxtF.delegate = self
        editProfile.occupTxtF.delegate = self
        editProfile.locationTxtF.delegate = self
        editProfile.phoneTxtF.delegate = self
        editProfile.emailTxtF.delegate = self
        editProfile.aboutTxtV.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func donePressed(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func cancelPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func avatarPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let avatarImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        editProfile.avaBtn.setImage(avatarImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
           textView.resignFirstResponder()
           return true
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
