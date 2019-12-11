//
//  JobsViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController ,UISearchControllerDelegate{
    
    @IBOutlet var jobView: JobsView!
    var requestLocalJob = LocalJob()
    var shoulResize: Bool?
    var SearchView = UIImageView(image: UIImage(named: "white-1"))
    var imageView = UIImageView(image: UIImage(named: "Oval"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobView.jobDelegate = self
        self.tabBarController?.tabBar.isHidden = false
        setupUI()
        observeAndHandleOrientationMode()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        if UIDevice.current.orientation.isPortrait {
            shoulResize = true
        } else if UIDevice.current.orientation.isLandscape {
            shoulResize = false
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func searchTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showImage(true)
        setupUI()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        showImage(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ShouldResize()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let shoulResize = shoulResize
            else { assertionFailure("shoulResize wasn't set. reason could be non-handled device orientation state"); return }
        navigationController?.view.backgroundColor = #colorLiteral(red: 0.127440244, green: 0.1577139199, blue: 0.1955760121, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1276172996, green: 0.1577090323, blue: 0.1955741942, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        if shoulResize {
            moveAndResizeImageForPortrait()
        }
        
    }
    func observeAndHandleOrientationMode() {
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: OperationQueue.current) { [weak self] _ in
            
            if UIDevice.current.orientation.isPortrait {
                self?.title = "Jobs"
                self?.moveAndResizeImageForPortrait()
                self?.shoulResize = true
            } else if UIDevice.current.orientation.isLandscape {
                self?.title = "Jobs"
                self?.resizeImageForLandscape()
                self?.shoulResize = false
            }
        }
    }
    func ShouldResize(){
        guard let shoulResize = shoulResize
            else { assertionFailure("shoulResize wasn't set. reason could be non-handled device orientation state"); return }
        
        if shoulResize {
            moveAndResizeImageForPortrait()
        }
    }
    func deviceOrientation(){
        if UIDevice.current.orientation.isPortrait {
            shoulResize = true
        } else if UIDevice.current.orientation.isLandscape {
            shoulResize = false
        }
    }
    
    
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.view.backgroundColor = #colorLiteral(red: 0.127440244, green: 0.1577139199, blue: 0.1955760121, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1276172996, green: 0.1577090323, blue: 0.1955741942, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1770251393, green: 0.2089989185, blue: 0.2513588071, alpha: 1)
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Jobs"
        
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.addSubview(SearchView)
        // SearchView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        SearchView.clipsToBounds = true
        SearchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            SearchView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                              constant: -Const.SearchRightMargin),
            SearchView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                               constant: -Const.ImageBottomMarginForLargeState),
            SearchView.heightAnchor.constraint(equalToConstant: Const.SearchSizeForLargeState),
            SearchView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            
            
            
        ])
    }
    
    
    func moveAndResizeImageForPortrait() {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
        SearchView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func resizeImageForLandscape() {
        let yTranslation = Const.ImageSizeForLargeState * Const.ScaleForImageSizeForLandscape
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: Const.ScaleForImageSizeForLandscape, y: Const.ScaleForImageSizeForLandscape)
            .translatedBy(x: 0, y: yTranslation)
        SearchView.transform = CGAffineTransform.identity
            .scaledBy(x: Const.ScaleForImageSizeForLandscape, y: Const.ScaleForImageSizeForLandscape)
            .translatedBy(x: 0, y: yTranslation)
    }
    
    /// Show or hide the image from NavBar while going to next screen or back to initial screen
    ///
    /// - Parameter show: show or hide the image from NavBar
    func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = show ? 1.0 : 0.0
            self.SearchView.alpha = show ? 1.0 : 0.0
        }
    }
}










extension JobsViewController: JobDelegate {
    func didTapPostJob() {
        let vc = PostJobViewController(nibName: "PostJobViewController", bundle: nil)
        self.navigationController?.present(vc, animated: true)
        print("hah")
    }
    
    
    func tappedSaveJob(_ state: UserCoreDataState, _ data: LocalAdmin) {
        print("job-4-almost")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if state == .delete {
            print("job-4-delete")
        } else {
            requestLocalJob.createData(data: data, appDelegate) {
                (message) in
                print("job-4-create")
                print(message)
            }
        }
    }
    
    func didSelectItemAt() {
        let vc = JobDetailViewController(nibName: "JobDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("beneran?")
    }
    
}




