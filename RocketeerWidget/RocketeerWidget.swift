//
//  RocketeerWidget.swift
//  RocketeerWidget
//
//  Created by Noah Wilder on 2020-08-04.
//

import WidgetKit
import SwiftUI

struct MissionEntry: TimelineEntry {
    let date: Date
    let mission: [Mission]
}

struct Provider: TimelineProvider {
    @AppStorage("missionData", store: UserDefaults(suiteName: "group.jtepp.Spaceflight-Now"))
    var missionData: Data = Data()
    
    
    func snapshot(with context: Context, completion: @escaping (MissionEntry) -> ()) {
        guard let mission = try? JSONDecoder().decode([Mission].self, from: missionData) else {return}
        
        let entry = MissionEntry(date: Date(), mission: mission)
        completion(entry)
    }
    func timeline(with context: Context, completion: @escaping (Timeline<MissionEntry>) -> ()) {
        guard let missionData = try? JSONDecoder().decode([Mission].self, from: missionData) else {return}
        let entry = MissionEntry(date: Date(), mission: missionData)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
}

struct PlaceholderView: View {
    var body: some View{
        SmallMissionWidget(mission: [Mission(date: "Open the app", rocket: "Rocketeer", payload: "2020", launchTime: "", launchSite: "", description: "")])
    }
    
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            
            SmallMissionWidget(mission: entry.mission)
            
        case .systemMedium:
            MediumMissionWidget(mission: entry.mission)
        default:
            LargeMissionWidget(mission: entry.mission)
        }
        
    }
}
@main
struct RocketeerWidget: Widget {
    private let kind = "Upcoming_Launches"
    
    var body: some WidgetConfiguration{
        StaticConfiguration(
            kind: kind, provider: Provider(), placeholder: PlaceholderView()
        ) {entry in WidgetEntryView(entry:entry)}
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
