//
//  RSImage.swift
//  rs.ios.stage-task11
//
//  Created by dev on 8.09.21.
//

import Foundation
import UIKit

extension UIImage {
    static var rsRocket = UIImage(named: "rocket")
    static var rsHighlightedRocket = UIImage(named: "highlightedRocket")
    
    static var rsAdjustment = UIImage(named: "adjustment")
    static var rsHighlightedAdjustment = UIImage(named: "highlightedAdjustment")
    
    static var rsLego = UIImage(named: "lego")
    static var rsHighlightedLego = UIImage(named: "highlightedLego")
    
    static var rsArrows = UIImage(named: "button-sort")
    
    static var rsUpcoming = UIImage(named: "upcoming")
    static var rsCompleted = UIImage(named: "completed")
    
    static var rsPlaceholder = UIImage(named: "placeholder")
    
    static var rsActive = UIImage(named: "active")
    static var rsRetired = UIImage(named: "retired")
    
    static var rsBack = UIImage(named: "back")
    static var rsWikipedia = UIImage(named: "wikipedia")
    
    static var rsCloseButton = UIImage(named: "button-close")
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
