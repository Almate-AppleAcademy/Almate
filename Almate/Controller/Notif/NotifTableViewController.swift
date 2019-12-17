//
//  NotifViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

//struct cellData {
//    let cell: Int!
//    let news: String!
//    let date: String!
//    let image: UIImage!
//}

class NotifTableViewController: UITableViewController{
    var shoulResize: Bool?
    var SearchView = UIImageView(image: UIImage(named: "white-1"))
    var imageView = UIImageView(image: UIImage(named: "Oval"))

    let sectionTitle: [String] = ["Today", "Older"]
//    var people = ["Gabriella Gracia", "Finn the Human", "Angel", "Jake the Dog", "Tree trunk", "Chealse"]
//    var people2 = ["Adrian", "Andi", "Anienka", "Gabby", "Mirza", "Slamet"]
    
    
    
    var peoples = [["Gabriella Gracia", "Finn the Human", "Angel", "Jake the Dog", "Tree trunk", "Chealse"], ["Adrian", "Andi", "Anienka", "Gabby", "Mirza", "Slamet"]]
    
    
    
    
    var time = [["1hr", "3hr", "4hr", "8hr", "10hr", "12hr"], ["1W","1W","2W","3W","5W", "8W"]]
    var searchable = [Searchable]()
    var imageNotif: [UIImage]? = [(UIImage(named: "Photo 27-10-19 23.36.17")!), UIImage(named: "Photo 27-10-19 23.36.41")!, UIImage(named: "Photo 28-10-19 02.23.51")!, UIImage(named: "profile")!, UIImage(named: "tiny-profile")!, UIImage(named: "Photo 27-10-19 23.36.17")!]

//    var arrayOfCellData = [Data]()
//    var arrayOfCellOlder = [Data]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Notification"
//        tabBarItem.badgeValue = "12"
        
//        arrayOfCellData = [cellData(cell: 1, news: "Gabriella Gracia added you", date: "2hr", image: #imageLiteral(resourceName: "Photo 28-10-19 02.23.51")), cellData(cell: 1, news: "Chealse view your profile", date: "5hr", image: #imageLiteral(resourceName: "Photo 27-10-19 23.36.17")), cellData(cell: 1, news: "Angel added you", date: "12hr", image: #imageLiteral(resourceName: "Photo 27-10-19 23.36.41"))]
//
//         arrayOfCellOlder = [cellData(cell: 1, news: "Finn the Human added you", date: "2W", image: #imageLiteral(resourceName: "Photo 28-10-19 02.23.51")), cellData(cell: 1, news: "Jake the Dog view your profile", date: "5W", image: #imageLiteral(resourceName: "Photo 27-10-19 23.36.17")), cellData(cell: 1, news: "Tree trunk added you", date: "8W", image: #imageLiteral(resourceName: "Photo 27-10-19 23.36.41"))
        

//        arrayToday()
//        arrayOlder()

        
        tableView.register(UINib(nibName: "Notif1TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell1")
        tableView.register(UINib(nibName: "Notif2TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell2")
        
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
        setupUI()
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
        showImage(true)
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        ShouldResize()
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    guard let shoulResize = shoulResize
//        else { assertionFailure("shoulResize wasn't set. reason could be non-handled device orientation state"); return }
    navigationController?.view.backgroundColor = #colorLiteral(red: 0.127440244, green: 0.1577139199, blue: 0.1955760121, alpha: 1)
    navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1276172996, green: 0.1577090323, blue: 0.1955741942, alpha: 1)
    navigationController?.navigationBar.isTranslucent = false
//    if shoulResize {
//        moveAndResizeImageForPortrait()
//        }
    }
         func observeAndHandleOrientationMode() {
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: OperationQueue.current) { [weak self] _ in
                
                if UIDevice.current.orientation.isPortrait {
                    self?.title = "Notification"
                    self?.moveAndResizeImageForPortrait()
                    self?.shoulResize = true
                } else if UIDevice.current.orientation.isLandscape {
                    self?.title = "Notification"
                    self?.resizeImageForLandscape()
                    self?.shoulResize = false
                }
            }
        }
//    func ShouldResize(){
//        guard let shoulResize = shoulResize
//            else { assertionFailure("shoulResize wasn't set. reason could be non-handled device orientation state"); return }
//
//        if shoulResize {
//           moveAndResizeImageForPortrait()
//        }
//    }
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
           title = "Notification"
           
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
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return peoples[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9646214843, green: 0.9647600055, blue: 0.9645912051, alpha: 1)
        
        let judul = UILabel()
        judul.frame = CGRect(x: 15, y: 15, width: 300, height: 35)
        judul.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        judul.text = sectionTitle[section]
        judul.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(judul)
        
        return view
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        if section == 1
////        {
////            return "Today"
////        }
////        return "Older"
////        return sectionTitle[section]
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if arrayOfCellData[indexPath.row].cell == 1
//        {
//            let cell = Bundle.main.loadNibNamed("Notif1TableViewCell", owner: self, options: nil)?.first as! Notif1TableViewCell
//
//            cell.coPhotoOutlet.image = arrayOfCellData[indexPath.row].image
//            cell.notif1Outlet.text = arrayOfCellData[indexPath.row].news
//            cell.date1Outlet.text = arrayOfCellData[indexPath.row].date
//            return cell
//        }
//        else if arrayOfCellData[indexPath.row].cell == 2
//        {
//            let cell = Bundle.main.loadNibNamed("Notif2TableViewCell", owner: self, options: nil)?.first as! Notif2TableViewCell
//
//            cell.profilePictOutlet.image = arrayOfCellData[indexPath.row].image
//            cell.notificationOutlet.text = arrayOfCellData[indexPath.row].news
//            cell.dateOutlet.text = arrayOfCellData[indexPath.row].date
//            return cell
//        }
//        else
//        {
//            let cell = Bundle.main.loadNibNamed("Notif1TableViewCell", owner: self, options: nil)?.first as! Notif1TableViewCell
//
//            cell.coPhotoOutlet.image = arrayOfCellData[indexPath.row].image
//            cell.notif1Outlet.text = arrayOfCellData[indexPath.row].news
//            cell.date1Outlet.text = arrayOfCellData[indexPath.row].date
//            return cell
//        }
        
