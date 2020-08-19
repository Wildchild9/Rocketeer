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
            
            VStack() {
                MissionWidgetRow(mission: missions[0])
                Spacer(minLength: 7.5)
                Divider()
                Spacer(minLength: 7.5)
                MissionWidgetRow(mission: missions[1])
            }
            .padding(15)

        }
    }
}

extension MediumMissionWidget {
    struct Placeholder: View {
        var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack() {
                    MissionWidgetRow.Placeholder()
                    Spacer(minLength: 7.5)
                    Divider()
                    Spacer(minLength: 7.5)
                    MissionWidgetRow.Placeholder()
                }
                .padding(15)
            }
        }
    }
}


struct MediumMissionWidget_Previews: PreviewProvider {
    static let missions = Array(repeating: Mission.placeholder, count: 2)
    
    static var previews: some View {
        Group {
            MediumMissionWidget(missions: missions)
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.light)
            
            MediumMissionWidget(missions: missions)
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.dark)
            
            MediumMissionWidget(missions: missions)
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.light)
            
            MediumMissionWidget(missions: missions)
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.dark)
            
            MediumMissionWidget.Placeholder()
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.light)
            
            MediumMissionWidget.Placeholder()
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.dark)
            
            MediumMissionWidget.Placeholder()
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.light)
            
            MediumMissionWidget.Placeholder()
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .colorScheme(.dark)
        }
    }
}
