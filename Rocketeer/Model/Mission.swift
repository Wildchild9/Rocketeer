//
//  Mission.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct Mission: Identifiable, Codable {
    var id = UUID()
    var date: String
    var rocket: String
    var payload: String
    var launchTime: String
    var launchSite: String
    var description: String
    
    var logo: Image {
        let name = rocket.lowercased()
        
        switch name {
        case "ariane|vega".asRegex:
            return Image("arianespace-logo")
            
        case #"rocket \d+.\d+"#.asRegex:
            return Image("astra-logo")
            
        case "cz-|lm-|shenzou|long march".asRegex:
            return Image("cnsa-logo")
            
        case "slv".asRegex:
            return Image("isro-logo")
            
        case "antares|cygnus|pegasus|minotaur|peacekeeper".asRegex:
            return Image("orbital-logo")
            
        case "electron|photon".asRegex:
            return Image("rocketlab-logo")
            
        case "soyuz|angara".asRegex:
            return Image("roscosmos-logo")
            
        case "falcon".asRegex:
            return Image("spacex-logo")
            
        case "delta|atlas|vulcan|centaur".asRegex:
            return Image("ula-logo")
            
        case "launcherone".asRegex:
            return Image("virgin-logo")
            
        default:
            return Image("rocket-icon")
        }
    }
    var exactTime: String {
        if let time = launchTime.firstMatch(of: #"(\d+:)?(\d+:)?\d+ (a.m.|p.m.)"#) {
            return String(time)
        }
        return launchTime
    }
    
    static let placeholder = Mission(
        date: "Nov. 1",
        rocket: "Falcon 9",
        payload: "Starlink",
        launchTime: "10 a.m.",
        launchSite: "Cape Canaveral, Florida",
        description: "A SpaceX Falcon 9 rocket will be sending up the company's 14th Starlink satelite into a geostationary orbit around the Earth. This will be the newest addition to SpaceX's growing constellation of Starlink satellites."
    )
}
