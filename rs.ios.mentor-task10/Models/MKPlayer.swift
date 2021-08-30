//
//  MKPlayer.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 27.08.21.
//

import UIKit

class MKPlayer: NSObject, NSCoding {
    public var name: String
    public var score: String // КОСТЫЫЫЫЫЫЫЫЫЫЛЬ
    
    init(withName name: String, and score: String) {
        self.name = name
        self.score = score
    }
    
    required init(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.score = coder.decodeObject(forKey: "score") as? String ?? "0"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(score, forKey: "score")
    }
}
