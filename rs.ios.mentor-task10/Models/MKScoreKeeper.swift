//
//  MKScoreKeeper.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 28.08.21.
//

import UIKit

class MKScoreKeeper: NSObject {
    var name: String
    var score: String
    
    init(name: String, scoreChange: String) {
        self.name = name
        self.score = scoreChange
    }
}
