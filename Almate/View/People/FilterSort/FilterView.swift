//
//  FilterView.swift
//  Almate
//
//  Created by Qiarra on 14/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    @IBOutlet weak var sortFilterTable: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sortFilterTable.dataSource = self
        sortFilterTable.register(UINib(nibName: "SortCell", bundle: nil), forCellReuseIdentifier: "sortCell")
        sortFilterTable.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: "filterCell")
    }
}

extension FilterView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sortValue.count
        } else {
            return filterTitle.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath as IndexPath) as! SortCell
            cell.lblSortValue.text = sortValue[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath as IndexPath) as! FilterCell
            cell.lblTitleFilter.text = filterTitle[indexPath.row]
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension FilterView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 45
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        let title = UILabel()
        title.frame = CGRect(x: 15, y: 15, width: 300, height: 35)
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.text = fsTitle[section]
        title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(title)
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fsTitle[section]
    }
}

enum FilterHeader: String {
    case sort = "Sort"
    case filter = "Filter"
}

let fsTitle = ["Sort", "Filter"]
let sortValue = ["Ascending order A-Z", "Descending order Z-A", "Most relevant"]
let filterTitle = ["Cohort", "Location", "Skills", "Field"]
