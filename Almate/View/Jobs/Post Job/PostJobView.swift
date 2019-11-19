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
    
    var postJobDelegate: PostJobDelegate?
    
    override class func awakeFromNib() {
         super.awakeFromNib()
        
    }
    
    @IBAction func addLogoBtn(_ sender: UIButton) {
        addLogoImage()
        
    }
    
    @IBAction func addDetailImageBtn(_ sender: Any) {
        addImage()
    }
    
//   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//       guard let profileImage  = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
//
//       // configure plusPhotoBtn with selected image
//       addLogo.layer.cornerRadius = addLogo.frame.width/2
//       addLogo.layer.masksToBounds = true
//       addLogo.layer.borderColor = UIColor.black.cgColor
//       addLogo.layer.borderWidth = 2
//       addLogo.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
//
//       self.dismiss(animated: true, completion: nil)
//   }
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
   }

