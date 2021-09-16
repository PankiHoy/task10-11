//
//  MKLaunchpadsCollectionViewCell.swift
//  rs.ios.stage-task11
//
//  Created by dev on 13.09.21.
//

import Foundation
import UIKit

class MKLaunchpadsCollectionViewCell: UICollectionViewCell {
    static let identifier = "LaunchpadsCell"
    var launchpad: MKLaunchpad?
    
    func configureCell(withLaunchpad launchpad: MKLaunchpad) {
        self.launchpad = launchpad
        self.layer.cornerRadius = 15
        self.backgroundColor = .rsWhite
        configureCellShadow()
        
        configureNameLabel()
        configureCountryLabel()
        configureStatusLabel()
    }
    
    func configureCellShadow() {
        self.layer.shadowColor = UIColor.rsBlack.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        
        let cgPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.layer.cornerRadius, height: self.layer.cornerRadius)).cgPath
        self.layer.shadowPath = cgPath
    }
    
    func configureNameLabel() {
        let label = UILabel()
        label.font = UIFont.robotoBold(ofSize: 24)
        label.text = launchpad?.name
        label.textColor = UIColor.rsBlack
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    func configureCountryLabel() {
        let label = UILabel()
        label.font = UIFont.robotoRegular(ofSize: 17)
        label.text = launchpad?.region
        label.textColor = UIColor.rsBlack
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 53),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    func configureStatusLabel() {
        let imageView = UIImageView()
        switch launchpad?.status {
        case "Active":
            imageView.image = UIImage.rsActive
        default:
            imageView.image = UIImage.rsRetired
        }
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23)
        ])
    }
}
