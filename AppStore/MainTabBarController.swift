//
//  MainTabBarController.swift
//  AppStore
//
//  Created by Derrick Park on 2019-04-25.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  // MARK: - Life cycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let todayCollectionViewController = TodayCollectionViewController()
    todayCollectionViewController.view.backgroundColor = .white
    todayCollectionViewController.tabBarItem.title = "Today"
    todayCollectionViewController.tabBarItem.image = UIImage(named: "today")
    
    viewControllers = [
      todayCollectionViewController,
      createViewController(viewController: AppsCollectionViewController(), title: "Apps", imageName: "apps"),
      createViewController(viewController: UIViewController(), title: "Games", imageName: "games"),
      createViewController(viewController: SearchTableViewController(), title: "Search", imageName: "search"),
    ]
  }
  
  /// Helper method to create a ViewController for each tab
  ///
  /// - Parameters:
  ///   - viewController: containter view controller.s
  ///   - title: nagivation title.
  ///   - imageName: tab icon image name.
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
