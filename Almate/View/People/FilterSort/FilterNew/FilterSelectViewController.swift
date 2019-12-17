//
//  FilterSelectViewController.swift
//  Almate
//
//  Created by Qiarra on 13/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterSelectViewController: UIViewController {
    
    var itemSelected: FilterItem?
    var remotePeople = RemotePeople() // this object is only used for cohort and jobfield
    var queryValue: String?
    @IBOutlet var filterSelectView: FilterSelectView!
    var filterSortInput: (([String]) -> Void)?
    var items: [String]?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterSelectView.delegate = self
        navigationSetup()
        // Do any additional setup after loading the view.
        if let itemSelected = itemSelected {
            switch itemSelected {
            case .Cohort:
                // Request Array Cohort
                queryValue = "userGeneration"
                self.remotePeople.loadFilterItem(itemFilter: itemSelected, queryValue: queryValue!) { (data) in
                    let finalData = self.uniqueElementsFrom(array: data)
                    self.filterSelectView.displayItem(items: finalData, filterType: itemSelected)
                }
                break
            case .JobField:
                // Request ArrayField
                queryValue = "userOccupation"
                self.remotePeople.loadFilterItem(itemFilter: itemSelected, queryValue: queryValue!) { (data) in
                    let finalData = self.uniqueElementsFrom(array: data)
                    self.filterSelectView.displayItem(items: finalData, filterType: itemSelected)
                }
                break
            case .Location:
                // Request Array Location
                queryValue = "userLocation"
                break
            default:
                // Request Array Skills
                queryValue = "skills"
                break
            }
        }
    }
    
    func navigationSetup() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonAction(sender:))
        )
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(leftButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    func uniqueElementsFrom(array: [String]) -> [String] {
        //Create an empty Set to track unique items
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains($0) else {
                //If the set already contains this object, return false
                //so we skip it
                return false
            }
            //Add this item to the set since it will now be in the array
            set.insert($0)
            //Return true so that filtered array will contain this item.
            return true
        }
        return result
    }
    
    func didFinishSelected(handler: @escaping ([String]) -> Void) {
        filterSortInput = handler
    }
    
    
    @objc func doneButtonAction(sender: UIBarButtonItem) {
        if let items = items {
            let itemDict = ["index": index ?? 0, "items": items] as [String : Any]
            NotificationCenter.default.post(name: .didSelectedFilterItems, object: itemDict, userInfo: nil)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func leftButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterSelectViewController: FilterSelectViewDelegate {
    func selectedItems(items: [String]) {
        self.items = items
    }
}
