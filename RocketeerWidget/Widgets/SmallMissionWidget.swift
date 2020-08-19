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
                        .frame(width: 45, height: 45)
                        .background(
                            ContainerRelativeShape()
                                .fill(Color.white)
                                .shadow(radius: 3)
                        )
                        .minimumScaleFactor(0.75)

                    
                    Spacer()
                }
                Text(mission.rocket)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.6)
                
                
                Text(mission.payload)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Spacer(minLength: 5)
                
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


extension SmallMissionWidget {
    struct Placeholder: View {
        var mission = Mission.placeholder
        var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack(alignment: .leading) {
                    HStack {
                        ContainerRelativeShape()
                            .fill(Color.primary.opacity(0.25))
                            .frame(width: 45, height: 45)
                        
                        Spacer()
                    }
                    
                    Text(mission.rocket)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(mission.payload)
                        .font(.body)
                    
                    Spacer(minLength: 5)
                    
                    Text(mission.date)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 8)
                        .background(
                            ContainerRelativeShape()
                                .foregroundColor(Color.black.opacity(0.5))
                        )
                }
                .padding(15)
                .redacted(reason: .placeholder)
            }
        }
    }
}


struct SmallMissionWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallMissionWidget(mission: Mission.placeholder)
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.light)
            
            SmallMissionWidget(mission: Mission.placeholder)
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.dark)
            
            SmallMissionWidget(mission: Mission.placeholder)
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.light)
            
            SmallMissionWidget(mission: Mission.placeholder)
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.dark)
            
            SmallMissionWidget.Placeholder()
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.light)
            
            SmallMissionWidget.Placeholder()
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.dark)
            
            SmallMissionWidget.Placeholder()
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.light)
            
            SmallMissionWidget.Placeholder()
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .colorScheme(.dark)
        }
    }
}
