//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionRow: View {
    var mission: Mission
	@State var favourited = false //Cannot be part of the Mission object, unless the object is @State. Will be a variable used to compare the Mission's info to the list of saved Missions' info
    var body: some View {
        NavigationLink(destination: MissionView(mission: mission)) {
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
                Spacer()
                Text(mission.date)
            }
        }
		.contextMenu(){
			HStack{
				Button(action: {
					favourited.toggle()
				}) {
					Text(favourited ? "Unfavourite" : "Favourite")
					Image(systemName: favourited ? "star" : "star.fill")
					   }
				
			}
		}
    }
}
