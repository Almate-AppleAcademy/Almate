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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "News"
        
        searchController.searchBar.delegate = self
        //        searchController.delegate = self
                
                searchController.hidesNavigationBarDuringPresentation = false
                searchController.obscuresBackgroundDuringPresentation = false
                searchController.searchBar.placeholder = "Search GitHub Name User"
                
                searchController.searchBar.becomeFirstResponder()
                self.navigationItem.titleView = searchController.searchBar
                definesPresentationContext = true
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
