//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://spaceflightnow.com/launch-schedule/")
    @State var missions: [Mission] = []
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                MissionRow(mission: mission)
            }
            .navigationTitle("Launches")
        }
        .onAppear {
            loadLaunchData()
        }
    }
    
    private func loadLaunchData() {
        var contents = ""
        do {
            try contents = String(contentsOf: url!)
        } catch {
            return
        }
        let matches = contents.matches(for: #"(?<=<div class="datename"><span class="launchdate">)(.|\n)+?<div class="missdescrip">(.|\n)+?</div>"#)
        for match in matches {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

