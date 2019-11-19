//
//  Alumni.swift
//  Almate
//
//  Created by Qiarra on 19/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation

// MARK: - Alumni
struct Alumni {
    let alumni: AlumniClass
}

// MARK: - AlumniClass
struct AlumniClass {
    let institusi: [Institusi]
}

// MARK: - Institusi
struct Institusi {
    let name, address: String
    let admin: [Admin]
    let users: [User]
    let news: [News]?
    let notif: [Notif]
    let post: [Post]?
}

// MARK: - Admin
struct Admin {
    let email, password: String
}

// MARK: - News
struct News {
    let newsText: String
    let newsLike: Int
    let newsDate: String
    let newsPhoto: [String]
    let comment: [NewsComment]
}

// MARK: - NewsComment
struct NewsComment {
    let usersID: String
    let commentText: String?
    let commentTime: String
    let text: String?

    enum CodingKeys: String, CodingKey {
        case usersID = "usersId"
        case commentText, commentTime, text
    }
}

// MARK: - Notif
struct Notif {
    let text, postID, date: String
}

// MARK: - Post
struct Post {
    let text: String
    let like: Int
    let date: String
    let comment: [PostComment]
}

// MARK: - PostComment
struct PostComment {
    let usersID, text: String

    enum CodingKeys: String, CodingKey {
        case usersID = "usersId"
        case text
    }
}

// MARK: - User
struct User  {
    var firstName, lastName, middleName, userStatus: String
    var userOccupation, userAbout, userGeneration: String
    var userImage: String
//    let userContact: UserContact
//    var education: [Education]
//    var experience: [Experience]
    var work: [String]
    var tagSkill: [String]
    
    var dictionary: [String:Any] {
        return [
            "firstName": firstName,
            "middleName": middleName,
            "lastName": lastName,
            "userStatus": userStatus,
            "userOccupation": userOccupation,
            "userAbout": userAbout,
            "userGeneration": userGeneration,
            "userImage": userImage,
            "userWork": work,
            "userSkill": tagSkill
        ]
    }
}

extension User: DocumentSerializable {
    init?(dictionary: [String:Any]) {
        guard let firstName = dictionary["firstName"] as? String,
                let middleName = dictionary["middleName"] as? String,
                let lastName = dictionary["lastName"] as? String,
                let userStatus = dictionary["userStatus"] as? String,
                let userOccupation = dictionary["userOccupation"] as? String,
                let userAbout = dictionary["userAbout"] as? String,
                let userGeneration = dictionary["userGeneration"] as? String,
                let userImage = dictionary["userImage"] as? String,
//                let userContact = dictionary["userContact"] as? UserContact,
                let work = dictionary["userWork"] as? [String],
                let tagSkill = dictionary["userSkill"] as? [String] else { return nil}
        
        self.init(firstName: firstName, lastName: lastName, middleName: middleName,
                  userStatus: userStatus, userOccupation: userOccupation, userAbout: userAbout,
                  userGeneration: userGeneration, userImage: userImage, work: work, tagSkill: tagSkill)
    }
}

// MARK: - UserContact
struct UserContact: Codable {
    let userPhone, userEmail, userLinkedIn: String
}

extension UserContact: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let userPhone = dictionary["userPhone"] as? String,
                let userEmail = dictionary["userEmail"] as? String,
                let userLinkedIn = dictionary["userLinkedIn"] as? String else {return nil}
        
        self.init(userPhone: userPhone, userEmail: userEmail, userLinkedIn: userLinkedIn)
    }
}

// MARK: - Education
struct Education {
    let educationName: String
    let educationYearEnd, educationYearStart, yearEducationStart, yearEducationEnd: String?
}

// MARK: - Experience
struct Experience {
    let companyName, dateStart, dateEnd, educationName: String?
    let yearEducationStart, yearEducationEnd: String?
}
