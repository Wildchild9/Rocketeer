//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionRow: View {
    var mission: Mission
	@State var favorited = true ? "star" : "star.fill"
    var body: some View {
        NavigationLink(destination: MissionView(mission: mission)) {
            HStack {
                mission.logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .shadow(color: Color.black.opacity(0.3), radius: 2)
                    .cornerRadius(5)

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
