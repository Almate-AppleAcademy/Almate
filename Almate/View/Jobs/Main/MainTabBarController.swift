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
    private let notifVC = NotifTableViewController()
    var tabBarCnt: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var tabList: [UIViewController]?
        if checkUserType() == UserType.Alumni {
            tabList = [
                self.createController(title: "News", imageName: "Feeds replica", vc: newsVC),
                self.createController(title: "Jobs", imageName: "briefcase", vc: jobVC),
                self.createController(title: "People", imageName: "people", vc: peopleVC),
                self.createController(title: "Notification", imageName: "Icon notification-1", vc: notifVC)
            ]
        } else {
            tabList = [
                self.createController(title: "Jobs", imageName: "news", vc: jobVC),
                self.createController(title: "People", imageName: "news", vc: peopleVC),
                self.createController(title: "Notification", imageName: "news", vc: notifVC)
            ]
        }
        tabBar.tintColor = UIColor(red:0.31, green:0.80, blue:0.77, alpha:1.0)
        viewControllers = tabList
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected\(viewController.title!)")
    }
    
    func createController(title: String, imageName: String, vc: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: imageName)
        return nav
    }
}

func checkUserType() -> UserType {
    let userType = UserDefaults.standard.integer(forKey: "userType")
    //MARK: User Type 0 for Alumni; User Type 1 for Employer
    if userType == 0 {
        return UserType.Alumni
    } else {
        return UserType.Employer
    }
}

enum UserType {
    case Alumni
    case Employer
}
