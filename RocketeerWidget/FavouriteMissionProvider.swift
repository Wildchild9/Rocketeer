//
//  UpcomingMissionProvider.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-05.
//

import WidgetKit
import Foundation

struct FavouriteMissionProvider: TimelineProvider {
    static let placeholderMission = Mission(
        date: "Nov. 1",
        rocket: "Falcon 9",
        payload: "Starlink",
        launchTime: "10 a.m.",
        launchSite: "",
        description: ""
    )
    
    func snapshot(with context: Context, completion: @escaping (MissionEntry) -> ()) {
        let missions = Array(repeating: UpcomingMissionProvider.placeholderMission, count: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<MissionEntry>) -> ()) {
        var missions = [Mission]()
		missions = UserDefaults.standard.stringArray(forKey: "favouriteLaunches") ?? []
        let entry = MissionEntry(date: Date(), missions: missions)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
