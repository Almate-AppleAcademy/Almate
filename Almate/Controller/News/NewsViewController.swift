//
//  NewsViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class NewsViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    //    var requestDummyData = DummyNews()
    var shoulResize: Bool?
    var SearchView = UIImageView(image: UIImage(named: "white-1"))
    var imageView = UIImageView(image: UIImage(named: "Oval"))
    
    @IBOutlet var newsView: NewsView!
    var remoteNews = RemoteNews()
    var requestLocalNews = LocalNews()
    var likeState: [Bool] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsView.delegate = self
        // Do any additional setup after loading the view.
        //        self.title = "News"
        //        view.backgroundColor = .white
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationItem.largeTitleDisplayMode = .always
        ////        UINavigationBar.appearance().tintColor = .white
        //        navigationController?.navigationBar.barStyle = UIBarStyle.black
        //
        //        navigationItem.title = "News"
        ////        navigationController?.navigationBar.topItem?.title = "News"
        //        navigationController?.view.backgroundColor = .clear
        //        navigationController?.navigationBar.tintColor = .white
        //        navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        //        let searchController = UISearchController(searchResultsController: nil)
        //
        //        searchController.searchBar.delegate = self
        ////        searchController.delegate = self
        //
        //        searchController.hidesNavigationBarDuringPresentation = false
        //        searchController.obscuresBackgroundDuringPresentation = false
        //        searchController.searchBar.placeholder = "Search"
        
        //        searchController.searchBar.becomeFirstResponder()
        //        self.navigationItem.titleView = searchController.searchBar
        //        definesPresentationContext = true
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        //        navigationItem.searchController = searchController
        //        navigationItem.hidesSearchBarWhenScrolling = false
        
        //        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear
        //        searchController.searchBar.tintColor = .white
        //        searchController.searchBar.barTintColor = .white
        //        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        
        //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        requestLocalNews.readDataLocal(appDelegate) { (dataLocal) in
            self.remoteNews.requestDataNews(originQuery: nil) { (dataRemote, documents) in
                print(dataLocal)
                if dataLocal.count == 0 {
                    for _ in documents {
                        self.likeState.append(false)
                    }
                    //                    self.newsView.displayNews(dataRemote, documents, self.likeState)
                } else {
                    self.likeState.removeAll()
                    for local in dataLocal {
                        for document in documents {
                            if document.documentID == local.postId {
                                self.likeState.append(true)
                            } else {
                                self.likeState.append(false)
                            }
                        }
                    }
                }
                self.newsView.displayNews(dataRemote, documents)
            }
        }
        
        self.tabBarController?.tabBar.isHidden = false
//        setupUI()
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showImage(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
        showImage(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        ShouldResize()
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
                self?.title = "News"
                self?.moveAndResizeImageForPortrait()
                self?.shoulResize = true
            } else if UIDevice.current.orientation.isLandscape {
                self?.title = "News"
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
        title = "News"
        
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
    
    
    
    override func awakeFromNib() {
        view.backgroundColor = .white
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationItem.largeTitleDisplayMode = .always
        //       UINavigationBar.appearance().tintColor = .white
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        //
        //        navigationItem.title = "News"
        ////        navigationController?.navigationBar.topItem?.title = "News"
        //        navigationController?.view.backgroundColor = .clear
        //        navigationController?.navigationBar.tintColor = .white
        //        navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //
        //
        //        let searchController = UISearchController(searchResultsController: nil)
        //
        //        searchController.searchBar.delegate = self
        ////        searchController.delegate = self
        //
        //        searchController.hidesNavigationBarDuringPresentation = false
        //        searchController.obscuresBackgroundDuringPresentation = false
        //        searchController.searchBar.placeholder = "Search"
        //
        ////        searchController.searchBar.becomeFirstResponder()
        ////        self.navigationItem.titleView = searchController.searchBar
        ////        definesPresentationContext = true
        //
        //
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationController?.navigationBar.isTranslucent = true
        //        navigationItem.searchController = searchController
        //        navigationItem.hidesSearchBarWhenScrolling = false
        //
        //        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear
        //        searchController.searchBar.tintColor = .white
        //        searchController.searchBar.barTintColor = .white
        //        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // self.navigationItem.setHidesBackButton(true, animated:false)
    }
    
    
    
    
    //    @IBAction func commentTapped(_ sender: UIButton) {
    //        print("COMMENTS TAPPED")
    //
    //        self.navigationController?.pushViewController(CommentViewController(), animated: true)
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}

extension NewsViewController: UISearchBarDelegate {
    
}

extension NewsViewController: NewsViewDelegate {
    
    func didLikePost(DocumentID: String, likeNumber: Int){
        self.remoteNews.updatePostLikes(documentID: DocumentID, likeNumber: likeNumber)
    }
    
    func didTapComment(_ documents: QueryDocumentSnapshot?) {
        let controller = CommentViewController()
        controller.commentDocument = documents
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
