//
//  MainTabBar.swift
//  Almate
//
//  Created by Qiarra on 01/11/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    private let newsVc = NewsViewController()
    private let peopleVc = PeopleViewController()
    private let jobsVc = JobsViewController()
    private let notifVC = NotifTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
                createController(title: "News", imageName: "chat", vc: newsVc),createController(title: "People", imageName: "chat", vc: peopleVc), createController(title: "Jobs", imageName: "chat", vc: jobsVc), createController(title: "Notification", imageName: "chat", vc: notifVC)]
        
    }
        
        private func createController(title: String, imageName: String, vc: UIViewController) -> UINavigationController{
            let recentVC = UINavigationController(rootViewController: vc)
            recentVC.tabBarItem.title = title
            recentVC.tabBarItem.image = UIImage(named: imageName)
            return recentVC
        }
}

