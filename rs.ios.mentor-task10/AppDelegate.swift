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
    
    var rootController = NewGameViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootController.view.backgroundColor = UIColor(named: "RSBlack")
        rootController.gameViewController = MKGameViewController()
        rootController.gameViewController?.newGameViewController = rootController

        let navigationController = UINavigationController(rootViewController: self.rootController)
        navigationController.navigationBar.isHidden = true
        
        if !UserDefaults.standard.firstTimeLaunchCheck {
            navigationController.pushViewController(rootController.gameViewController!, animated: true)
        }
        
        self.window = UIWindow()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let collectionView = rootController.gameViewController?.collectionView
        if let currentCenterCell = collectionView?.currentCenterCell {
            if let indexPathForCenterItem = collectionView?.indexPath(for: currentCenterCell) {
                UserDefaults.standard.currentCellIndexPathItem = indexPathForCenterItem.item
            }
        }
    }
}
