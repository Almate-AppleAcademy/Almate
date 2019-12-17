//
//  SearchViewController.swift
//  Almate
//
//  Created by Qiarra on 16/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class SearchViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var previousRun = Date()
    private let minInterval = 0.05
    private let requestJob = RemoteJob()
    private let requestPeople = RemotePeople()
    private let requestNews = RemoteNews()
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initSearchBar()
        initNaviagtion()
    }
    
    func initNaviagtion() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func initSearchBar() {
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search People, News and Others"
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    func baseQuery(_ searchType: SearchType) -> Query {
        let firestore = Firestore.firestore()
        var query: Query?
        switch searchType {
        case .Job:
            query = firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Jobs").limit(to: 50)
        case .News:
            query = firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Post").limit(to: 50)
        default:
            query = firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users").limit(to: 50)
        }
        
        return query!
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textSearch = searchBar.text, !textSearch.isEmpty else {
            return
        }
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            fetchResult(for: textSearch)
        }
    }
    
    func fetchResult(for text: String) {
        query = baseQuery(.News)
        query?.whereField("newsText", isEqualTo: text)
        requestNews.requestDataNews(originQuery: query) { (dataNews, documents) in
            
            self.query?.whereField("jobTitle", isEqualTo: text)
            self.query = self.baseQuery(.Job)
            self.requestJob.loadAllJob(originQuery: self.query) { (dataJob, documents) in
                
                self.query = self.baseQuery(.People)
                self.query?.whereField("firstName", isEqualTo: text)
                self.requestPeople.loadPeople(originQuery: self.query) { (dataUser, documents) in
//                    print(dataNews)
                                        print(dataJob)
                    //                    print(dataUser)
                }
            }
        }
    }
}

enum SearchType: String ,CaseIterable {
    case People, Job, News
}
