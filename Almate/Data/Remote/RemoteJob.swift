//
//  RemoteJob.swift
//  Almate
//
//  Created by Qiarra on 30/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import FirebaseFirestore

class RemoteJob: RemoteJobInput {
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
      didSet {
        if let listener = listener {
          listener.remove()
        }
      }
    }
    
    func loadAllJob(completionBlock: @escaping ([Job]) -> Void) {
        query = baseQuery()
        guard let query = query else { return }
        listener = query.addSnapshotListener({ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            
            let models = snapshot.documents.map { (document) -> Job in
                if let model = Job(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(Job.self) with dictionary \(document.data()) : error \(error)")
                }
            }
            
            completionBlock(models)
        })
    }
    
    func baseQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Jobs").limit(to: 50)
    }
    
}

protocol RemoteJobInput {
    func loadAllJob(completionBlock: @escaping([Job])-> Void) -> Void
}
