//
//  Presenter.swift
//  rs.ios.stage-task11
//
//  Created by dev on 13.09.21.
//

import Foundation

protocol ViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol PresenterProtocol: AnyObject {
    init<T:Codable>(view: ViewProtocol, networkService: MKNetworkServiceProtocol, type: T)
    func getData<T:Codable>(type: T)
    var data: [Model] { get set }
}

class Presenter: PresenterProtocol {
    weak var view: ViewProtocol?
    var networkService: MKNetworkServiceProtocol!
    
    var data: [Model]
    
    required init<T:Codable>(view: ViewProtocol, networkService: MKNetworkServiceProtocol, type: T) {
        self.view = view
        self.networkService = networkService
        self.getData(type: type)
    }
    
    func getData<T:Codable>(type: T) {
        networkService.getData(ofType: type, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.data = data as! [Model]
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
}
