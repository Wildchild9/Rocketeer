//
//  RocketeerWidget.swift
//  RocketeerWidget
//
//  Created by Noah Wilder on 2020-08-04.
//

import WidgetKit
import SwiftUI

@main
struct RocketeerWidget: Widget {
    private let kind = "Upcoming_Launches"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MissionProvider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Upcoming Launches")
        .description("Get quick access to information about upcoming launches.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}


