//
//  Job.swift
//  Almate
//
//  Created by Qiarra on 30/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation

// MARK: - Job
struct Job  {
    var jobCompanyEmail, jobCompanyLogo, jobCompanyName: String
    var jobLocation, jobText, jobTitle: String
    var jobPhotos: [String]
    
    var dictionary: [String:Any] {
        return [
            "jobCompanyEmail": jobCompanyEmail,
            "jobCompanyLogo": jobCompanyLogo,
            "jobCompanyName": jobCompanyName,
            "jobLocation": jobLocation,
            "jobText": jobText,
            "jobTitle": jobTitle,
            "jobPhotos": jobPhotos
        ]
    }
}

extension Job: DocumentSerializable {
    init?(dictionary: [String:Any]) {
        guard let jobCompanyEmail = dictionary["jobCompanyEmail"] as? String,
                let jobCompanyLogo = dictionary["jobCompanyLogo"] as? String,
                let jobCompanyName = dictionary["jobCompanyName"] as? String,
                let jobLocation = dictionary["jobLocation"] as? String,
                let jobText = dictionary["jobText"] as? String,
                let jobTitle = dictionary["jobTitle"] as? String,
                let jobPhotos = dictionary["jobPhotos"] as? [String] else { return nil}
        
        self.init(jobCompanyEmail: jobCompanyEmail, jobCompanyLogo: jobCompanyLogo, jobCompanyName: jobCompanyName, jobLocation: jobLocation, jobText: jobText, jobTitle: jobTitle, jobPhotos: jobPhotos)
    }
}

struct JobPost {
    var jobCompanyEmail, jobCompanyName: String
    var jobLocation, jobText, jobTitle: String
    var jobPhotos: [Data]
    var jobCompanyLogo: Data
    
    var dictionary: [String:Any] {
        return [
            "jobCompanyEmail": jobCompanyEmail,
            "jobCompanyLogo": jobCompanyLogo,
            "jobCompanyName": jobCompanyName,
            "jobLocation": jobLocation,
            "jobText": jobText,
            "jobTitle": jobTitle,
            "jobPhotos": jobPhotos
        ]
    }
}

extension JobPost: DocumentSerializable {
    init?(dictionary: [String:Any]) {
        guard let jobCompanyEmail = dictionary["jobCompanyEmail"] as? String,
                let jobCompanyLogo = dictionary["jobCompanyLogo"] as? Data,
                let jobCompanyName = dictionary["jobCompanyName"] as? String,
                let jobLocation = dictionary["jobLocation"] as? String,
                let jobText = dictionary["jobText"] as? String,
                let jobTitle = dictionary["jobTitle"] as? String,
                let jobPhotos = dictionary["jobPhotos"] as? [Data] else { return nil}
        
        self.init(jobCompanyEmail: jobCompanyEmail, jobCompanyName: jobCompanyName, jobLocation: jobLocation, jobText: jobText, jobTitle: jobTitle, jobPhotos: jobPhotos, jobCompanyLogo: jobCompanyLogo)
    }
}
