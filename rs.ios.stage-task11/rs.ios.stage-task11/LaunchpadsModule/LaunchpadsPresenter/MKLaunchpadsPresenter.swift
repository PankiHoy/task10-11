//
//  MKLaunchpadsPresenter.swift
//  rs.ios.stage-task11
//
//  Created by dev on 13.09.21.
//

import Foundation

protocol MKLaunchpadsViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MKLaunchpadsPresenterProtocol: AnyObject {
    init(view: MKLaunchpadsViewProtocol, networkService: MKNetworkServiceProtocol)
    func getLaunchpads()
    var launchpads: [MKLaunchpad]? { get set }
    var networkService: MKNetworkServiceProtocol! { get set }
}

class MKLaunchpadsPresenter: MKLaunchpadsPresenterProtocol {
    weak var view: MKLaunchpadsViewProtocol?
    var networkService: MKNetworkServiceProtocol!
    
    var launchpads: [MKLaunchpad]?
    
    required init(view: MKLaunchpadsViewProtocol, networkService: MKNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.getLaunchpads()
    }
    
    func getLaunchpads() {
        networkService.getLaunchpads { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let launchpads):
                    self.launchpads = launchpads
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
