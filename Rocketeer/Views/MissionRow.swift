//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit

struct MissionRow: View {
    var mission: Mission
    @Binding var favourites: [String]
    var body: some View {
        NavigationLink(destination: MissionView(mission: mission, favourites: $favourites)) {
            HStack {
				mission.logo
					.resizable()
					.scaledToFit()
					.frame(width: 45, height: 45)
					.padding(2)
					.background(
						RoundedRectangle(cornerRadius: 5)
							.fill(Color.white)
							.shadow(color: Color.black.opacity(0.3), radius: 2)
					)

                VStack(alignment: .leading) {
                    Text(mission.rocket)
                    
                    Text(mission.payload)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
				}
				.padding(2)
				.background(
				RoundedRectangle(cornerRadius: 4)
					.fill( checkStorage(key: mission.key) ? Color.blue.opacity(0.4) : Color.clear)
				)
                Spacer()
                Text(mission.date)
            }
		}
    }
}
