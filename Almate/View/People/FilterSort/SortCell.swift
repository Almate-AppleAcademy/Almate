//
//  SortCell.swift
//  Almate
//
//  Created by Qiarra on 14/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import DLRadioButton


class SortCell: UITableViewCell {

    @IBOutlet weak var lblSortValue: UILabel!
    @IBOutlet var selectedBtn: UIButton!
    weak var delegate: SortCellDelegate?
    var currentIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
        // Initialization code
//        for radioButton in self.rbSort.otherButtons {
//            radioButton.isSelected = true;
//        }
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    func didTapItem(_ index: Int?, _ cell: SortCell?, _ tableView: UITableView) {
        if currentIndex == nil {
            cell?.selectedBtn.setImage(UIImage(named: "checked"), for: .normal)
            currentIndex = index
        } else {
            cell?.selectedBtn.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func sortItemSelectetd(_ sender: UIButton) {
        print("selected bro")
    }
    
}

protocol SortCellDelegate: class {
    func didSelectedSortItem(_ cell: SortCell)
}


