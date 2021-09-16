//
//  MKImageCollectionViewCell.swift
//  rs.ios.stage-task11
//
//  Created by dev on 15.09.21.
//

import UIKit

class MKImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    weak var delegate: UIViewController?
    
    var imageView: UIImageView!
    
    func configureCell() {
        configureImage()
    }
    
    func configureImage() {
        let shadowView = ShadowedView()
        shadowView.layer.cornerRadius = 10
        
        self.addSubview(shadowView)
        shadowView.frame = self.bounds
        
        imageView = UIImageView()
        imageView.image = UIImage.rsPlaceholder
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchUp(sender:))))
        imageView.isUserInteractionEnabled = true

        imageView.layer.cornerRadius = 7
        
        shadowView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 3),
            imageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 3),
            imageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -3),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -3)
        ])
    }
    
    @objc func touchDown(sender: UIButton) {
        
    }
    
    @objc func touchUp(sender: UIButton) {
        let viewC = MKImageViewController()
        viewC.imageView.image = self.imageView.image
        self.delegate?.navigationController?.pushViewController(viewC, animated: true)
    }
}
