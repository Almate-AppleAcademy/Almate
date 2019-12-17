//
//  FilterSortView.swift
//  Almate
//
//  Created by Qiarra on 13/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterSortView: UIView {
    
    @IBOutlet var filterSortTable: UITableView!
    var delegate: FilterSortDelegate?
    var filterItems = ["", "", "", ""]
    var didTapApply : (()->())?
    @IBOutlet var btnApply: UIButton!
    var sortValueSelected: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnApply.isEnabled = false
        filterSortTable.dataSource = self
        filterSortTable.delegate = self
        filterSortTable.register(UINib(nibName: "SortCell", bundle: nil), forCellReuseIdentifier: "sortCell")
        filterSortTable.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        
    }
    
    @IBAction func btnApply(_ sender: UIButton) {
        didTapApply?()
    }
}

extension FilterSortView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sortValue.count
        } else {
            return FilterItem.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath as IndexPath) as! SortCell
            cell.lblSortValue.text = sortValue[indexPath.row]
            self.btnApply.isEnabled = true
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath as IndexPath) as! FilterCell
            cell.lblTitleFilter.text = FilterItem.allCases[indexPath.row].rawValue
            cell.lblItemFilter.text = filterItems[indexPath.row]
            self.btnApply.isEnabled = true
            self.didTapApply = {
                () in
                self.delegate?.didTapAppluyFilter(sortItem: self.sortValueSelected ?? "", filterItem: self.filterItems)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fsTitle[section]
    }
}

extension FilterSortView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! SortCell
            cell.selectedBtn.setImage(UIImage(named: "checked"), for: .normal)
            self.sortValueSelected = sortValue[indexPath.row]
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! FilterCell
            delegate?.didSelectFilter(index: indexPath.row ,item: FilterItem.allCases[indexPath.row], title: cell.lblTitleFilter.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print(sortValue[indexPath.row])
            let cell = tableView.cellForRow(at: indexPath) as! SortCell
            cell.selectedBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fsTitle.count
    }
}

extension FilterSortView: FilterSortViewInput {
    func updateItemFilterSelected(_ index: Int?, data: [String]?) {
        if let data = data {
            if let index = index {
                print("\(index) for \(data)")
                self.filterItems.remove(at: index)
                self.filterItems.insert(data.joined(separator: ", "), at: index)
                self.filterSortTable.reloadData()
            }
        }
    }
}

enum FilterItem: String, CaseIterable {
    case Cohort, Location, Skills, JobField
}

protocol FilterSortDelegate {
    func didSelectFilter(index: Int, item: FilterItem, title: String)
    func didTapAppluyFilter(sortItem: String, filterItem: [String])
}

protocol FilterSortViewInput {
    func updateItemFilterSelected(_ index: Int?, data: [String]?)
}
