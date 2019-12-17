//
//  RemoteProfile.swift
//  Almate
//
//  Created by Qiarra on 04/12/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import FirebaseFirestore

class RemoteProfile: RemoteProfileInput {
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
      didSet {
        if let listener = listener {
          listener.remove()
        }
      }
    }
    
    func loadUser(documentID: String, completion: @escaping (User?) -> Void) {
        let query = Firestore.firestore().collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/").document("\(documentID)")
        query.getDocument { (snapshot, error) in
            
            let model = User(dictionary: (snapshot?.data())!)
            completion(model)
        }
    }
    
    func loadPeopleDetail(documentID: String, completionBlock: @escaping (UserContact) -> Void) {
        query = Firestore.firestore()
            .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documentID)/UserContact")
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
            if models.count > 0 {
                completionBlock(models[0])
            } else {
                print("Data Not Found")
            }
        }
    }

    func loadPeopleEducation(documentID: String, completionBlock: @escaping ([Education]) -> Void) {
        query = Firestore.firestore().collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documentID)/Education").limit(to: 50)
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> Education in
                if let model = Education(dictionary: document.data()) {
                    print(model)
                    return model
                } else {
                    fatalError("Unable to initialize type \(Education.self) with dictionary \(document.data())")
                }
            }
            print(models)
            completionBlock(models)
        }
    }
    
    func loadPeopleExperience(documentID: String, completionBlock: @escaping ([Experience]) -> Void) {
        query = Firestore.firestore() .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documentID)/Experience").limit(to: 50)
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> Experience in
                if let model = Experience(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(Experience.self) with dictionary \(document.data())")
                }
            }
            completionBlock(models)
        }
    }
    
    func loadPeopleReference(documentID: String, completionBlock: @escaping ([Reference], [User]) -> Void) {
        var usersData: [User] = []
        query = Firestore.firestore() .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/\(documentID)/Reference").limit(to: 50)
        guard let query = query else { return }
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            
            let models = snapshot.documents.map { (document) -> Reference in
                if let model = Reference(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(Reference.self) with dictionary \(document.data())")
                }
            }
            self.loadPeopleReferencing(models: models) { (dataUser) in
                usersData.append(dataUser!)
                completionBlock(models, usersData)
            }
        }
    }
    
    func loadPeopleReferencing(models: [Reference], completion: @escaping(User?) -> Void) {
        for model in models {
            let query = Firestore.firestore().collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/")
                    .document("\(model.referenceUser.documentID)")
                query.getDocument { (snapshot, error) in
                    let model = User(dictionary: (snapshot?.data())!)
                    completion(model)
            }
        }
    }
}

protocol RemoteProfileInput {
    func loadUser(documentID: String, completion: @escaping(User?) -> Void)
    func loadPeopleDetail(documentID: String, completionBlock: @escaping(UserContact) -> Void) -> Void
    func loadPeopleEducation(documentID: String, completionBlock: @escaping([Education]) -> Void) -> Void
    func loadPeopleExperience(documentID: String, completionBlock: @escaping([Experience]) -> Void) -> Void
    func loadPeopleReference(documentID: String, completionBlock: @escaping([Reference], [User]) -> Void) -> Void
}
