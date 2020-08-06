//
//  MissionProvider.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-05.
//

import WidgetKit

struct MissionProvider: TimelineProvider {
    func snapshot(with context: Context, completion: @escaping (MissionEntry) -> ()) {
        let placeholderMission = Mission(
            date: "Nov. 1",
            rocket: "Falcon 9",
            payload: "Starlink",
            launchTime: "10 a.m.",
            launchSite: "",
            description: ""
        )
        let missions = Array(repeating: placeholderMission, count: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        completion(entry)
    }
    
    func timeline(with context: Context, completion: @escaping (Timeline<MissionEntry>) -> ()) {
        var missions = [Mission]()
        loadLaunchData(to: &missions, limitedBy: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}
