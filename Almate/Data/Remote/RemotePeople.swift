//
//  RemoteUser.swift
//  Almate
//
//  Created by Qiarra on 19/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import FirebaseFirestore

class RemotePeople: RemotePeopleInput {
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
      didSet {
        if let listener = listener {
          listener.remove()
        }
      }
    }
    
    var userContact: [UserContact]?
    var userEducation: [Education]?
    var userExperience: Experience?
    
    func loadPeople(completionBlock: @escaping ([User], [QueryDocumentSnapshot]) -> Void) {
       query = baseQuery()
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> User in
                if let model = User(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(User.self) with dictionary \(document.data())")
                }
            }
            completionBlock(models, snapshot.documents)
        }
    }
    
    func loadPeopleDetail(documents: QueryDocumentSnapshot, completionBlock: @escaping (UserContact) -> Void) {
        query = Firestore.firestore()
            .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documents.documentID)/UserContact")
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> UserContact in
                if let model = UserContact(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(UserContact.self) with dictionary \(document.data())")
                }
            }
            completionBlock(models[0])
        }
    }

    func loadPeopleEducation(documents: QueryDocumentSnapshot, completionBlock: @escaping ([Education]) -> Void) {
        query = Firestore.firestore()
            .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documents.documentID)/Education")
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> Education in
                if let model = Education(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(Education.self) with dictionary \(document.data())")
                }
            }
            completionBlock(models)
        }
    }
    
    func loadPeopleExperience(documents: QueryDocumentSnapshot, completionBlock: @escaping ([Experience]) -> Void) {
        query = Firestore.firestore()
            .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documents.documentID)/Experience")
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> Experience in
                if let model = Experience(dictionary: document.data()) {
                    print(model)
                    return model
                } else {
                    fatalError("Unable to initialize type \(Experience.self) with dictionary \(document.data())")
                }
            }
            completionBlock(models)
        }
    }
    
    
    func baseQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users").limit(to: 50)
    }
}

protocol RemotePeopleInput {
    func loadPeople(completionBlock: @escaping([User], [QueryDocumentSnapshot]) -> Void) -> Void
    func loadPeopleDetail(documents: QueryDocumentSnapshot, completionBlock: @escaping(UserContact) -> Void) -> Void
    func loadPeopleEducation(documents: QueryDocumentSnapshot, completionBlock: @escaping([Education]) -> Void) -> Void
    func loadPeopleExperience(documents: QueryDocumentSnapshot, completionBlock: @escaping([Experience]) -> Void) -> Void
}
