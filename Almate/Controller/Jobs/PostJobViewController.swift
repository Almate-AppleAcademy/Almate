//
//  PostJobViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import Photos

class PostJobViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var postJobView: PostJobView!
    @IBOutlet var addLogo: UIButton!
    @IBOutlet var addDetailImage: UIButton!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailIamgeView2: UIImageView!
    @IBOutlet weak var detailImageView3: UIImageView!
    @IBOutlet weak var detailImageView4: UIImageView!

    @IBOutlet weak var jobDescText: UITextView!
    var test = 0
    var requestJob = RemoteJob()
    
    var additionalImage = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setNavigationBar()
        postJobView.postJobDelegate = self
       // postJobView.addSubview(presentButton)
        
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
                //addLogo.image = image
                addLogo.layer.cornerRadius = addLogo.frame.width/2
                addLogo.layer.borderColor = UIColor.black.cgColor
                addLogo.layer.borderWidth = 2
                addLogo.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                print("hey")
                //                                self.dismiss(animated: true, completion: nil)
                
                addLogo.layer.masksToBounds = true
            } else {
                addDetailImage.layer.cornerRadius = 10
                addDetailImage.layer.masksToBounds = true
                addDetailImage.layer.borderColor = UIColor.black.cgColor
                addDetailImage.layer.borderWidth = 2
                addDetailImage.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                if additionalImage == 0{
                self.detailImageView.image = image.withRenderingMode(.alwaysOriginal)
                    additionalImage = 1
                }else if additionalImage == 1{
                    self.detailIamgeView2.image = image.withRenderingMode(.alwaysOriginal)
                    additionalImage = 2
                }else if additionalImage == 2{
                    self.detailImageView3.image = image.withRenderingMode(.alwaysOriginal)
                    additionalImage = 3
                }else{
                    self.detailImageView4.image = image.withRenderingMode(.alwaysOriginal)
                }
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
    
    

extension PostJobViewController: PostJobDelegate{
    func didTapAddImage() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        //        //configure image picker
        //        let imagePicker = UIImagePickerController()
        //        imagePicker.delegate = self
        //        imagePicker.allowsEditing = true
        //        //present image picker
        //        self.present(imagePicker, animated: true, completion: nil)
        
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


//
//extension PostJobViewController : ImagePickerControllerDelegate {
//
//    public func imagePicker(controller: ImagePickerController, didSelectActionItemAt index: Int) {
//        print("did select action \(index)")
//
//        //before we present system image picker, we must update present button
//        //because first responder will be dismissed
//        presentButton.isSelected = false
//
//        if index == 0 && UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let vc = UIImagePickerController()
//            vc.sourceType = .camera
//            vc.allowsEditing = true
//            if let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) {
//                vc.mediaTypes = mediaTypes
//            }
//            navigationController?.visibleViewController?.present(vc, animated: true, completion: nil)
//        }
//        else if index == 1 && UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let vc = UIImagePickerController()
//            vc.sourceType = .photoLibrary
//            navigationController?.visibleViewController?.present(vc, animated: true, completion: nil)
//        }
//    }
//
//    public func imagePicker(controller: ImagePickerController, didSelect asset: PHAsset) {
//        print("selected assets: \(controller.selectedAssets.count)")
//        updateNavigationItem(with: controller.selectedAssets.count)
//    }
//
//    public func imagePicker(controller: ImagePickerController, didDeselect asset: PHAsset) {
//        print("selected assets: \(controller.selectedAssets.count)")
//        updateNavigationItem(with: controller.selectedAssets.count)
//    }
//
//    public func imagePicker(controller: ImagePickerController, didTake image: UIImage) {
//        print("did take image \(image.size)")
//    }
//
//    func imagePicker(controller: ImagePickerController, willDisplayActionItem cell: UICollectionViewCell, at index: Int) {
//        switch cell {
//        case let iconWithTextCell as IconWithTextCell:
//            iconWithTextCell.titleLabel.textColor = UIColor.black
//            switch index {
//            case 0:
//                iconWithTextCell.titleLabel.text = "Camera"
//                iconWithTextCell.imageView.image = #imageLiteral(resourceName: "button-camera")
//            case 1:
//                iconWithTextCell.titleLabel.text = "Photos"
//                iconWithTextCell.imageView.image = #imageLiteral(resourceName: "button-photo-library")
//            default: break
//            }
//        default:
//            break
//        }
//    }
//
//    func imagePicker(controller: ImagePickerController, willDisplayAssetItem cell: ImagePickerAssetCell, asset: PHAsset) {
//        switch cell {
//
//        case let videoCell as CustomVideoCell:
//            // videoCell.label.text = ViewController.durationFormatter.string(from: asset.duration)
//            print("bisa")
//        case let imageCell as CustomImageCell:
//            if asset.mediaSubtypes.contains(.photoLive) {
//                imageCell.subtypeImageView.image = #imageLiteral(resourceName: "icon-live")
//            }
//            else if asset.mediaSubtypes.contains(.photoPanorama) {
//                imageCell.subtypeImageView.image = #imageLiteral(resourceName: "icon-pano")
//            }
//            else if #available(iOS 10.2, *), asset.mediaSubtypes.contains(.photoDepthEffect) {
//                imageCell.subtypeImageView.image = #imageLiteral(resourceName: "icon-depth")
//            }
//        default:
//            break
//        }
//    }
//
//}
//
//extension PostJobViewController: ImagePickerControllerDataSource {
//
//    func imagePicker(controller: ImagePickerController, viewForAuthorizationStatus status: PHAuthorizationStatus) -> UIView {
//        let infoLabel = UILabel(frame: .zero)
//        infoLabel.backgroundColor = UIColor.green
//        infoLabel.textAlignment = .center
//        infoLabel.numberOfLines = 0
//        switch status {
//        case .restricted:
//            infoLabel.text = "Access is restricted\n\nPlease open Settings app and update privacy settings."
//        case .denied:
//            infoLabel.text = "Access is denied by user\n\nPlease open Settings app and update privacy settings."
//        default:
//            break
//        }
//        return infoLabel
//    }
//
//}
