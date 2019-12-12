//
//  PostJobView.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PostJobView: UIView,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet var addLogo: UIButton!
    @IBOutlet var addDetailImage: UIButton!
    @IBOutlet var tfJobTitle: UITextField!
    @IBOutlet var tfCompanyName: UITextField!
    @IBOutlet var tfLocation: UITextField!
    @IBOutlet var tfJobDetails: UITextView!
    @IBOutlet var tvContact: UITextView!
    
    
    var postJobDelegate: PostJobDelegate?
    var imgDataCompany: Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setNavigationBar()
    }
    
    @IBAction func addLogoBtn(_ sender: UIButton) {
        addLogoImage()
    }
    
    @IBAction func addDetailImageBtn(_ sender: Any) {
        addImage()
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Post Job")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
//        doneItem.isEnabled = false
        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(cancel))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = cancelItem
        navBar.setItems([navItem], animated: false)
        self.addSubview(navBar)
    }
    
    
    func didSetImgCompanyData(_ data: Data?) {
        if let data = data {
            self.imgDataCompany = data
        }
    }
    
    @objc func done() {
        
        if tvContact.text == nil {
            
        } else if tfCompanyName.text == nil {
            
        } else if tfLocation.text == nil {
            
        } else if tfJobDetails.text == nil {
            
        } else if tfJobTitle.text == nil {
            
        } else if imgDataCompany == nil {
            
        } else {
            let data = JobPost(jobCompanyEmail: tvContact.text! ,jobCompanyName: tfCompanyName.text!, jobLocation: tfLocation.text!, jobText: tfJobDetails.text!, jobTitle: tfJobTitle.text!, jobPhotos: [self.imgDataCompany!], jobCompanyLogo: self.imgDataCompany!)
            self.postJobDelegate?.didTapDone(postJobData: data)
            
        }
    }
    @objc func cancel() {
//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
}

extension PostJobView{
    func addLogoImage(){
        postJobDelegate?.didTapLogo()
    }
    func addImage(){
        postJobDelegate?.didTapAddImage()
    }
}

protocol PostJobDelegate{
    func didTapLogo()
    func didTapAddImage()
    func didTapDone(postJobData: JobPost)
}

//
//@objc func done() {
//    navigationController?.popViewController(animated: true)
//    dismiss(animated: true, completion: nil)
//}
//@objc func cancel() {
//    navigationController?.popViewController(animated: true)
//    dismiss(animated: true, completion: nil)
//}
