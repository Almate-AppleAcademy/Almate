//
//  RemoteJob.swift
//  Almate
//
//  Created by Qiarra on 30/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Photos
import Firebase

class RemoteJob: RemoteJobInput {
    
    func uploadJob(jobData: Job, completionBlock: @escaping (String, Bool) -> Void) {
        let collection = Firestore.firestore().collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Jobs")
        collection.addDocument(data: jobData.dictionary) { (error) in
            if let error = error {
                completionBlock(error.localizedDescription, false)
            } else {
                completionBlock("Success Post Job", true)
            }
        }
    }

    lazy var storage = Storage.storage()
    
    func uploadPhoto(jobData: JobPost, completionBlock: @escaping (String) -> Void) {
        let imagePath = "almate/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let storagefeRef = self.storage.reference(withPath: imagePath)
        storagefeRef.putData(jobData.jobCompanyLogo, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error uploading: \(error)")
                return
            } else {
                storagefeRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    } else {
                        completionBlock(url?.absoluteString ?? "")
                    }
                }
            }
        }
    }
    
    private var listener: ListenerRegistration?
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    func loadAllJob(completionBlock: @escaping ([Job], [QueryDocumentSnapshot]) -> Void) {
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
            
            completionBlock(models, snapshot.documents)
        })
    }
    
    func baseQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Jobs").limit(to: 50)
    }
    
}

protocol RemoteJobInput {
    func loadAllJob(completionBlock: @escaping([Job], [QueryDocumentSnapshot])-> Void) -> Void
    func uploadPhoto(jobData: JobPost, completionBlock: @escaping(String)-> Void) -> Void
    func uploadJob(jobData: Job, completionBlock: @escaping(String, Bool)-> Void) -> Void
}
