//
//  MainTabBarController.swift
//  Almate
//
//  Created by Qiarra on 31/10/19.
//  Copyright © 2019 Slamet Riyadi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let jobVC = JobsViewController()
    private let newsVC = NewsViewController()
    private let peopleVC = PeopleViewController()
    private let notifVC = NotifViewController()
    var tabBarCnt: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tabList = [
            createController(title: "Jobs", imageName: "news", vc: jobVC),
            createController(title: "News", imageName: "news", vc: newsVC),
            createController(title: "People", imageName: "news", vc: peopleVC),
            createController(title: "Notification", imageName: "news", vc: notifVC)
        ]
        
        viewControllers = tabList
//        viewControllers = tabList.map { UINavigationController(rootViewController: $0) }
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected\(viewController.title!)")
    }
    
    func createController(title: String, imageName: String, vc: UIViewController) -> UIViewController {
        let recentVC = UINavigationController(rootViewController: vc)
        recentVC.tabBarItem.title = title
        recentVC.tabBarItem.image = UIImage(named: imageName)
        return recentVC
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
