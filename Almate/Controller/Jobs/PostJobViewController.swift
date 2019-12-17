//
//  PostJobViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PostJobViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var postJobView: PostJobView!
    @IBOutlet var addLogo: UIButton!
    @IBOutlet var addDetailImage: UIButton!
    var test = 0
    var requestJob = RemoteJob()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setNavigationBar()
        postJobView.postJobDelegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let imageData = image.jpegData(compressionQuality: 0.6) else { return }
            self.postJobView.didSetImgCompanyData(imageData)
            if test == 1 {
                addLogo.layer.cornerRadius = addLogo.frame.width/2
                addLogo.layer.masksToBounds = true
                addLogo.layer.borderColor = UIColor.black.cgColor
                addLogo.layer.borderWidth = 2
                addLogo.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                addDetailImage.layer.cornerRadius = 10
                addDetailImage.layer.masksToBounds = true
                addDetailImage.layer.borderColor = UIColor.black.cgColor
                addDetailImage.layer.borderWidth = 2
                addDetailImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
        else {
            //error
        }
        self.dismiss(animated: true, completion: nil)
        
    }

}

extension PostJobViewController: PostJobDelegate {
    
    func didTapCancel() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapDone(postJobData: JobPost) {
        self.requestJob.uploadPhoto(jobData: postJobData) { (url) in
            
            let data = Job(jobCompanyEmail: postJobData.jobCompanyEmail, jobCompanyLogo: url, jobCompanyName: postJobData.jobCompanyName, jobLocation: postJobData.jobLocation, jobText: postJobData.jobText, jobTitle: postJobData.jobTitle, jobPhotos: [url, url])
            
            self.requestJob.uploadJob(jobData: data) { (msg, isSuccces) in
                if isSuccces {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                } else { print(msg) }
            }
        }
    }
    
    
    func didTapAddImage() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        test = 2
    }
    
    func didTapLogo() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        test = 1
    }
}

