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
    var commentData: [Comments]?
    var peopleComment: [User]?
    
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
    
    func loadPostComments(documents: QueryDocumentSnapshot, completionBlock: @escaping ([Comments], [User]) -> Void) {
        query = Firestore.firestore()
        
                .collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Post/\(documents.documentID)/Comments")
        guard let query = query else { return }
        var usersData: [User] = []
        listener = query.addSnapshotListener{ (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(String(describing: error))")
                return
            }
            let models = snapshot.documents.map { (document) -> Comments in
                if let model = Comments(dictionary: document.data()) {
                    return model
                } else {
                    fatalError("Unable to initialize type \(Comments.self) with dictionary \(document.data())")
                }
            }
            self.loadPeopleComments(models: models) { (dataUser) in
                if let dataUser = dataUser {
                    usersData.append(dataUser)
                    completionBlock(models, usersData ?? [User]())
                }
            }
        }
    }
    
    func loadPeopleComments(models: [Comments], completion: @escaping(User?) -> Void) {
        for model in models {
            let query = Firestore.firestore().collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/").document("\(model.commentBy.documentID)")
            query.getDocument { (snapshot, error) in
                let model = User(dictionary: (snapshot?.data())!)
                completion(model)
            }
        }
    }
    
    
//     func loadPeopleReferencing(models: [Reference], completion: @escaping(User?) -> Void) {
//
//            for model in models {
//                let query = Firestore.firestore().collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/")
//                    .document("\(model.referenceUser.documentID)")
//                    query.getDocument { (snapshot, error) in
//                        let model = User(dictionary: (snapshot?.data())!)
//    //                    usersData.insert(mod, at: <#T##Int#>)
//                        completion(model)
//                }
//            }
//        }
    
    
    func baseQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Post").limit(to: 50)
    }
}

protocol RemoteNewsInput {
    func requestDataNews(completionBlock: @escaping([Post], [QueryDocumentSnapshot]) -> Void) -> Void
    func loadPostComments (documents: QueryDocumentSnapshot, completionBlock: @escaping ([Comments], [User]) -> Void) -> Void
}
