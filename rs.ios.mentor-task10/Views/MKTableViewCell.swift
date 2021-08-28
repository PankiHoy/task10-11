//
//  MKTableViewCell.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 25.08.21.
//

import UIKit

class MKTableViewCell: UITableViewCell {
    private var myReorderImage : UIImage? = nil;
    
    override func didTransition(to state: UITableViewCell.StateMask) {
        super.didTransition(to: state)
        self.setupTableViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setEditing(true, animated: false)
    }
    
    func setupTableViewCell() {
        self.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        self.textLabel?.textColor = .white
        self.backgroundColor = .rsGray
    }
    
}

extension MKTableViewCell {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        for view in subviews where view.description.contains("Reorder") {
            for case let subview as UIImageView in view.subviews {
                subview.image = UIImage(named: "icon_Sort.png")
            }
        }
        
        for view in subviews where view.description.contains("Edit"){
            for case let subview as UIImageView in view.subviews {
                subview.image = UIImage(named: "icon_Delete")
            }
        }
        
        if self.editingStyle == .insert {
            for view in subviews where view.description.contains("Edit"){
                for case let subview as UIImageView in view.subviews {
                    subview.image = UIImage(named: "Add")
                }
            }
        }
    }
}
