//
//  PeopleViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, PeopleViewDelegate {
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet var peopleView: PeopleView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBAction func pindah(_ sender: Any) {
        let vc = DetailPeopleViewController(nibName: "DetailPeopleViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("hah")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        view.backgroundColor = .white
        peopleView.delegate = self
        
    }
    
    func setSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        navigationController?.navigationBar.layer.cornerRadius = 15
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "People"
        navigationItem.titleView?.backgroundColor = UIColor.white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        //create a new button
        let button: UIButton = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "tiny-profile"), for: .normal)
        //add function for button
        button.addTarget(self, action: "fbButtonPressed", for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)

        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func didSelectItemAt() {
        let controller = DetailPeopleViewController(nibName: "DetailPeopleViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension PeopleViewController: UISearchBarDelegate {
    
}
