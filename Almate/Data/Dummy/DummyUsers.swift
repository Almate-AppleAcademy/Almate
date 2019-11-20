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
                data.append(Users(email: userEmail[n], idUser: userName[n], name: userName[n], generation: userGrad[n], occupation: userOccu[n], local: false, about: about[n], linkedIn: linkedInLink[n], noPhone: "08181816872", location: location[n], skills: skills[n], image: userImage[n]!))
            }
            completion(data)
        } else {
            for n in 0...11 {
                data.append(Users(email: userEmail[n], idUser: userName[n], name: "em-\(userName[n])", generation: userGrad[n], occupation: userOccu[n], local: false, about: about[n], linkedIn: linkedInLink[n], noPhone: "08181816872", location: location[n], skills: skills[n], image: userImage[n]!))
            }
            print(data)
            completion(data)
        }
    }
}

protocol DummyUsersInput {
    func getData(userType: UserType, completion: @escaping ([Users]) -> Void) -> Void
}
