//
//  ModuleBuilder.swift
//  rs.ios.stage-task11
//
//  Created by dev on 8.09.21.
//

import Foundation
import UIKit

protocol Builder {
    static func createRocketsModule() -> UIViewController
    static func createLaunchesModule() -> UIViewController
    static func createLaunchpadsModule() -> UIViewController
}

class MKModuleBuilder: Builder {
    static func createRocketsModule() -> UIViewController {
        let view = MKRocketsViewController()
        let networkService = MKNetworkService()
        let presenter = MKRocketsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    static func createLaunchesModule() -> UIViewController {
        let view = MKLaunchesViewController()
        let networkService = MKNetworkService()
        let presenter = MKLaunchesPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    static func createLaunchpadsModule() -> UIViewController {
        let view = MKLaunchpadsViewController()
        let networkService = MKNetworkService()
        let presenter = MKLaunchpadsPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
}
