//
//  MKRocketsCollectionViewCell.swift
//  rs.ios.stage-task11
//
//  Created by dev on 9.09.21.
//

import UIKit

class MKRocketsCollectionViewCell: UICollectionViewCell {
    static let identifier = "RocketCell"
    
    lazy var nameLabel: UILabel = {
        let textLabel = UILabel()
        
        return textLabel
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    func configureCell(withRocket rocket: MKRocket) {
        self.backgroundColor = .rsWhite
        self.layer.cornerRadius = 20
        configureCellShadow()
        
        configureImageView(rocket: rocket)
        configureSpecs(rocket: rocket)
        configureNameLabel(rocket: rocket)
    }
    
    func configureCellShadow() {
        self.layer.shadowColor = UIColor.rsBlack.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        
        let cgPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: self.layer.cornerRadius, height: self.layer.cornerRadius)).cgPath
        self.layer.shadowPath = cgPath
    }
    
    func configureNameLabel(rocket: MKRocket) {
        self.nameLabel.font = UIFont.robotoBold(ofSize: 24)
        self.nameLabel.textColor = .rsBlack
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        DispatchQueue.global().async { [weak self] in
            let name = rocket.name
            DispatchQueue.main.async {
                self?.nameLabel.text = name
            }
        }
    }
    
    func configureImageView(rocket: MKRocket) {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = self.layer.cornerRadius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        imageView.image = UIImage.rsPlaceholder
        
//        DispatchQueue.global().async {
//            URLSession.shared.dataTask(with: rocket.flickrImages.last!, completionHandler: { data, _, error in
//                if let image = UIImage(data: data!) {
//                    DispatchQueue.main.async { [weak self] in
//                        UIView.animate(withDuration: 0.25, animations: {
//                            self?.imageView.image = image
//                            self?.imageView.alpha = 0
//                            self?.imageView.alpha = 1
//                        })
//                    }
//                }
//            }).resume()
//        }
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120)
        ])
    }
    
    func configureSpecs(rocket: MKRocket) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.date(from: rocket.firstFlight)
        formatter.dateFormat = "MMMM dd, yyyy"
        
        //MARK: firstLaunchLabel
        let firstLauchLabel = UILabel()
        firstLauchLabel.text = "First launch"
        firstLauchLabel.font = UIFont.robotoBold(ofSize: 14)
        firstLauchLabel.textColor = UIColor.rsBlack
        
        self.addSubview(firstLauchLabel)
        firstLauchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstLauchLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -39),
            firstLauchLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        //MARK: firstLaunchDateLabel
        let firstLaunchDateLabel = UILabel()
        firstLaunchDateLabel.text = formatter.string(from: date!)
        firstLaunchDateLabel.font = UIFont.robotoBold(ofSize: 14)
        firstLaunchDateLabel.textColor = UIColor.rsGray
        
        self.addSubview(firstLaunchDateLabel)
        firstLaunchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstLaunchDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),
            firstLaunchDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        //MARK: successRateLabel
        let successRateLabel = UILabel()
        successRateLabel.text = "\(rocket.success)%"
        successRateLabel.font = UIFont.robotoBold(ofSize: 14)
        successRateLabel.textColor = UIColor.rsGray
        
        self.addSubview(successRateLabel)
        successRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successRateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),
            successRateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 264)
        ])
        
        //MARK: successLabel
        let successLabel = UILabel()
        successLabel.text = "Success"
        successLabel.font = UIFont.robotoBold(ofSize: 14)
        successLabel.textColor = UIColor.rsBlack
        
        self.addSubview(successLabel)
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -39),
            successLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 264)
        ])
        
        //MARK: launchCostDataLabel
        let laucnhCostDataLabel = UILabel()
        laucnhCostDataLabel.text = "\(rocket.costPerLaunch)$"
        laucnhCostDataLabel.font = UIFont.robotoBold(ofSize: 14)
        laucnhCostDataLabel.textColor = UIColor.rsGray
        
        self.addSubview(laucnhCostDataLabel)
        laucnhCostDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            laucnhCostDataLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),
            laucnhCostDataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 157)
        ])
        
        //MARK: laucnhCostLabel
        let launchCostLabel = UILabel()
        launchCostLabel.text = "Launch cost"
        launchCostLabel.font = UIFont.robotoBold(ofSize: 14)
        launchCostLabel.textColor = UIColor.rsBlack
        
        self.addSubview(launchCostLabel)
        launchCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            launchCostLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -39),
            launchCostLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 157)
        ])
    }
    
    func loadImage(rocket: MKRocket) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: rocket.flickrImages[0]) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.25, animations: {
                            self?.imageView.image = image
                            self?.imageView.alpha = 0
                            self?.imageView.alpha = 1
                        })
                    }
                }
            }
        }
    }
}
