//
//  DummyLocal.swift
//  Almate
//
//  Created by Qiarra on 18/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation

class DummyUsers: DummyUsersInput {
    var data = [Users]()
    func getData(userType: UserType, completion: @escaping ([Users]) -> Void) {
        if userType == UserType.Alumni {
            print("Occu: \(userOccu.count), Email: \(userEmail.count), Username: \(userName.count), Grad: \(userGrad.count)")
            for n in 0...10 {
                data.append(Users(email: userEmail[n], idUser: userName[n], name: userName[n], generation: userGrad[n], occupation: userOccu[n], local: false, skills: ["Swift", "Java"], image: userImage[n]!))
            }
            completion(data)
        } else {
            for n in 0...11 {
                data.append(Users(email: "E-\(userEmail[n])", idUser: "E-\(userName[n])", name: "E-\(userName[n])", generation: userGrad[n], occupation: userOccu[n], local: false, skills: ["Swift", "Java"], image: userImage[n]!))
            }
            print(data)
            completion(data)
        }
    }
}

protocol DummyUsersInput {
    func getData(userType: UserType, completion: @escaping ([Users]) -> Void) -> Void
}
