//
//  PeopleViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class PeopleViewController: UIViewController, PeopleViewDelegate {
    func didTapSearchIcon() {
        
    }
    
    
    var shoulResize: Bool?
    var searchPicture = UIImageView(image: UIImage(named: "white-1"))
    var profilePicture = UIImageView(image: UIImage(named: "Oval"))
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    @IBOutlet var peopleView: PeopleView!
    private let searchController = UISearchController(searchResultsController: nil)
    var requestUserLocal = LocalUser()
    var requestPeopleRemote = RemotePeople()
    var likeState: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setSearchBar()
        view.backgroundColor = .white
        peopleView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(appliedSortFilter(notification:)), name: .appliedSortFilter, object: nil)
        observeQuery()
        
        
        setupUI()
        observeAndHandleOrientationMode()
        self.tabBarController?.tabBar.isHidden = false
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(profileGesture)
        
        let searchGesture = UITapGestureRecognizer(target: self, action: #selector(searchTapped(_:)))
        searchPicture.isUserInteractionEnabled = true
        searchPicture.addGestureRecognizer(searchGesture)
        
        if UIDevice.current.orientation.isPortrait {
            shoulResize = true
        } else if UIDevice.current.orientation.isLandscape {
            shoulResize = false
        }
    }
    
    func observeQuery() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        requestUserLocal.readDataLocal(appDelegate) { (dataLocal) in
            self.peopleView.getPeopleSaved(dataLocal)
            //Request Users Institution Data
            self.requestPeopleRemote.loadPeople(originQuery: self.query ,completionBlock: { (data, documents) in
                if dataLocal.count == 0 {
                    for _ in documents {
                        self.likeState.append(false)
                    }
                    self.peopleView.displayPeople(data, documents, self.likeState)
                } else {
                    self.likeState.removeAll()
                    for dataLoc in dataLocal {
                        for document in documents {
                            if dataLoc.userId == document.documentID {
                                self.likeState.append(true)
                            } else { self.likeState.append(false) }
                        }
                    }
                    self.peopleView.displayPeople(data, documents, self.likeState)
                }
            })
        }
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
        title = "People"
        
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(profilePicture)
        profilePicture.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        profilePicture.clipsToBounds = true
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.addSubview(searchPicture)
        // SearchView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        searchPicture.clipsToBounds = true
        searchPicture.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePicture.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Const.ImageRightMargin),
            profilePicture.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Const.ImageBottomMarginForLargeState),
            profilePicture.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            profilePicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor),
            searchPicture.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                              constant: -Const.SearchRightMargin),
            searchPicture.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                               constant: -Const.ImageBottomMarginForLargeState),
            searchPicture.heightAnchor.constraint(equalToConstant: Const.SearchSizeForLargeState),
            searchPicture.widthAnchor.constraint(equalTo: profilePicture.heightAnchor)
        ])
    }
//    func observeAndHandleOrientationMode() {
//        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: OperationQueue.current) { [weak self] _ in
//            
//            if UIDevice.current.orientation.isPortrait {
//                self?.title = "People"
//                self?.moveAndResizeImageForPortrait()
//                self?.shoulResize = true
//            } else if UIDevice.current.orientation.isLandscape {
//                self?.title = "People"
//                self?.resizeImageForLandscape()
//                self?.shoulResize = false
//            }
//        }
//    }
//    func ShouldResize(){
//        guard let shoulResize = shoulResize
//            else { assertionFailure("shoulResize wasn't set. reason could be non-handled device orientation state"); return }
//        
//        if shoulResize {
//            moveAndResizeImageForPortrait()
//        }
//    }
//    func deviceOrientation(){
//        if UIDevice.current.orientation.isPortrait {
//            shoulResize = true
//        } else if UIDevice.current.orientation.isLandscape {
//            shoulResize = false
//        }
//    }
    
    @objc func appliedSortFilter(notification: Notification) {
        let dict = notification.object as? NSDictionary
        let filterItem = dict!["filterItem"] as? [String]
        let sortItem = dict!["sortItem"] as? String
        
        var filteredQuery = baseQuery()
        
        if let sort = sortItem, !sortItem!.isEmpty {
            if sort == "Ascending order A-Z" {
                filteredQuery = filteredQuery.order(by: "firstName", descending: false)
            } else {
                filteredQuery = filteredQuery.order(by: "firstName", descending: true)
            }
        }
        
        if let cohort = filterItem?[0], !cohort.isEmpty {
            filteredQuery = filteredQuery.whereField("userGeneration", isEqualTo: cohort)
        }
        
        if let location = filterItem?[1], !location.isEmpty {
            filteredQuery = filteredQuery.whereField("userLocation", isEqualTo: location)
        }
        
        if let skills = filterItem?[2], !skills.isEmpty {
            filteredQuery = filteredQuery.whereField("userSkills", isEqualTo: skills)
        }
        
        if let job = filterItem?[3], !job.isEmpty {
            filteredQuery = filteredQuery.whereField("userOccupation", isEqualTo: job)
        }
        
        query = filteredQuery
        observeQuery()
    }
    
    func baseQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users").limit(to: 50)
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
        
        profilePicture.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
        searchPicture.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func resizeImageForLandscape() {
        let yTranslation = Const.ImageSizeForLargeState * Const.ScaleForImageSizeForLandscape
        profilePicture.transform = CGAffineTransform.identity
            .scaledBy(x: Const.ScaleForImageSizeForLandscape, y: Const.ScaleForImageSizeForLandscape)
            .translatedBy(x: 0, y: yTranslation)
        searchPicture.transform = CGAffineTransform.identity
            .scaledBy(x: Const.ScaleForImageSizeForLandscape, y: Const.ScaleForImageSizeForLandscape)
            .translatedBy(x: 0, y: yTranslation)
    }
    
    /// Show or hide the image from NavBar while going to next screen or back to initial screen
    ///
    /// - Parameter show: show or hide the image from NavBar
    func showImage(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.profilePicture.alpha = show ? 1.0 : 0.0
            self.searchPicture.alpha = show ? 1.0 : 0.0
        }
    }
    
    //MARK: -ACTION HANDLER
    
    @IBAction func didTapFilterButton(_ sender: Any) {
        self.navigationController?.present(UINavigationController(rootViewController: FilterSortViewController()), animated: true, completion: nil)
    }
    
    func didSelectItemAt(_ dataPeople: User, _ documents: QueryDocumentSnapshot) {
        let controller = DetailPeopleViewController(nibName: "DetailPeopleViewController", bundle: nil)
        controller.dataPeople = dataPeople
        controller.documents = documents
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapProfileIcon() {
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    func tappedSaveContact(_ state: UserCoreDataState, _ data: UserLocal) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if state == .delete {
            requestUserLocal.deleteData(data: data, appDelegate) { (message) in
                print(message)
            }
        } else {
            requestUserLocal.createData(data: data, appDelegate) {
                (message) in
                print(message)
            }
        }
    }
}

extension PeopleViewController: UISearchBarDelegate {
    
}
