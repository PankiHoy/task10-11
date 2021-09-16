//
//  MKLaunchesCollectionViewCell.swift
//  rs.ios.stage-task11
//
//  Created by dev on 11.09.21.
//

import UIKit

class MKLaunchesCollectionViewCell: UICollectionViewCell {
    static let identifier = "LaunchesCell"
    
    var launch: MKLaunch?
    
    var imageURL: URL?
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var imageLabel: ShadowedView = {
        let label = ShadowedView()
        
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
    
    lazy var numberLabel: ShadowedView = {
        let view = ShadowedView()
        
        return view
    }()
    
    lazy var number: UILabel = {
        let label = UILabel()
        label.makeRSLabel(withColor: UIColor.rsCyan, andFont: UIFont.robotoBold(ofSize: 17))
        label.text = "#\(launch?.flightNumber ?? 0)"
        
        return label
    }()
    
    func configureCell() {
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.rsWhite
        configureCellShadow()
        
        configureNameLabel()
        configureImageLabel()
        configureDataLabel()
        configureCheckStatus()
        configureNumberLabel()
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
        nameLabel.font = UIFont.robotoBold(ofSize: 24)
        nameLabel.textColor = UIColor.rsBlack
        nameLabel.text = launch?.name
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150)
        ])
    }
    
    func configureImageLabel() {
        imageLabel.layer.cornerRadius = 20
        
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
        
        DispatchQueue.global().async { [weak self] in
            if let url = self?.imageURL {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let data = data {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                UIView.animate(withDuration: 0.25, animations: {
                                    self?.imageView.image = image
                                    self?.imageView.alpha = 0
                                    self?.imageView.alpha = 1
                                }, completion: nil)
                            }
                        }
                    }
                }.resume()
            }
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
    
    func configureDataLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let date = formatter.date(from: launch!.dateUTC)
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
    
    func configureCheckStatus() {
        if launch!.upcoming {
            checkStatus.image = UIImage.rsUpcoming
        } else {
            checkStatus.image = UIImage.rsCompleted
        }
        
        self.addSubview(checkStatus)
        checkStatus.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
            checkStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
    
    func configureNumberLabel() {
        numberLabel.layer.cornerRadius = 15
        numberLabel.backgroundColor = UIColor.rsWhite
        
        numberLabel.addSubview(number)
        number.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            number.topAnchor.constraint(equalTo: numberLabel.topAnchor, constant: 5),
            number.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor, constant: 10),
            number.bottomAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: -5),
            number.trailingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: -10),
        ])
        
        self.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 62),
            numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -17)
        ])
    }
}
