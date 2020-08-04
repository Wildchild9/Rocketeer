//
//  loadLaunchData.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

func loadLaunchData(to missions: inout [Mission], limitedBy maxNumberOfMissions: Int? = nil) {
    let url = URL(string: "https://spaceflightnow.com/launch-schedule/")
    var contents = ""
    do {
        try contents = String(contentsOf: url!)
    } catch {
        return
    }
    
    missions = []
    
    var i = 0
    let regex = try! NSRegularExpression(pattern: #"(?<=<div class="datename"><span class="launchdate">)(.|\n)+?<div class="missdescrip">(.|\n)+?</div>"#)
    regex.enumerateMatches(in: contents, options: [], range: NSRange(contents.startIndex..<contents.endIndex, in: contents)) { (result, _, stop) in
        i += 1
        guard let nsRange = result?.range, let range = Range(nsRange, in: contents) else {
            return
        }
        let match = contents[range]
        let date = String(match.prefix { $0 != "<" }).removeHtmlSpecialCharacters()
        
        let name = String(match[match.range(of: #"(?<=class="mission">).+?(?=</span)"#, options: .regularExpression)!]).removeHtmlSpecialCharacters().components(separatedBy: " • ")
        
        let rocket = name[0]
        let payload = name[1]
        let launchTime = String(match[match.range(of:  #"(?<=Launch (window|time):</span> ).+?(?=<span)"#, options: .regularExpression)!]).removeHtmlSpecialCharacters().replacingOccurrences(of: #"(\d{2})(\d{2})"#, with: "$1:$2", options: .regularExpression)
        let launchSite = String(match[match.range(of:  #"(?<=Launch site:</span> ).+?(?=</div>)"#, options: .regularExpression)!]).removeHtmlSpecialCharacters()
        // Removing the updates
        let missionDescription = String(match[match.range(of:  #"(?<=<div class="missdescrip">).+?(?=(\[<span|</div>|</p>))"#, options: .regularExpression)!]).removeHtmlSpecialCharacters()
        
        
        let mission = Mission(date: date,
                              rocket: rocket,
                              payload: payload,
                              launchTime: launchTime,
                              launchSite: launchSite,
                              description: missionDescription)
        
        missions.append(mission)
        
        if let n = maxNumberOfMissions, i == n {
            stop.pointee = true
        }
    }
}
