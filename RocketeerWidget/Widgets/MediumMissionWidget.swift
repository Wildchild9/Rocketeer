//
//  MediumMissionWidget.swift
//  RocketeerWidgetExtension
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI
import WidgetKit

struct MediumMissionWidget: View {
    var missions: [Mission]
    
    init(missions: [Mission]) {
        self.missions = Array(missions.prefix(2))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack(spacing: 17.5) {
                MissionWidgetRow(mission: missions[0])
                Divider()
                MissionWidgetRow(mission: missions[1])
            }
            .padding(15)
        }
    }
}

struct MediumMissionWidget_Previews: PreviewProvider {
    static let missions = Array(repeating: MissionProvider.placeholderMission, count: 2)
    
    static var previews: some View {
        Group {
            MediumMissionWidget(missions: missions)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.light)
            
            MediumMissionWidget(missions: missions)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.dark)
        }
    }
}
