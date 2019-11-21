//
//  EmployerViewController.swift
//  Almate
//
//  Created by Andi Ikhsan Eldrian on 20/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class EmployerViewController: UIViewController {

    @IBOutlet weak var employerPostJobdiController: UICollectionView!
//    @IBOutlet var savedPeoplediEmployerView: FavoriteCollectionViewCell!
    @IBOutlet weak var savedPeoplediEmployer: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employerPostJobdiController.delegate = self
        employerPostJobdiController.dataSource = self
       // savedPeoplediEmployerView.delegate = self
    //savedPeoplediEmployerView.dataSource = self
    
        savedPeoplediEmployer.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "savedPeopleCell")
        
        employerPostJobdiController.register(UINib(nibName: "EmployerPostJobCollectionCell", bundle: nil), forCellWithReuseIdentifier: "employerViewCell")
        // Do any additional setup after loading the view.
    }

    @IBAction func linkedinButtonPressed(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/in/slamet-riyadi-06a603155/")
        {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func employerTelpButtonPressed(_ sender: Any) {
        if let url = URL(string: "tel://+6281274330099"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func employerMailButtonPressed(_ sender: Any) {
        if let url = URL(string: "mailto:slametngeblog@gmail.com"){
        UIApplication.shared.open(url)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EmployerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "employerViewCell", for: indexPath as IndexPath) as! EmployerPostJobCollectionCell
        return cell
    }
    
}
