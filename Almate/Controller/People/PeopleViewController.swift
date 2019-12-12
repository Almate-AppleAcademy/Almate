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
    
    var shoulResize: Bool?
    var SearchView = UIImageView(image: UIImage(named: "white-1"))
    var imageView = UIImageView(image: UIImage(named: "Oval"))
    
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        requestUserLocal.readDataLocal(appDelegate) { (dataLocal) in
            self.peopleView.getPeopleSaved(dataLocal)
            //Request Users Institution Data
            self.requestPeopleRemote.loadPeople(completionBlock: { (data, documents) in
                if dataLocal.count == 0 {
                    for _ in documents {
                        self.likeState.append(false)
                    }
                    self.peopleView.displayPeople(data, documents, self.likeState)
                } else {
                    for dataLoc in dataLocal {
                        for document in documents {
                            if dataLoc.userId == document.documentID {
                                self.likeState.append(true)
                                print(self.likeState)
                            } else { self.likeState.append(false) }
                        }
                    }
                    self.peopleView.displayPeople(data, documents, self.likeState)
                }
            })
        }
        
        setupUI()
        observeAndHandleOrientationMode()
        self.tabBarController?.tabBar.isHidden = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        if UIDevice.current.orientation.isPortrait {
            shoulResize = true
        } else if UIDevice.current.orientation.isLandscape {
            shoulResize = false
        }
    }
    
    // MARK: -UI SETUP
    
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
    
    func observeAndHandleOrientationMode() {
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: OperationQueue.current) { [weak self] _ in
            
            if UIDevice.current.orientation.isPortrait {
                self?.title = "People"
                self?.moveAndResizeImageForPortrait()
                self?.shoulResize = true
            } else if UIDevice.current.orientation.isLandscape {
                self?.title = "People"
                self?.resizeImageForLandscape()
                self?.shoulResize = false
            }
        }
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
    
    //MARK: -ACTION HANDLER
    
    @IBAction func didTapFilterButton(_ sender: Any) {
        self.navigationController?.present(UINavigationController(rootViewController: FilterViewController()), animated: true, completion: nil)
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
