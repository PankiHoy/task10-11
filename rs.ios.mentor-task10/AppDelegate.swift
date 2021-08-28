//
//  AppDelegate.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 25.08.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootController = NewGameViewController()
        rootController.view.backgroundColor = UIColor(named: "RSBlack")
        
        self.navigationController = UINavigationController(rootViewController: rootController)
        self.navigationController?.navigationBar.isHidden = true
        
        self.window = UIWindow()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

