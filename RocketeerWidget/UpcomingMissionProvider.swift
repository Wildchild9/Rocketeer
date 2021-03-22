//
//  UpcomingMissionProvider.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-05.
//

import WidgetKit

struct UpcomingMissionProvider: TimelineProvider {
    
    static let placeholderMission = Mission(
        date: "Nov. 1",
        rocket: "Falcon 9",
        payload: "Starlink",
        launchTime: "10 a.m.",
        launchSite: "",
        description: ""
    )
    
    func placeholder(in context: Context) -> MissionEntry {
        return MissionEntry(date: Date(), missions: [Mission.placeholder])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MissionEntry) -> ()) {
        let missions = Array(repeating: UpcomingMissionProvider.placeholderMission, count: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MissionEntry>) -> ()) {
        var missions = [Mission]()
        loadLaunchData(to: &missions, limitedBy: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        let date = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}
