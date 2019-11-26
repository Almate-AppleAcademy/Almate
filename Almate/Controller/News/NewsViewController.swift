//
//  NewsViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    var requestDummyData = DummyNews()
    
    @IBOutlet weak var newsView: NewsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.title = "News"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
//        UINavigationBar.appearance().tintColor = .white
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        navigationItem.title = "News"
//        navigationController?.navigationBar.topItem?.title = "News"
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.delegate = self
//        searchController.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

//        searchController.searchBar.becomeFirstResponder()
//        self.navigationItem.titleView = searchController.searchBar
//        definesPresentationContext = true

        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationItem.setHidesBackButton(true, animated:false)


        requestDummyData.getData { (dataPost) in
            self.newsView.dataPost = dataPost
        }
    }
    
    @IBAction func profileImageTapped(_ sender: Any) {
        let controller = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
        print("PROFILE TAPPED")
    }

    @IBAction func likeTapped(_ sender: UIButton) {
        print("LIKE TAPPED")
        let controller = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func commentTapped(_ sender: UIButton) {
//        print("COMMENTS TAPPED")
        let controller = CommentViewController(nibName: "CommentView", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
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
