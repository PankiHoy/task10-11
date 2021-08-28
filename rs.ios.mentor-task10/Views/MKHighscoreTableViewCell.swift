//
//  MKHighscoreTableViewCell.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 27.08.21.
//

import UIKit

class MKHighscoreTableViewCell: UITableViewCell {
    static var identifier = "highscoreCell"
    
    var delegate: UIViewController?
    
    func configureCell(withText text: String, place: Int, and score: Int) {
        self.backgroundColor = .rsBlack
        
        self.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        self.textLabel?.textColor = .white
        self.textLabel?.textAlignment = .left
        self.textLabel?.text = "#\(place)"
        
        self.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        self.textLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.textLabel?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.textLabel?.heightAnchor.constraint(equalToConstant: (self.delegate?.view.frame.height)!/14.75).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        nameLabel.textColor = .rsOrange
        nameLabel.textAlignment = .center
        nameLabel.text = "\(text)"
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: (self.delegate?.view.frame.height)!/14.75).isActive = true
        
        let scoreLabel = UILabel()
        scoreLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.text = "\(score)"
        
        self.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: (self.delegate?.view.frame.height)!/14.75).isActive = true
    }
}
