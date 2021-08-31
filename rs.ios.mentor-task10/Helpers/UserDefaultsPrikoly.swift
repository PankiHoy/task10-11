//
//  UserDefaultsPrikoly.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 31.08.21.
//

import Foundation
import UIKit

extension UserDefaults {
    var storage: Array<MKPlayer> {
        get {
            guard let data = UserDefaults.standard.data(forKey: "storage") else { return [MKPlayer(withName: "Kate", and: "0"),
                                                                                          MKPlayer(withName: "John", and: "0"),
                                                                                          MKPlayer(withName: "Bettie", and: "0"),
                                                                                          MKPlayer(withName: "prikol", and: "0")]}
            return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Array<MKPlayer> ?? []
        }
        set {
            UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "storage")
        }
    }
    
    var scoreStorage: Array<MKScoreKeeper> {
        get {
            guard let data = UserDefaults.standard.data(forKey: "scoreStorage") else { return [] }
            return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Array<MKScoreKeeper> ?? []
        }
        set {
            UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "scoreStorage")
        }
    }
    
    var currentCellIndexPathItem: Int {
        get {
            guard let data = UserDefaults.standard.data(forKey: "currentCellIndexPathItem") else { return 0 }
            return (try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Int ?? 0
        }
        set {
            UserDefaults.standard.set(try! NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "currentCellIndexPathItem")
        }
    }
    
    var timerPokasatel: Int {
        get {
            guard let data = UserDefaults.standard.data(forKey: "timer") else { return 0 }
            return (try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Int ?? 0
        }
        set {
            UserDefaults.standard.set(try! NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "timer")
        }
    }
    
    var firstTimeLaunchCheck: Bool {
        get {
            guard let data = UserDefaults.standard.data(forKey: "check") else { return true }
            return (try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(try! NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "check")
        }
    }
    
    var timerCounting: Bool {
        get {
            guard let data = UserDefaults.standard.data(forKey: "timerCounting") else { return false }
            return (try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)) as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(try! NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false), forKey: "timerCounting")
        }
    }
}
