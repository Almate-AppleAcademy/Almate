//
//  JobDetailView.swift
//  Almate
//
//  Created by Adrian Suryo Abiyoga on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class JobDetailView: UIView {
    
    @IBOutlet weak var jobImage: UIImageView!
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var titleJob: UILabel!
    @IBOutlet weak var imgJobCompany: UIImageView!
    @IBOutlet var phoneBtn: UIButton!
    @IBOutlet var emailBtn: UIButton!
    @IBOutlet var applyBtn: UIButton!
    
    override class func awakeFromNib() {
         super.awakeFromNib()
    }
    
}

extension JobDetailView: JobDetailInput {
    func displayJobDetail(dataJob: Job) {
        if dataJob != nil {
            jobImage.sd_setImage(with: URL(string: dataJob.jobPhotos[0]))
            companyName.text = dataJob.jobCompanyName
            jobDescription.text = dataJob.jobText
            titleJob.text = dataJob.jobTitle
            imgJobCompany.sd_setImage(with: URL(string: dataJob.jobCompanyLogo))
        }
    }
}

protocol JobDetailInput {
    func displayJobDetail(dataJob :Job)
}
