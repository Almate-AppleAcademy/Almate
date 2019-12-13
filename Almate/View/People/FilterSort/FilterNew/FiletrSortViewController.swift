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
    var filterSelectController: FilterSelectViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filterSelectController?.filterSortInput = self
        filterSortView?.delegate = self
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

extension FilterSortViewController: FilterSortDelegate {
    func didSelectFilter(item: FilterItem) {
        let filterSelectedController = FilterSelectViewController()
        filterSelectedController.itemSelected = item
        self.navigationController?.pushViewController(filterSelectedController, animated: true)
    }
}

extension FilterSortViewController: FilterSortViewControllerInput {
    func didFinishSelectedItem(_ items: [String]) {
        print(items)
    }
}



protocol FilterSortViewControllerInput {
    func didFinishSelectedItem(_ items: [String])
}
