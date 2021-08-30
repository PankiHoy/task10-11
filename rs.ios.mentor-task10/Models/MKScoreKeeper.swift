//
//  MKScoreKeeper.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 28.08.21.
//

import UIKit

class MKScoreKeeper: NSObject, NSCoding {
    var name: String
    var score: String
    
    init(name: String, scoreChange: String) {
        self.name = name
        self.score = scoreChange
    }
    
    required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.score = coder.decodeObject(forKey: "score") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(score, forKey: "score")
    }
}
