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
    @IBOutlet weak var rbSort: DLRadioButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for radioButton in self.rbSort.otherButtons {
            radioButton.isSelected = true;
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc @IBAction private func logSelectedButton(radioButton : DLRadioButton) {
        
        if (radioButton.isMultipleSelectionEnabled) {
            for button in radioButton.selectedButtons() {
                print(String(format: "%@ is selected.\n", button.titleLabel!.text!));
            }
        } else {
            print(String(format: "%@ is selected.\n", radioButton.selected()!.titleLabel!.text!));
        }
    }

}
