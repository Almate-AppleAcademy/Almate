//
//  PeopleViewController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, PeopleViewDelegate {
    
    @IBOutlet var peopleView: PeopleView!
    
    @IBAction func pindah(_ sender: Any) {
        let vc = DetailPeopleViewController(nibName: "DetailPeopleViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        print("hah")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "People"
        peopleView.delegate = self
        
    }
    
    func didSelectItemAt() {
        let controller = DetailPeopleViewController(nibName: "DetailPeopleViewController", bundle: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
