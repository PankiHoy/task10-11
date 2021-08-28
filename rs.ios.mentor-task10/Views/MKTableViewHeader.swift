//
//  MKTableViewHeader.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 26.08.21.
//

import UIKit

class MKTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "header"
    var labelHeight: CGFloat?
    
    var label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader() {
        label.text = "Players"
        label.font = UIFont(name: "Nunito-SemiBold", size: 16)
        label.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        label.sizeToFit()
        self.labelHeight = label.frame.height
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
    }

}
