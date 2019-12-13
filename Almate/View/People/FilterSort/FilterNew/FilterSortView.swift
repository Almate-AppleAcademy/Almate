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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        filterSortTable.dataSource = self
        filterSortTable.delegate = self
        filterSortTable.register(UINib(nibName: "SortCell", bundle: nil), forCellReuseIdentifier: "sortCell")
        filterSortTable.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        
    }
    
    @IBAction func btnApply(_ sender: UIButton) {
        
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath as IndexPath) as! FilterCell
            cell.lblTitleFilter.text = FilterItem.allCases[indexPath.row].rawValue
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
            print(sortValue[indexPath.row])
            let cell = tableView.cellForRow(at: indexPath) as! SortCell
            cell.selectedBtn.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            delegate?.didSelectFilter(item: FilterItem.allCases[indexPath.row])
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

enum FilterItem: String, CaseIterable {
    case Cohort, Location, Skills, JobField
}

protocol FilterSortDelegate {
    func didSelectFilter(item: FilterItem)
}
