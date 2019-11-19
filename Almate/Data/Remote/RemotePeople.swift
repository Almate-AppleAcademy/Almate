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
    
    func loadPeople(completionBlock: @escaping ([User]) -> Void) {
        query = baseQuery()
        guard let query = query else { return }
        listener = query.addSnapshotListener{ [unowned self] (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error)")
                return
            }
            print(snapshot.documents.count)
            let models = snapshot.documents.map { (document) -> User in
                if let model = User(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(User.self) with dictionary \(document.data())")
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
    func loadPeople(completionBlock: @escaping([User]) -> Void) -> Void
}
