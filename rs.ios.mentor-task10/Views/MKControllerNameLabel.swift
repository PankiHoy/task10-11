//
//  ControllerNameLabel.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 25.08.21.
//

import UIKit

class MKControllerNameLabel: UILabel {
    
    init(withName name: String) {
        super.init(frame: .zero)
        self.setupControllerNameLabel(name: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControllerNameLabel(name: String) {
        self.textColor = .white
        self.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        self.text = name
    }
    
}
