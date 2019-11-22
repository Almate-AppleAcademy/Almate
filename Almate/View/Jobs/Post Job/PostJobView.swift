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

