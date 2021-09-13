//
//  AppDelegate.swift
//  rs.ios.stage-task11
//
//  Created by dev on 8.09.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .rsDarkBlue
        tabBarController.view.backgroundColor = .rsDarkBlue
        tabBarController.tabBar.isTranslucent = false
        
        let rocketsController = MKModuleBuilder.createRocketsModule()
        let launchesController = MKModuleBuilder.createLaunchesModule()
        let launchPadController = UIViewController()
        
        tabBarController.viewControllers = [rocketsController, launchesController, launchPadController]
        
        let navController = UINavigationController(rootViewController: tabBarController)
        navController.navigationBar.barTintColor = .rsDarkBlue
        navController.view.backgroundColor = .rsDarkBlue
        navController.navigationBar.isTranslucent = false

        window = UIWindow()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }

}

