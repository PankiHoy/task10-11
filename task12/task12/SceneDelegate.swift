//
//  SceneDelegate.swift
//  task12
//
//  Created by dev on 23.09.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController(rootViewController: ViewController())
        
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

