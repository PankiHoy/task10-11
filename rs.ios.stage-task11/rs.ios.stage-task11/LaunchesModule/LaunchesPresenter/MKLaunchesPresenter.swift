//
//  MKLaunchesPresenter.swift
//  rs.ios.stage-task11
//
//  Created by dev on 11.09.21.
//

import Foundation
import UIKit

protocol MKLaunchesViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MKLaunchesPresenterProtocol: AnyObject {
    init(view: MKLaunchesViewProtocol, networkService: MKNetworkServiceProtocol)
    func getLaunches()
    var launches: [MKLaunch]? { get set }
    var networkService: MKNetworkServiceProtocol! { get set }
}

class MKLaunchesPresenter: MKLaunchesPresenterProtocol {
    weak var view: MKLaunchesViewProtocol?
    var networkService: MKNetworkServiceProtocol!
    
    var launches: [MKLaunch]?
    
    required init(view: MKLaunchesViewProtocol, networkService: MKNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.getLaunches()
    }
    
    func getLaunches() {
        networkService.getLaunches { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let launches):
                    self.launches = launches
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
