//
//  RocketeerWidget.swift
//  RocketeerWidget
//
//  Created by Noah Wilder on 2020-08-04.
//

import WidgetKit
import SwiftUI

@main
struct RocketeerWidgets: WidgetBundle {
	@WidgetBundleBuilder
	var body: some Widget {
		FavouritesWidget()
		UpcomingWidget()
	}
}

struct UpcomingWidget: Widget {
	private let kind = "Upcoming_Launches"
	
	var body: some WidgetConfiguration{
		StaticConfiguration(kind: kind, provider: UpcomingMissionProvider()) { entry in
			WidgetEntryView(entry: entry)
		}
		.configurationDisplayName("Upcoming Launches")
		.description("Get quick access to information about upcoming launches.")
		.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
	}
}

struct FavouritesWidget: Widget {
	private let kind = "Favourite_Launches"
	
	var body: some WidgetConfiguration{
		StaticConfiguration(kind: kind, provider: FavouriteMissionProvider()) { entry in
			WidgetEntryView(entry: entry)
		}
		.configurationDisplayName("Favourite Launches")
		.description("Get quick access to information about your favourite launches.")
		.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
	}
}
