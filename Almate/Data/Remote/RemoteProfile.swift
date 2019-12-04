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
}

protocol RemoteProfileInput {
    func loadUser(documentID: String, completion: @escaping(User?) -> Void)
}
