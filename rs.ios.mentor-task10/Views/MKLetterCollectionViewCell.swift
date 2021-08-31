//
//  LetterCollectionViewCell.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 26.08.21.
//

import UIKit

class MKLetterCollectionViewCell: UICollectionViewCell {
    var collectionView: UICollectionView?
    
    private let letterLabel = UILabel()
    
    var assosiatedPlayer: MKPlayer?
    
    func configureCell(player: MKPlayer) {
        self.assosiatedPlayer = player
        
        letterLabel.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        letterLabel.text = String(player.name.first!)
        letterLabel.textAlignment = .center
        letterLabel.textColor = .rsGray
        
        self.addSubview(letterLabel)
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            letterLabel.topAnchor.constraint(equalTo: self.topAnchor),
            letterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            letterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            letterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func performMagic(check: Bool) {
        if check {
            self.letterLabel.textColor = .white
        } else {
            self.letterLabel.textColor = .rsGray
        }
    }
}