//        if searchable[indexPath.row].today.name != nil
//        {
            let cell : Notif1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell1", for: indexPath) as! Notif1TableViewCell
            
            cell.notif1Outlet.text = self.peoples[indexPath.section][indexPath.row]
            cell.date1Outlet.text = self.time[indexPath.section][indexPath.row]
            if indexPath.section == 0 {
                cell.coPhotoOutlet.image = self.imageNotif![indexPath.row]
            } else {
                cell.coPhotoOutlet.image = self.imageNotif![indexPath.row]
            }
       
            return cell
//        }
//        else
//        {
//            let cell : Notif2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell2", for: indexPath) as! Notif2TableViewCell
//            cell.notificationOutlet.text = self.peoples[indexPath.section][indexPath.row]
//            return cell
//        }
//
//        let cell : Notif2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell2", for: indexPath) as! Notif2TableViewCell
//
//        cell.notificationOutlet.text = self.peoples[indexPath.section][indexPath.row]
//        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if arrayOfCellData[indexPath.row].cell == 1
//        {
//                    return 80
//        }
//        else if arrayOfCellData[indexPath.row].cell == 2
//        {
//                    return 80
//        }
//        else
//        {
//            return 80
//        }
//        if searchable[indexPath.row].today.name != nil
//        {
            return 80
//        }
//        else
//        {
//            return 80
//        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    func arrayToday()
//    {
//        for each in people
//        {
//            var today = Today()
//            today.name = each
//            var element = Searchable()
//            element.today = today
//            self.searchable.append(element)
//        }
//        tableView.reloadData()
//    }
//
//    func arrayOlder()
//    {
//        for each in people2
//        {
//            var older = Older()
//            older.name = each
//            var element = Searchable()
//            element.older = older
//            self.searchable.append(element)
//        }
//    }
    
    
    class Today{
        var name: String?
    }
    
    class Older{
        var name: String?
    }
    
    class Searchable{
        var today = Today()
        var older = Older()
    }
    
}

extension UITabBarController
{
    override open func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.tabBar.items![3].badgeValue = nil
//        if tabBar.items![3].badgeValue != nil
//        {
//            self.tabBar.items![3].badgeValue = "1"
//        }

    }
}
//extension UITabBar {
//    func setBadge(value: String?, at index: Int, withConfiguration configuration: TabBarBadgeConfiguration = TabBarBadgeConfiguration()) {
//        let existingBadge = subviews.first { ($0 as? TabBarBadge)?.hasIdentifier(for: index) == true }
//        existingBadge?.removeFromSuperview()
//
//        guard let tabBarItems = items,
//            let value = value else { return }
//
//        let itemPosition = CGFloat(index + 1)
//        let itemWidth = frame.width / CGFloat(tabBarItems.count)
//        let itemHeight = frame.height
//
//        let badge = TabBarBadge(for: index)
//        badge.frame.size = configuration.size
//        badge.center = CGPoint(x: (itemWidth * itemPosition) - (0.5 * itemWidth) + configuration.centerOffset.x,
//                               y: (0.5 * itemHeight) + configuration.centerOffset.y)
//        badge.layer.cornerRadius = 0.5 * configuration.size.height
//        badge.clipsToBounds = true
//        badge.textAlignment = .center
//        badge.backgroundColor = configuration.backgroundColor
//        badge.font = configuration.font
//        badge.textColor = configuration.textColor
//        badge.text = value
//
//        addSubview(badge)
//    }
//}
//
//class TabBarBadge: UILabel {
//    var identifier: String = String(describing: TabBarBadge.self)
//
//    private func identifier(for index: Int) -> String {
//        return "\(String(describing: TabBarBadge.self))-\(index)"
//    }
//
//    convenience init(for index: Int) {
//        self.init()
//        identifier = identifier(for: index)
//    }
//
//    func hasIdentifier(for index: Int) -> Bool {
//        let has = identifier == identifier(for: index)
//        return has
//    }
//}
//
//class TabBarBadgeConfiguration {
//    var backgroundColor: UIColor = .red
//    var centerOffset: CGPoint = .init(x: 12, y: -9)
//    var size: CGSize = .init(width: 17, height: 17)
//    var textColor: UIColor = .white
//    var font: UIFont! = .systemFont(ofSize: 11) {
//        didSet { font = font ?? .systemFont(ofSize: 11) }
//    }
//
//    static func construct(_ block: (TabBarBadgeConfiguration) -> Void) -> TabBarBadgeConfiguration {
//        let new = TabBarBadgeConfiguration()
//        block(new)
//        return new
//    }
//}
