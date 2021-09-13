//
//  MKLaunchpad.swift
//  rs.ios.stage-task11
//
//  Created by dev on 13.09.21.
//

import Foundation

struct MKLaunchpad: Codable {
    let name: String
    let fullName: String
    let locality: String
    let region: String
    let timeZone: String
    let latitude: Double
    let longtitude: Double
    let launchAttempts: Int
    let launchSuccesses: Int
    let rockets: [String]
    let launches: [String]
    let status: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case locality = "locality"
        case region
        case timeZone = "timezone"
        case latitude
        case longtitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rockets
        case launches
        case status
        case id
    }
}
