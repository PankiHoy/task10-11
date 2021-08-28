//
//  RSBarButtonItem.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 25.08.21.
//

import UIKit

class RSBarButtonItem: UIButton {
    init(withText text: String) {
        super.init(frame: .zero)
        self.setupRSButton(text: text)
    }
    
    func isHighlighted(_ check: Bool) {
        if check {
            self.titleLabel?.textColor = UIColor(named: "RSDarkGreen")
        } else {
            self.titleLabel?.textColor = UIColor(named: "RSGreen")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRSButton(text: String) {
        self.tintColor = UIColor(named: "RSGreen")
        
        self.setAttributedTitle(NSAttributedString.init(string: text, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!
        ]), for: .normal)
        self.setAttributedTitle(NSAttributedString.init(string: text, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!
        ]), for: .highlighted)
        self.setAttributedTitle(NSAttributedString.init(string: text, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!
        ]), for: .disabled)
    }
}
