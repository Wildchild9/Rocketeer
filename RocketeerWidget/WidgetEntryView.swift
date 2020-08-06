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
            SmallMissionWidget(mission: entry.missions[0])
        default:
            EmptyView()
        }
    }
}
