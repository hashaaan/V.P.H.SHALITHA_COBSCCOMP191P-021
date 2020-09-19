//
//  MainTabBarController.swift
//  NIBM COVID19
//
//  Created by HASHAN on 9/4/20.
//  Copyright © 2020 NIBM-COBSCCOMP191P-021. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        configTabBar()
    }
    
    func configTabBar() {
        let homeController = UINavigationController(rootViewController: HomeViewController())
        homeController.tabBarItem.image = UIImage(systemName: "house")
        homeController.tabBarItem.title = "Home"
        
        let updateController = UINavigationController(rootViewController: UpdateViewController())
        updateController.tabBarItem.image = UIImage(systemName: "plus")
        updateController.tabBarItem.title = "Update"
        
        let settingsController = UINavigationController(rootViewController: SettingsViewController())
        settingsController.tabBarItem.image = UIImage(systemName: "gear")
        settingsController.tabBarItem.title = "Settings"
        
        viewControllers = [homeController, updateController, settingsController]
        
    }
    
}
