//
//  UpcomingMissionProvider.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-05.
//

import WidgetKit
import Foundation

struct FavouriteMissionProvider: TimelineProvider {

    func getSnapshot(in context: Context, completion: @escaping (MissionEntry) -> ()) {
        let missions = Array(repeating: Mission.placeholder, count: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<MissionEntry>) -> ()) {
        var missions = [Mission]()
        loadLaunchData(to: &missions, limitedBy: 4)
        let defaults = UserDefaults.init(suiteName: "group.com.noahwilder.Rocketeer")!
        let favs = defaults.stringArray(forKey:"favouriteLaunches") ?? []
        missions = missions.filter{favs.contains($0.id)}
        let entry = MissionEntry(date: Date(), missions: missions)
        let date = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> MissionEntry {
        let missions = Array(repeating: Mission.placeholder, count: 4)
        let entry = MissionEntry(date: Date(), missions: missions)
        return entry
    }
}
