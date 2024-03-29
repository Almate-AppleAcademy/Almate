//
//  CommentView.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 12/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit
import FirebaseFirestore


class CommentView: UIView {
    let db = Firestore.firestore()
    
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var commentPhoto: UIImageView!
    @IBOutlet weak var commentSenderView: UIView!
    @IBOutlet weak var postButton: UIButton!
    
    var dataComments: [Comments] = []
    var dataPeople: [User] = []
    var newsDocumentID: QueryDocumentSnapshot?
    var commentDelegate: CommentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentTextfield.delegate = self
        
        let nib = UINib(nibName: "CommentCell", bundle: nil)

        commentTable.register(nib, forCellReuseIdentifier: "commentCell")
        commentTable.delegate = self
        commentTable.dataSource = self
        commentTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        if commentTextfield.text!.isEmpty{
            postButton.setTitleColor(.darkGray, for: .normal)
            postButton.isUserInteractionEnabled = false
        }
        
        
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
        
        commentTable.keyboardDismissMode = .onDrag
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
//        postButton.isHidden = true
    }
    
    @IBAction func qwntlButton(_ sender: Any) {
        post()
    }
    

    @objc func keyboardWillShow(sender: NSNotification) {
        commentTextfield.frame.origin.y = 500
        commentPhoto.frame.origin.y = 495
        commentSenderView.frame.origin.y = 480
        postButton.frame.origin.y = 502
    
        commentTextfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.commentTextfield.frame.height))
        commentTextfield.rightViewMode = .always
        postButton.isHidden = false
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        commentTextfield.frame.origin.y = 739
        commentPhoto.frame.origin.y = 734
        commentSenderView.frame.origin.y = 719
        postButton.frame.origin.y = 741
        
        commentTextfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.commentTextfield.frame.height))
        commentTextfield.rightViewMode = .always
        postButton.isHidden = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as! NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            postButton.setTitleColor(.systemBlue, for: .normal)
            postButton.isUserInteractionEnabled = true
        } else {
            postButton.setTitleColor(.darkGray, for: .normal)
            postButton.isUserInteractionEnabled = false
        }
        return true
    }
    
    func post(){
        let userReference: DocumentReference = db.collection("/Alumni/Eb7ac4r1tAVwzsCoChc5/Institusi/9xq2RpLB9RtsSjyhczzG/Users/").document("jcbXnSufKt0bllBAJlf1")
        let time = Timestamp(date: Date())
        let data = Comments(commentText: commentTextfield.text!, commentBy: userReference, commentDate: time)
        self.commentDelegate?.didTapPost(documents: newsDocumentID, postCommentData: data)
        
    }
}

extension CommentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        let data = dataComments[indexPath.row]
//        print("HILIH : \(dataPeople)")
        let dataUser = dataPeople[indexPath.row]
        cell.commentOutlet.text = data.commentText
        cell.nameOutlet.text = "\(dataUser.firstName) \(dataUser.lastName)"
        cell.profilleImageOutlet.sd_setImage(with: URL(string: dataUser.userImage))
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

extension CommentView: CommentViewInput {
    func displayComments(_ data: [Comments]?, _ dataPeople: [User]?, _ newsDocumentID: QueryDocumentSnapshot?) {
        if let data = data, let dataPeople = dataPeople {
            self.dataComments = data
            self.dataPeople = dataPeople
            self.commentTable.reloadData()
            self.newsDocumentID = newsDocumentID
        } else {return}
    }
    
    
}

protocol CommentViewInput{
    func displayComments(_ data: [Comments]?,_ dataPeople: [User]?, _ newsDocumentID: QueryDocumentSnapshot?)
}

protocol CommentDelegate{
    func didTapPost(documents: QueryDocumentSnapshot?, postCommentData: Comments)
}

//extension UITextField {
//    func paddingRight(inset: CGFloat){
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
//        self.leftViewMode = UITextField.ViewMode.always
//    }
//}
