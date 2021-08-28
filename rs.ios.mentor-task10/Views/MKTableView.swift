//
//  MKTableView.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 27.08.21.
//

import UIKit

class MKTableView: UITableView {
    
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height - 300
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = min(contentSize.height, maxHeight)
        
        return CGSize(width: contentSize.width, height: height)
    }
    
}
