//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionRow: View {
    var mission: Mission
    @State var favorited = true
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
				
			}
		}
    }
}
