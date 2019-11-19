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
    var requestUserLocal = LocalUser()
    var requestPeopleRemote = RemotePeople()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        view.backgroundColor = .white
        peopleView.delegate = self
        
        //Request Users Institution Data
        requestPeopleRemote.loadPeople { (data) in
            print(data)
            self.peopleView.displayPeople(data)
        }
    }
    
    func tappedSaveContact(_ state: UserCoreDataState, _ data: User) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if state == .delete {
            
        } else {
            requestUserLocal.createData(data: data, appDelegate) {
                (message) in
                print(message)
            }
        }
    }
    
    @IBAction func didTapFilterButton(_ sender: Any) {
        self.navigationController?.present(UINavigationController(rootViewController: FilterViewController()), animated: true, completion: nil)
    }
    
    func setSearchBar() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barStyle = UIBarStyle.black
                
        navigationItem.title = "People"
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white

        navigationController?.navigationBar.isTranslucent = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .clear
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.white
    }
    
    func didSelectItemAt() {
        let controller = DetailPeopleViewController(nibName: "DetailPeopleViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension PeopleViewController: UISearchBarDelegate {
    
}
