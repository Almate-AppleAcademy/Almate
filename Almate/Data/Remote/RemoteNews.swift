//
//  RemoteNews.swift
//  Almate
//
//  Created by Qiarra on 22/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import FirebaseFirestore

class RemoteNews: RemoteNewsInput {
    
    var newsData: [Post]?
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
      didSet {
        if let listener = listener {
          listener.remove()
        }
      }
    }
    
    func requestDataNews(completionBlock: @escaping ([Post], [QueryDocumentSnapshot]) -> Void) {
        query = baseQuery()
        guard let query = query else { return }
        listener = query.addSnapshotListener({ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> Post in
                if let model = Post(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(Post.self) with dictionary \(document.data())")
                }
            }
            completionBlock(models, snapshot.documents)
        })
    }
    
    func baseQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Post").limit(to: 50)
    }
}

protocol RemoteNewsInput {
    func requestDataNews(completionBlock: @escaping([Post], [QueryDocumentSnapshot]) -> Void) -> Void
}
