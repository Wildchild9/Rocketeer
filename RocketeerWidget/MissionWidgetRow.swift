//
//  MissionWidgetRow.swift
//  RocketeerWidgetExtension
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI

struct MissionWidgetRow: View {
    var mission: Mission
    
    var body: some View {
        HStack(spacing: 12.5) {
            mission.logo
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 50, height: 50)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(7.5)
                        .shadow(radius: 3)
                )
                .minimumScaleFactor(0.9)


            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text(mission.rocket)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Spacer(minLength: 5)
                    
                    HStack(alignment: .lastTextBaseline) {
                        Image(systemName: "calendar")
                            .font(.subheadline)
                            .foregroundColor(.white)

                        Text(mission.date)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 7)
                    .background(
                        ContainerRelativeShape()
                            .foregroundColor(Color.black.opacity(0.5))
                    )
                }
                Text(mission.payload)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}


extension MissionWidgetRow {
    struct Placeholder: View {
        var mission = Mission.placeholder
        var body: some View {
			HStack(spacing: 12.5) {
				Rectangle()
					.fill(Color.primary.opacity(0.25))
					.cornerRadius(7.5)
					.shadow(radius: 3)
					.frame(width: 50, height: 50)
					.minimumScaleFactor(0.9)

				VStack(alignment: .leading) {
					HStack(alignment: .center) {
						Text(mission.rocket)
							.font(.title3)
							.fontWeight(.semibold)
						
						Spacer(minLength: 5)
						
						Text(mission.date)
							.font(.subheadline)
					}
					Text(mission.payload)
						
				}
			}
			.redacted(reason: .placeholder)
			.onTapGesture(perform: {
				print(false)
			})
		}
    }
}
