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
	var org: String = "other"
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
            
        case "soyuz".asRegex:
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
        if let time = launchTime.firstMatch(of: #"(\d+:)?\d+ (a.m.|p.m.)"#) {
            return String(time)
        }
        return launchTime
    }
}

func orgNameFromRocket(rocket: String) -> String {
	switch rocket {
	case "ariane|vega".asRegex:
		return "Arianespace"
		
	case #"rocket \d+.\d+"#.asRegex:
		return "Astra"
		
	case "cz-|lm-|shenzou|long march".asRegex:
		return "CNSA"
		
	case "slv".asRegex:
		return "ISRO"
		
	case "antares|cygnus|pegasus|minotaur|peacekeeper".asRegex:
		return "Orbital"
		
	case "electron|photon".asRegex:
		return "Rocketlab"
		
	case "soyuz".asRegex:
		return "Soyuz"
		
	case "falcon".asRegex:
		return "SpaceX"
		
	case "delta|atlas|vulcan|centaur".asRegex:
		return "ULA"
		
	case "launcherone".asRegex:
		return "Virgin"
	default:
		return "Other"
	}
}

func orgPicFromName(name: String) -> String {
	switch name {
			case "Arianespace":
				return ("arianespace-logo")
				
			case "Astra":
				return ("astra-logo")
				
			case "CNSA":
				return ("cnsa-logo")
				
			case "ISRO":
				return ("isro-logo")
				
			case "Orbital":
				return ("orbital-logo")
				
			case "Rocketlab":
				return ("rocketlab-logo")
				
			case "Soyuz":
				return ("roscosmos-logo")
				
			case "SpaceX":
				return ("spacex-logo")
				
			case "ULA":
				return ("ula-logo")
				
			case "Virgin":
				return ("virgin-logo")
			
			case "all":
				return "all"
		
			default:
				return ("rocket-icon")
			}
}

func orgPicFromRocket(rocket: String) ->String{
	switch rocket {
	case "ariane|vega".asRegex:
		return "arianespace-logo"
		
	case #"rocket \d+.\d+"#.asRegex:
		return "astra-logo"
		
	case "cz-|lm-|shenzou|long march".asRegex:
		return "cnsa-logo"
		
	case "slv".asRegex:
		return "isro-logo"
		
	case "antares|cygnus|pegasus|minotaur|peacekeeper".asRegex:
		return "orbital-logo"
		
	case "electron|photon".asRegex:
		return "rocketlab-logo"
		
	case "soyuz".asRegex:
		return "roscosmos-logo"
		
	case "falcon".asRegex:
		return "spacex-logo"
		
	case "delta|atlas|vulcan|centaur".asRegex:
		return "ula-logo"
	
	case "launcherone".asRegex:
		return "virgin-logo"
		
	default:
		return "rocket-icon"
	}
}

func nameFromOrgPic(pic: String) -> String {
	switch pic {
			case "arianespace-logo":
				return "Arianespace"
				
			case "astra-logo":
				return "Astra"
				
			case "cnsa-logo":
				return "CNSA"
				
			case "isro-logo":
				return "ISRO"
				
			case "orbital-logo":
				return "Orbital"
				
			case "rocketlab-logo":
				return "Rocketlab"
				
			case "roscosmos-logo":
				return "Soyuz"
				
			case "spacex-logo":
				return "SpaceX"
				
			case "ula-logo":
				return "ULA"
				
			case "virgin-logo":
				return "Virgin"
			
			case "all":
				return "all"
				
			default:
				return "Other"
			}
}


var accents = [
	Color.white,
	Color.blue,
	Color.green,
	Color.orange,
	Color.red,
	Color.yellow,
	Color.purple,
	Color.init(.systemTeal),
	Color("pink"),
	Color("brown"),
	Color("forest")
]

