//
//  RSMaterialsLabel.swift
//  rs.ios.stage-task11
//
//  Created by dev on 16.09.21.
//

import Foundation
import UIKit

extension ShadowedView {
    func makeRSMaterialsLabel(withTitle title: String) {
        configureForm()
        
        let nameLabel = UILabel()
        let imageLabel = UIImageView()
        
        nameLabel.makeRSLabel(withColor: UIColor.rsCoral, andFont: UIFont.robotoBold(ofSize: 17))
        nameLabel.text = title
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        
        imageLabel.image = UIImage(named: "link")
        self.addSubview(imageLabel)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.5),
            imageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12.5)
        ])
    }
    
    func configureForm() {
        self.backgroundColor = UIColor.rsWhite
        self.layer.cornerRadius = 16
    }
}
