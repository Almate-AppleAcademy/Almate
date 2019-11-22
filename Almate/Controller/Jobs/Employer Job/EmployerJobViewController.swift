//
//  EmployerJobViewController.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 19/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerJobViewController: UIViewController, UIActionSheetDelegate {

    @IBOutlet var jobEmployerView: EmployerJobView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

           // Do any additional setup after loading the view.
        //        self.title = "News"
                view.backgroundColor = .white
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationItem.largeTitleDisplayMode = .always
        //        UINavigationBar.appearance().tintColor = .white
                navigationController?.navigationBar.barStyle = UIBarStyle.black
                
                navigationItem.title = "Jobs"
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
        jobEmployerView.jobOpeningsDelegate = self
                self.navigationItem.setHidesBackButton(true, animated:false)

    }


   
}

extension EmployerJobViewController: JobOpeningsDelegate {
    func didTappedEdit() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let action1 = UIAlertAction(title: "Close Job Opening", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
        }

        let action2 = UIAlertAction(title: "Edit Details", style: .default) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }

        let action3 = UIAlertAction(title: "Delete", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed the destructive");
        }
        let action4 = UIAlertAction(title: "Delete", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed the destructive");
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func didSelectItemAt() {
        let vc = JobDetailViewController(nibName: "JobDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("hah")
    }
    
    func didTappedPostJob() {
        let vc = PostJobViewController(nibName: "PostJobViewController", bundle: nil)
        self.navigationController?.present(vc, animated: true)
        print("hah")
    }
    
    
}

extension EmployerJobViewController: UISearchBarDelegate {
    
}
