//
//  CommentView.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 12/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class CommentView: UIView {

    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var commentPhoto: UIImageView!
    @IBOutlet weak var commentSenderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentTextfield.delegate = self
        
        let nib = UINib(nibName: "CommentCell", bundle: nil)

        commentTable.register(nib, forCellReuseIdentifier: "commentCell")
        commentTable.delegate = self
        commentTable.dataSource = self
        commentTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
        commentTable.keyboardDismissMode = .onDrag
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }

    @objc func keyboardWillShow(sender: NSNotification) {
            commentTextfield.frame.origin.y = 500
            commentPhoto.frame.origin.y = 495
            commentSenderView.frame.origin.y = 480
    }

    @objc func keyboardWillHide(sender: NSNotification) {
            commentTextfield.frame.origin.y = 739
            commentPhoto.frame.origin.y = 734
            commentSenderView.frame.origin.y = 719
    }
    
}

extension CommentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        
        return cell
    }
    
}

extension CommentView: UITableViewDelegate {
    
}

extension CommentView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // don't force `endEditing` if you want to be asked for resigning
        // also return real flow value, not strict, like: true / false
        return textField.endEditing(false)
    }
}
