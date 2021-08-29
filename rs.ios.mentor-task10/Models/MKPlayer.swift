//
//  MKPlayer.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 27.08.21.
//

import UIKit

class MKPlayer: NSObject, NSCoding {
    public var name: String
    public var score: Int
    
    init(withName name: String, and score: Int) {
        self.name = name
        self.score = score
    }
    
    required init(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.score = coder.decodeObject(forKey: "score") as? Int ?? 0
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(score, forKey: "score")
    }
}

extension UserDefaults {
    var storage: Array<MKPlayer> {
        get {
            guard let data = UserDefaults.standard.data(forKey: "storage") else { return [] }
            return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Array<MKPlayer> ?? []
        }
        set {
            UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "storage")
        }
    }
}
