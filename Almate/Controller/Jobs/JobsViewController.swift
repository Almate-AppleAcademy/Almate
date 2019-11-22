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
    //    let tableCellId = "Notif1TableViewCell"
    var requestLocalJob = LocalJob()
    private let imageView = UIImageView(image: UIImage(named: "Oval"))
    private var shoulResize: Bool?
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
        jobView.jobDelegate = self
        
        //        // Do any additional setup after loading the view.
        //        view.backgroundColor = .white
        ////        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationItem.title = "Jobs"
        //
        //        //navigationItem.title = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //        // Do any additional setup after loading the view.
        //               //        self.title = "News"
        //                       view.backgroundColor = .white
        //                       navigationController?.navigationBar.prefersLargeTitles = true
        //                       navigationItem.largeTitleDisplayMode = .always
        //               //        UINavigationBar.appearance().tintColor = .white
        //                       navigationController?.navigationBar.barStyle = UIBarStyle.black
        //
        //                       navigationItem.title = "Jobs"
        //               //        navigationController?.navigationBar.topItem?.title = "News"
        //                       navigationController?.view.backgroundColor = .clear
        //                       navigationController?.navigationBar.tintColor = .white
        //                       navigationController?.navigationBar.isTranslucent = false
        //                       navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //                       navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //
        //
//        let searchController = UISearchController(searchResultsController: nil)
//        
//        //searchController.searchBar.delegate = self
//        searchController.delegate = self
//        
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        
//        // searchController.searchBar.becomeFirstResponder()
//        self.navigationItem.titleView = searchController.searchBar
//        definesPresentationContext = true
//        
//        //                      // navigationController?.navigationBar.isTranslucent = true
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = true
//        //
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear
//        searchController.searchBar.tintColor = .white
//        searchController.searchBar.barTintColor = .white
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        //                       self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
        //
        //                       self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        navigationController?.setNavigationBarHidden(true, animated: true)

        
        setupUI()
        observeAndHandleOrientationMode()
        
        if UIDevice.current.orientation.isPortrait {
            shoulResize = true
        } else if UIDevice.current.orientation.isLandscape {
            shoulResize = false
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showImage(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let shoulResize = shoulResize
            else { assertionFailure("shoulResize wasn't set. reason could be non-handled device orientation state"); return }
        
        if shoulResize {
            moveAndResizeImageForPortrait()
        }
    }
    
    // MARK: - Scroll View Delegates
    
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
    
    // MARK: - Private methods
    
    private func setupUI() {
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
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    private func observeAndHandleOrientationMode() {
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
    
    private func moveAndResizeImageForPortrait() {
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
    }
    
    private func resizeImageForLandscape() {
        let yTranslation = Const.ImageSizeForLargeState * Const.ScaleForImageSizeForLandscape
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: Const.ScaleForImageSizeForLandscape, y: Const.ScaleForImageSizeForLandscape)
            .translatedBy(x: 0, y: yTranslation)
    }
    
    /// Show or hide the image from NavBar while going to next screen or back to initial screen
    ///
    /// - Parameter show: show or hide the image from NavBar
    private func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = show ? 1.0 : 0.0
        }
    }
}








extension JobsViewController: JobDelegate {
    func didTapPostJob() {
        let vc = PostJobViewController(nibName: "PostJobViewController", bundle: nil)
        self.navigationController?.present(vc, animated: true)
        print("hah")
    }
    
    
    func tappedSaveJob(_ state: UserCoreDataState, _ data: Admin) {
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



extension JobsViewController {
    /// WARNING: Change these constants according to your project's design
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 40
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 32
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
        /// Image height/width for Landscape state
        static let ScaleForImageSizeForLandscape: CGFloat = 0.65
    }
}
