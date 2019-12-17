//
//  FilterSelectView.swift
//  Almate
//
//  Created by Qiarra on 13/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterSelectView: UIView {
    
    var delegate: FilterSelectViewDelegate?
    @IBOutlet var filterItemTable: UITableView!
    var data: [String]?
    var itemSelected: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterItemTable.dataSource = self
        filterItemTable.delegate = self
        filterItemTable.register(UINib(nibName: "SortCell", bundle: nil), forCellReuseIdentifier: "sortCell")
    }
    
    func setSelectionType(_ filterType: FilterItem) {
        switch filterType {
        case .Cohort:
            filterItemTable.allowsSelection = true
            filterItemTable.allowsMultipleSelection = false
            break
            
        case .JobField:
            filterItemTable.allowsSelection = true
            filterItemTable.allowsMultipleSelection = true
            break
            
        case .Location:
            filterItemTable.allowsSelection = true
            filterItemTable.allowsMultipleSelection = false
            break
            
        default:
            filterItemTable.allowsSelection = true
            filterItemTable.allowsMultipleSelection = false
            break
            
        }
    }
}

extension FilterSelectView: FilterSelectViewInput {
    func displayItem(items: [String], filterType: FilterItem) {
        data = items
        setSelectionType(filterType)
        filterItemTable.reloadData()
    }
}

extension FilterSelectView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath as IndexPath) as! SortCell
        if let data = data {
            cell.lblSortValue.text = data[indexPath.row]
        } else {
            return UITableViewCell()
        }
        return cell
    }
}

extension FilterSelectView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortCell
        cell.selectedBtn.setImage(UIImage(named: "checked"), for: .normal)
        if let data = data {
            itemSelected.append(data[indexPath.row])
            self.delegate?.selectedItems(items: itemSelected)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortCell
        cell.selectedBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        if let data = data {
            let newItemSelected = itemSelected.filter { $0 != "\(data[indexPath.row])" }
            itemSelected = newItemSelected
        }
    }
}

protocol FilterSelectViewDelegate {
    func selectedItems(items: [String])
}

protocol FilterSelectViewInput {
    func displayItem(items: [String], filterType: FilterItem)
}
