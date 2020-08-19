//
//  WidgetEntryView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
    let entry: UpcomingMissionProvider.Entry
    
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
			if entry.missions.isEmpty {
				MediumMissionWidget.Placeholder()
			} else {
                MediumMissionWidget(missions: entry.missions)
			}
        case .systemLarge:
			if entry.missions.isEmpty {
                LargeMissionWidget.Placeholder()
            } else {
                LargeMissionWidget(missions: entry.missions)
            }
        @unknown default:
            SmallMissionWidget.Placeholder()
        }
    }
}
