//
//  MKKaruselCollectionViewCell.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 26.08.21.
//

import UIKit

class MKKaruselCollectionViewCell: UICollectionViewCell {
    weak var delegate: MKGameViewController?
    
    var assotiatedPlayer: MKPlayer?
    
    var nameLabel = UILabel()
    var scoreLabel = UILabel()

    func configureCell(player: MKPlayer) {
        self.assotiatedPlayer = player
        
        self.backgroundColor = .rsGray
        self.layer.cornerRadius = 15
        
        nameLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        nameLabel.textColor = .rsOrange
        nameLabel.text = assotiatedPlayer?.name
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height/12.8),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/7.8)
        ])
        
        scoreLabel.font = UIFont(name: "Nunito-ExtraBold", size: 100)
        scoreLabel.textColor = .white
        scoreLabel.text = "\(self.assotiatedPlayer!.score)"
        
        self.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func changeScore(with digit: Int) {
        self.assotiatedPlayer?.score += digit
        self.delegate?.scoreStorage.append(MKScoreKeeper(name: assotiatedPlayer!.name, scoreChange: digit > 0 ? "+\(digit)" : "\(digit)"))
    }
}
