//
//  MKButtonsCollectionViewCell.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 26.08.21.
//

import UIKit

class MKButtonsCollectionViewCell: UICollectionViewCell {
    var collectionView: MKCollectionView?
    var digit: Int?
    
    func configureCell() {
        self.backgroundColor = .rsGreen
        self.clipsToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(addScorePoints(sender:)))
        self.addGestureRecognizer(tapGestureRecogniser)
        self.isUserInteractionEnabled = true
        
        let label = UILabel()
        label.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        
        if digit! > 0 {
            label.text = "+\(digit!)"
        } else {
            label.text = "\(digit!)"
        }
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label.heightAnchor.constraint(equalToConstant: 30),
            label.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        let shadowLabel = UILabel()
        shadowLabel.text = "\(digit!)"
        shadowLabel.font = UIFont(name: "Nunito-ExtraBold", size: 25)
        shadowLabel.textAlignment = .center
        shadowLabel.textColor = .rsDarkGreen
        
        if digit! > 0 {
            shadowLabel.text = "+\(digit!)"
        } else {
            shadowLabel.text = "\(digit!)"
        }
            
        self.addSubview(shadowLabel)
        shadowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowLabel.topAnchor.constraint(equalTo: label.topAnchor),
            shadowLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            shadowLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            shadowLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: +5)
        ])
        
        self.bringSubviewToFront(label)
    }
    
    @objc func addScorePoints(sender: UITapGestureRecognizer) {
        let currentCell = collectionView?.currentCenterCell
        currentCell?.changeScore(with: digit!)
        self.collectionView?.scrollToNext()
        self.collectionView?.reloadData()
    }
}
