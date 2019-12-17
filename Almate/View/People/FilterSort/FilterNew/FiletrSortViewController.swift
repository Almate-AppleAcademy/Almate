//
//  FilterSortViewController.swift
//  Almate
//
//  Created by Qiarra on 13/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterSortViewController: UIViewController {
    
    @IBOutlet var filterSortView: FilterSortView?
    var filterSelectController = FilterSelectViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterSortView?.delegate = self
        navigationSetup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishSelectedItem(notification:)), name: .didSelectedFilterItems, object: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func didFinishSelectedItem(notification: Notification) {
        let dict = notification.object as? NSDictionary
        let index = dict!["index"]
        let items = dict!["items"]
        filterSortView?.updateItemFilterSelected(index as? Int, data: items as? [String])
    }
    
    func navigationSetup() {
        self.navigationItem.title = "Filter"
        let rightButtonItem = UIBarButtonItem.init(
            title: "Reset",
            style: .done,
            target: self,
            action: #selector(resetButtonAction(sender:))
        )
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(cancelButtonAction(sender:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func resetButtonAction(sender: UIBarButtonItem) {
        
    }
    
    @objc func cancelButtonAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
} 

extension FilterSortViewController: FilterSortDelegate {
    func didTapAppluyFilter(sortItem: String, filterItem: [String]) {
        let itemDict = ["filterItem": filterItem, "sortItem": sortItem] as [String : Any]
        NotificationCenter.default.post(name: .appliedSortFilter, object: itemDict, userInfo: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didSelectFilter(index: Int,item: FilterItem, title: String) {
        let filterSelectedController = FilterSelectViewController()
        filterSelectedController.itemSelected = item
        filterSelectedController.title = title
        filterSelectedController.index = index; self.navigationController?.pushViewController(filterSelectedController, animated: true)
    }
}
