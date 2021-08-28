//
//  MKTurnsTableViewCell.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 28.08.21.
//

import UIKit

class MKTurnsTableViewCell: UITableViewCell {
    static var identifier = "turnsCell"

    func configureCell(withScore scoreKeeper: MKScoreKeeper) {
        self.backgroundColor = .rsGray
        self.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        self.textLabel?.textColor = .white
        self.textLabel?.text = scoreKeeper.name
        
        let turnLabel = UILabel()
        turnLabel.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        turnLabel.textColor = .white
        turnLabel.text = scoreKeeper.score
        
        self.addSubview(turnLabel)
        turnLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            turnLabel.centerYAnchor.constraint(equalTo: self.textLabel!.centerYAnchor),
            turnLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            turnLabel.heightAnchor.constraint(equalTo: self.textLabel!.heightAnchor)
        ])
    }
}
