//
//  MKDismissButton.swift
//  rs.ios.stage-task11
//
//  Created by dev on 15.09.21.
//

import UIKit

class MKDismissButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setImage(UIImage.rsCloseButton, for: .normal)
        adjustsImageWhenHighlighted = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
