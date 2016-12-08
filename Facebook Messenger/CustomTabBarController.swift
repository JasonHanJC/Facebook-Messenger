//
//  CustomTabBarController.swift
//  Facebook Messenger
//
//  Created by Juncheng Han on 12/8/16.
//  Copyright © 2016 Juncheng Han. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        let friendListController = FriendListController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendListController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
        let viewController_1 = UIViewController()
        let navController_1 = UINavigationController(rootViewController: viewController_1)
        navController_1.tabBarItem.title = "Calls"
        navController_1.tabBarItem.image = UIImage(named: "calls")
        
        let viewController_2 = UIViewController()
        let navController_2 = UINavigationController(rootViewController: viewController_2)
        navController_2.tabBarItem.title = "Groups"
        navController_2.tabBarItem.image = UIImage(named: "groups")
        
        let viewController_3 = UIViewController()
        let navController_3 = UINavigationController(rootViewController: viewController_3)
        navController_3.tabBarItem.title = "People"
        navController_3.tabBarItem.image = UIImage(named: "people")
        
        let viewController_4 = UIViewController()
        let navController_4 = UINavigationController(rootViewController: viewController_4)
        navController_4.tabBarItem.title = "Settings"
        navController_4.tabBarItem.image = UIImage(named: "settings")
        
        viewControllers = [recentMessagesNavController, navController_1, navController_2, navController_3, navController_4]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
