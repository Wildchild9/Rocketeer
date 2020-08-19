//
//  WidgetEntryView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
    let entry: MissionProvider.Entry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            if entry.missions.isEmpty {
                SmallMissionWidget.Placeholder()
            } else {
                SmallMissionWidget(mission: entry.missions[0])
            }
        case .systemMedium:
            if entry.missions.count < 2 {
                MediumMissionWidget.Placeholder()
            } else {
                MediumMissionWidget(missions: entry.missions)
            }
        case .systemLarge:
            if entry.missions.count < 4 {
                LargeMissionWidget.Placeholder()
            } else {
                LargeMissionWidget(missions: entry.missions)
            }
        @unknown default:
            SmallMissionWidget.Placeholder()
        }
    }
}
