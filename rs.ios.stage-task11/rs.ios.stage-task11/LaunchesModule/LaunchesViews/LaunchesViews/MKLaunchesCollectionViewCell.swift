//
//  MKLaunchesCollectionViewCell.swift
//  rs.ios.stage-task11
//
//  Created by dev on 11.09.21.
//

import UIKit

class MKLaunchesCollectionViewCell: UICollectionViewCell {
    static let identifier = "LaunchesCell"
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var imageLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    lazy var dataLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var checkStatus: UIImageView = {
        let imageVIew = UIImageView()
        
        return imageVIew
    }()
    
    func configureCell(withLaunch launch: MKLaunch) {
        self.layer.cornerRadius = 15
        self.backgroundColor = .rsWhite
        
        configureNameLabel(launch: launch)
        configureImageLabel(launch: launch)
        configureDataLabel(launch: launch)
        configureCheckStatus(launch: launch)
    }
    
    func configureNameLabel(launch: MKLaunch) {
        nameLabel.font = UIFont.robotoBold(ofSize: 24)
        nameLabel.textColor = UIColor.rsBlack
        nameLabel.text = launch.name
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150)
        ])
    }
    
    func configureImageLabel(launch: MKLaunch) {
        imageLabel.layer.cornerRadius = 20
        imageLabel.layer.shadowRadius = 3
        imageLabel.layer.shadowOpacity = 1
        imageLabel.layer.shadowColor = UIColor.rsBlack.cgColor
        imageLabel.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        imageLabel.layer.shouldRasterize = true
        
        self.addSubview(imageLabel)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            imageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            imageLabel.heightAnchor.constraint(equalToConstant: 110),
            imageLabel.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.rsPlaceholder
        
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = launch.images?.first
        }
        
        imageLabel.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageLabel.topAnchor, constant: 15),
            imageView.leadingAnchor.constraint(equalTo: imageLabel.leadingAnchor, constant: 9.5),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 91)
        ])
    }
    
    func configureDataLabel(launch: MKLaunch) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let date = formatter.date(from: launch.dateUTC)
        formatter.dateFormat = "MMMM dd, yyyy"
        
        dataLabel.text = formatter.string(from: date!)
        dataLabel.font = UIFont.robotoBold(ofSize: 17)
        dataLabel.textColor = UIColor.rsBlack
        
        self.addSubview(dataLabel)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dataLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 53),
            dataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    func configureCheckStatus(launch: MKLaunch) {
        if launch.upcoming {
            checkStatus.image = UIImage.rsUpcoming
        } else {
            checkStatus.image = UIImage.rsCompleted
        }
        
        self.addSubview(checkStatus)
        checkStatus.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -17),
            checkStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
