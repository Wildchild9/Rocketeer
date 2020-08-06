//
//  LargeMissionWidget.swift
//  RocketeerWidgetExtension
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI
import WidgetKit

struct LargeMissionWidget: View {
    var missions: [Mission]
    
    init(missions: [Mission]) {
        self.missions = Array(missions.prefix(4))
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
                Divider()
                MissionWidgetRow(mission: missions[2])
                Divider()
                MissionWidgetRow(mission: missions[3])
            }
            .padding(15)
        }
    }
}

struct LargeMissionWidget_Previews: PreviewProvider {
    static let missions = Array(repeating: MissionProvider.placeholderMission, count: 4)
    
    static var previews: some View {
        Group {
            LargeMissionWidget(missions: missions)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.light)
            
            LargeMissionWidget(missions: missions)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.dark)
        }
    }
}
