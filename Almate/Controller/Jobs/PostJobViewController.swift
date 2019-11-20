//
//  PostJobViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PostJobViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet var postJobView: PostJobView!
    @IBOutlet var addLogo: UIButton!
    @IBOutlet var addDetailImage: UIButton!
    var test = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        postJobView.postJobDelegate = self
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Post Job")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
         let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(cancel))
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = cancelItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    @objc func done() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @objc func cancel() {
        navigationController?.popViewController(animated: true)
               dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        if test == 1{
            guard let logoImage  = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
                // configure plusPhotoBtn with selected image
                addLogo.layer.cornerRadius = addLogo.frame.width/2
                addLogo.layer.masksToBounds = true
                addLogo.layer.borderColor = UIColor.black.cgColor
                addLogo.layer.borderWidth = 2
                addLogo.setImage(logoImage.withRenderingMode(.alwaysOriginal), for: .normal)
                print("hey")
                self.dismiss(animated: true, completion: nil)
            
        }else if test == 2{
             guard let detailImage  = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            addDetailImage.layer.cornerRadius = 10
                           addDetailImage.layer.masksToBounds = true
                           addDetailImage.layer.borderColor = UIColor.black.cgColor
                           addDetailImage.layer.borderWidth = 2
                           addDetailImage.setImage(detailImage.withRenderingMode(.alwaysOriginal), for: .normal)
            print("lol")
            self.dismiss(animated: true, completion: nil)
        }else{
            print("error")
        }
    }
    
   
}

extension PostJobViewController: PostJobDelegate{
    func didTapAddImage() {
        //configure image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //present image picker
        self.present(imagePicker, animated: true, completion: nil)
        test = 1
        print(test)
    }
    
    func didTapLogo() {
                //configure image picker
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                //present image picker
                self.present(imagePicker, animated: true, completion: nil)
        test = 2
    }
    
    
}

