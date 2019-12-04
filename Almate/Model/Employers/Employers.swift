////
////  Employers.swift
////  Almate
////
////  Created by Qiarra on 19/11/19.
////  Copyright © 2019 Slamet Riyadi. All rights reserved.
////
//
//import Foundation
//
//// MARK: - Employers
//struct Employers: Codable {
//    let employers: [Employer]
//}
//
//// MARK: - Employer
//struct Employer: Codable {
//    let companyID: String
//    let companyContacts: CompanyContacts?
//    let password, nameCompany, logo, about: String
//    let jobs: [Job]
//    let emailCompany, linkedin, telepon, locationCompany: String?
//
//    enum CodingKeys: String, CodingKey {
//        case companyID = "companyId"
//        case companyContacts, password, nameCompany, logo, about, jobs, emailCompany, linkedin, telepon, locationCompany
//    }
//}
//
//// MARK: - CompanyContacts
//struct CompanyContacts: Codable {
//    let phone, email, companySite, linkedin: String
//    let locationCompany: String
//}
//
//// MARK: - Job
////struct Job: Codable {
////    let companyID: String
////    let status: Bool
////    let title, period: String
////    let salaryStart, salaryEnd, availableCurrentPosition: Int
////    let applicants: [String]
////    let photos: [String]
////    let jobDescription: [String]
////    let requirement: [String]
////
////    enum CodingKeys: String, CodingKey {
////        case companyID = "companyId"
////        case status, title, period, salaryStart, salaryEnd, availableCurrentPosition, applicants, photos
////        case jobDescription = "description"
////        case requirement
////    }
////}
