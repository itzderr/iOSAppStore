//
//  MainTabBarController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-25.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewControllers = [
      createViewController(viewController: UIViewController(), title: "Today", imageName: "today"),
      createViewController(viewController: UIViewController(), title: "Games", imageName: "games"),
      createViewController(viewController: UIViewController(), title: "Apps", imageName: "apps"),
      createViewController(viewController: SearchViewController(), title: "Search", imageName: "search"),
    ]
  }
  
  fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
    
    viewController.view.backgroundColor = .white
    viewController.navigationItem.title = title
    let navController = UINavigationController(rootViewController: viewController)
    navController.navigationBar.prefersLargeTitles = true
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(named: imageName)
    return navController
  }
}
