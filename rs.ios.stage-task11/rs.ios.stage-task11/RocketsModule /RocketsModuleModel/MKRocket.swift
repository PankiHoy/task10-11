//
//  MKRocket.swift
//  rs.ios.stage-task11
//
//  Created by dev on 9.09.21.
//

import UIKit

struct MKRocket: Codable, Model {
    struct Height: Codable {
        let meters: Double
        let feet: Double
    }
    struct Diameter: Codable {
        let meters: Double
        let feet: Double
    }
    struct Mass: Codable {
        let kg: Int
        let lb: Int
    }
    struct FirstStage: Codable {
        struct ThrustSeaLevel: Codable {
            let kN: Int
            let lbf: Int
        }
        struct ThrustVacuum: Codable {
            let kN: Int
            let lbf: Int
        }
        let thrustSeaLevel: ThrustSeaLevel
        let thrustVacuum: ThrustVacuum
        let reusable: Bool
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
        
        enum CodingKeys: String, CodingKey {
            case thrustSeaLevel = "thrust_sea_level"
            case thrustVacuum = "thrust_vacuum"
            case reusable
            case engines
            case fuelAmountTons = "fuel_amount_tons"
            case burnTimeSec = "burn_time_sec"
        }
    }
    struct SecondStage: Codable {
        struct Thrust: Codable {
            let kN: Int
            let lbf: Int
        }
        struct Payloads: Codable {
            struct CompositeFairing: Codable {
                struct Height: Codable {
                    let meters: Double?
                    let feet: Double?
                }
                struct Diameter: Codable {
                    let meters: Double?
                    let feet: Double?
                }
                let height: Height
                let diameter: Diameter
            }
            let compositeFairing: CompositeFairing
            let option: String
            
            enum CodingKeys: String, CodingKey {
                case compositeFairing = "composite_fairing"
                case option = "option_1"
            }
        }
        let thrust: Thrust?
        let payloads: Payloads?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Int?
        
        enum CodingKeys: String, CodingKey {
            case thrust
            case payloads
            case reusable
            case engines
            case fuelAmountTons = "fuel_amount_tons"
            case burnTimeSec = "burn_time_sec"
        }
    }
    struct Engines: Codable {
        struct Isp: Codable {
            let seaLevel: Int
            let vacuum: Int
            
            enum CodingKeys: String, CodingKey {
                case seaLevel = "sea_level"
                case vacuum
            }
        }
        struct ThrustSeaLevel: Codable {
            let kN: Int
            let lbf: Int
        }
        struct ThrustVacuum: Codable {
            let kN: Int
            let lbf: Int
        }
        let isp: Isp?
        let thrustSeaLevel: ThrustSeaLevel?
        let thrustVacuum: ThrustVacuum?
        let number: Int?
        let type: String?
        let version: String?
        let layout: String?
        let engineLossMax: Int?
        let propellant1: String?
        let propellant2: String?
        let thrustToWeight: Double?
        
        enum CodingKeys: String, CodingKey {
            case isp
            case thrustSeaLevel = "thrust_sea_level"
            case thrustVacuum = "thrust_vacuum"
            case number
            case type
            case version
            case layout
            case engineLossMax = "engine_loss_max"
            case propellant1 = "propellant_1"
            case propellant2 = "propellant_2"
            case thrustToWeight = "thrust_to_weight"
        }
    }
    struct LandingLegs: Codable {
        let number: Int
        let material: String?
    }
    struct PayloadWeights: Codable {
        let id: String
        let name: String
        let kg: Int
        let lb: Int
    }
    struct FlikrImage: Codable {
        let url: URL
    }
    let height: Height
    let diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let engines: Engines
    let landingLegs: LandingLegs
    let payloadWeights: [PayloadWeights]
    let flickrImages: [URL]
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let success: Int
    let firstFlight: String
    let country: String
    let company: String
    let wikipedia: URL
    let description: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case height
        case diameter
        case mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name
        case type
        case active
        case stages
        case boosters
        case costPerLaunch = "cost_per_launch"
        case success = "success_rate_pct"
        case firstFlight = "first_flight"
        case country
        case company
        case wikipedia
        case description
        case id
    }
}
