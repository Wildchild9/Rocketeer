//
//  SmallMissionWidget.swift
//  RocketeerWidgetExtension
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI
import WidgetKit

struct SmallMissionWidget: View{
    var mission: Mission

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading) {
                HStack {
                    mission.logo
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                        .background(
                            ContainerRelativeShape()
                                .fill(Color.white)
                                .shadow(radius: 3)
                        )
                    
                    Spacer()
                }
                Text(mission.rocket)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.01)
                
                Text(mission.payload)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.01)
                
                Spacer(minLength: 7.5)
                
                HStack(alignment: .lastTextBaseline) {
                    Image(systemName: "calendar")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text(mission.date)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .background(
                    ContainerRelativeShape()
                        .foregroundColor(Color.black.opacity(0.5))
                )
            }
            .padding(15)
        }
    }
}

struct SmallMissionWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallMissionWidget(mission: MissionProvider.placeholderMission)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.light)

            SmallMissionWidget(mission: MissionProvider.placeholderMission)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.dark)
        }
    }
}
