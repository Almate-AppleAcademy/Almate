//
//  CommentViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 12/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CommentViewController: UIViewController {
    
    var remoteNews = RemoteNews()
    @IBOutlet var commentView: CommentView!
    var commentDocument: QueryDocumentSnapshot?
    var dataComments: [Comments] = []
    
    @IBAction func postTapped(_ sender: UIButton) {
        print("POST TAPPED")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let commentDocument = commentDocument {
        remoteNews.loadPostComments(documents: commentDocument) { (dataComment, dataPeople) in
                // Kirim datacomment ke View
            print("HILIH : \(dataPeople)")
            self.dataComments = dataComment
            self.commentView.displayComments(dataComment, dataPeople)
            }
       }
//        self.navigationItem.setHidesBackButton(true, animated:false)

    }
    

}


