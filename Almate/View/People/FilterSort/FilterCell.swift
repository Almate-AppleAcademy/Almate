//
//  FilterCell.swift
//  Almate
//
//  Created by Qiarra on 14/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var lblTitleFilter: UILabel!
    @IBOutlet var lblItemFilter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
        // Initialization code
//        collectionListValue.dataSource = self
//        collectionListValue.delegate = self
//        collectionListValue.register(UINib(nibName: "FilterValueCell", bundle: nil), forCellWithReuseIdentifier: "filterValueCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension FilterCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterValueCell", for: indexPath as IndexPath) as! FilterValueCell
        cell.buttonValue.setTitle(filterValues[indexPath.row], for: .normal)
        cell.didTapValue = {
            () in
            print("pp")
        }
        return cell
    }
}

extension FilterCell: UICollectionViewDelegate {
    
}

let filterValues = ["All", "Cohort 1", "Cohort 2", "Cohort 3"]
