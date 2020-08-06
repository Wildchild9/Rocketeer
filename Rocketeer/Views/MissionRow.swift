//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionRow: View {
    var mission: Mission
	let space: CGFloat = 30
    var body: some View {
		VStack {
			HStack {
				Spacer(minLength: self.space)
				
				NavigationLink(destination: MissionView(mission: mission)) {
						HStack(alignment: .top) {
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
								HStack {
									Text(mission.rocket)
											.bold()
										.foregroundColor(Color("bg-card-text"))
									Text(mission.date).foregroundColor(Color("white-gray"))
										.font(.subheadline)
								}
								
								Text(mission.payload)
									.foregroundColor(Color("white-gray"))
									.font(.subheadline)
							}
						}
					Spacer(minLength: self.space)
				}
				.buttonStyle(PlainButtonStyle())
				.padding(.horizontal, 20)
				.padding(.vertical, 20)
				.background(RoundedRectangle(cornerRadius: 30).fill(Color("bg-card")))
				
				Spacer(minLength: self.space)
				
			}
			Spacer(minLength: 20)
		}
	
    }
}
