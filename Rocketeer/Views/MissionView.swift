//
//  MissionView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionView: View {
    var mission: Mission
    
    var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(alignment: .leading, spacing: 15) {
				Field(title: "Date", contents: mission.date)
				Field(title: "Launch Time", contents: mission.launchTime)
				Field(title: "Launch Site", contents: mission.launchSite)
				Field(title: "Payload", contents: mission.payload)
				Field(title: "Description", contents: mission.description)
				
				Spacer()
			}
		}
        .padding(20)
        .navigationTitle(mission.rocket)
		.navigationBarItems(trailing:
			Button(action: {print("star")}, label: {
				Image(systemName: "star.fill")
			})
			)
    }
}
