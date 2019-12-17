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
        
        let tabList = [
            createController(title: "Jobs", imageName: "news", vc: jobVC),
            createController(title: "News", imageName: "news", vc: newsVC),
            createController(title: "People", imageName: "news", vc: peopleVC),
            createController(title: "Notification", imageName: "news", vc: notifVC)
        ]
        
        viewControllers = tabList
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected\(viewController.title!)")
    }
    
    func createController(title: String, imageName: String, vc: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.navigationBar.backgroundColor = #colorLiteral(red: 0.127440244, green: 0.1577139199, blue: 0.1955760121, alpha: 1)
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
