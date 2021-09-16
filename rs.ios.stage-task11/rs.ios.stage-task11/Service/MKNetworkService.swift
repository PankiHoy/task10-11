//
//  NetworkService.swift
//  rs.ios.stage-task11
//
//  Created by dev on 9.09.21.
//

import Foundation
import UIKit

protocol MKNetworkServiceProtocol: AnyObject {
    func getRockets(completion: @escaping (Result <[MKRocket]?, Error>) -> Void)
    func getLaunches(completion: @escaping (Result <[MKLaunch]?, Error>) -> Void)
    func getLaunchpads(completion: @escaping (Result <[MKLaunchpad]?, Error>) -> Void)
    func getImages(ofUnit unit: MKModel) -> [UIImage]?
}

class MKNetworkService: MKNetworkServiceProtocol {
    private var imageCache: NSCache<AnyObject, AnyObject>?
    
    func getRockets(completion: @escaping (Result<[MKRocket]?, Error>) -> Void) {
        let urlString = "https://api.spacexdata.com/v4/rockets"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let data = try JSONDecoder().decode([MKRocket].self, from: data!)
                
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getLaunches(completion: @escaping (Result<[MKLaunch]?, Error>) -> Void) {
        let urlString = "https://api.spacexdata.com/v5/launches"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let data = try JSONDecoder().decode([MKLaunch].self, from: data!)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getLaunchpads(completion: @escaping (Result<[MKLaunchpad]?, Error>) -> Void) {
        let urlString = "https://api.spacexdata.com/v4/launchpads"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let data = try JSONDecoder().decode([MKLaunchpad].self, from: data!)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getData<T:Codable>(ofType type: T, completion: @escaping (Result<[T]?, Error>) -> Void) {
        var urlString = "https://api.spacexdata.com"
        switch type {
        case is MKRocket:
            urlString = "https://api.spacexdata.com/v4/rockets"
            break
        case is MKLaunch:
            urlString = "https://api.spacexdata.com/v5/launches"
            break
        case is MKLaunchpad:
            urlString = "https://api.spacexdata.com/v4/launchpads"
            break
        default:
            break
        }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let data = try JSONDecoder().decode([T].self, from: data!)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func getImages(ofUnit unit: MKModel) -> [UIImage]? {
        let urlStrings = unit.flickrImages
        var images: [UIImage]?
        
        for url in urlStrings {
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
                if let error = error {
                    print(error)
                    return
                }
                let image = UIImage(data: data!)
                if let image = image {
                    images?.append(image)
                }
            }).resume()
        }
        
        return images
    }
}

