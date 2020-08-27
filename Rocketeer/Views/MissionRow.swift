//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit

struct MissionRow: View {
    @State var mission: Mission
    @Binding var favourites: Set<String>
    var body: some View {
		NavigationLink(destination: MissionView(mission: $mission, favourites: $favourites)) {
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
                    .fill(favourites.contains(mission.id) ? Color("accent-orange").opacity(0.4) : Color.clear)
				)
				.animation(.easeInOut(duration:0.2))
                Spacer()
                Text(mission.date)
            }
		}
    }
}
