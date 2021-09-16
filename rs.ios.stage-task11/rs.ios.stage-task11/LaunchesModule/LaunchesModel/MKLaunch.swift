//
//  MKLaunches.swift
//  rs.ios.stage-task11
//
//  Created by dev on 11.09.21.
//

import Foundation
import UIKit

struct MKLaunch: Codable {
    var images: [UIImage]?
    
    struct Fairings: Codable {
        let reused: Bool
        let recoveryAttempt: Bool
        let recovered: Bool
        let ships: String
        
        enum CodingKeys: String, CodingKey {
            case reused
            case recoveryAttempt = "recovery_attempt"
            case recovered
            case ships
        }
    }
    struct Links: Codable {
        struct Patch: Codable {
            let small: URL?
            let large: URL?
        }
        struct Reddit: Codable {
            let campaign: URL?
            let launch: URL?
            let media: URL?
            let recovery: URL?
        }
        struct Flickr: Codable {
            let small: [URL]
            let original: [URL]
        }
        let patch: Patch
        let reddit: Reddit
        let flickrImages: Flickr
        let presskit: String?
        let webcast: URL?
        let youtubeId: String?
        let article: String?
        let wikipedia: URL?
        
        enum CodingKeys: String, CodingKey {
            case patch
            case reddit
            case flickrImages = "flickr"
            case presskit
            case webcast
            case youtubeId = "youtube_id"
            case article
            case wikipedia
        }
    }
    struct Cores: Codable {
        let core: String?
        let flight: Int?
        let gridfins: Bool?
        let legs: Bool?
        let reused: Bool?
        let landingAttempt: Bool?
        let landingSuccess: Bool?
        let landingType: String?
        let landPad: String?
        
        enum CodingKeys: String, CodingKey {
            case core
            case flight
            case gridfins
            case legs
            case reused
            case landingAttempt = "landing_attempt"
            case landingSuccess = "landing_success"
            case landingType = "landing_type"
            case landPad = "landpad"
        }
    }
    let links: Links
    let staticFireDateUtc: String?
    let staticFireDateUnix: Int?
    let tbd: Bool
    let net: Bool
    let window: Int?
    let rocket: String
    let success: Bool?
    let details: String?
    let ships: [String]
    let capsules: [String]
    let payloads: [String]
    let launchpad: String
    let autoUpdate: Bool
    let flightNumber: Int
    let name: String
    let dateUTC: String
    let dateUNIX: Int
    let dateLocal: String
    let upcoming: Bool
    let cores: [Cores]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case links
        case staticFireDateUtc = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tbd
        case net
        case window
        case rocket
        case success
        case details
        case ships
        case capsules
        case payloads
        case launchpad
        case autoUpdate = "auto_update"
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUNIX = "date_unix"
        case dateLocal = "date_local"
        case upcoming
        case cores
        case id
    }
}
