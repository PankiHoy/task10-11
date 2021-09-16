//
//  File.swift
//  rs.ios.stage-task11
//
//  Created by dev on 9.09.21.
//

import Foundation
import UIKit

protocol MKRocketsViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MKRocketsPresenterProtocol: AnyObject {
    init(view: MKRocketsViewProtocol, networkService: MKNetworkServiceProtocol)
    func getRockets()
    var rockets: [MKRocket]? { get set }
    var networkService: MKNetworkServiceProtocol! { get set }
}

class MKRocketsPresenter: MKRocketsPresenterProtocol {
    weak var view: MKRocketsViewProtocol?
    var networkService: MKNetworkServiceProtocol!
    
    var rockets: [MKRocket]?
    
    required init(view: MKRocketsViewProtocol, networkService: MKNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.getRockets()
    }
    
    func getRockets() {
        networkService.getRockets { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let rockets):
                    self.rockets = rockets
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}

