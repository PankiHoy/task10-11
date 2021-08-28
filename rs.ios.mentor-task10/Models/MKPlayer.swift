//
//  MKPlayer.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 27.08.21.
//

import UIKit

class MKPlayer: NSObject {
    public var name: String
    public var score: Int
    
    init(withName name: String, and score: Int) {
        self.name = name
        self.score = score
    }

}
