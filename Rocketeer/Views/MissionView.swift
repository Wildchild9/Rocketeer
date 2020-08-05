//
//  MissionView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionView: View {
    var mission: Mission
	@State var favourited = false //Cannot be part of the Mission object, unless the object is @State. Will be a variable used to compare the Mission's info to the list of saved Missions' info
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
								Button(action: {favourited.toggle()}, label: {
										Image(systemName: favourited ? "star" : "star.fill")
								})
			)
    }
}
