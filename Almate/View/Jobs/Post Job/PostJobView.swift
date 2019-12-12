//
//  PostJobView.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Foundation

class PostJobView: UIView,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate {

  
    @IBOutlet weak var jobDescText: UITextView!
    @IBOutlet var addLogo: UIButton!
    @IBOutlet var addDetailImage: UIButton!
    @IBOutlet weak var detailImageView: UIImageView!
    
    var postJobDelegate: PostJobDelegate?
    
    override func awakeFromNib() {
         super.awakeFromNib()
        
        jobDescText.text = "Insert Job Description here"
        jobDescText.textColor = UIColor.darkGray
    
    }
    
    @IBAction func addLogoBtn(_ sender: UIButton) {
        addLogoImage()
       
    }
    
    @IBAction func addDetailImageBtn(_ sender: Any) {
        addImage()
      
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
   }

