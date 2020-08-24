//
//  LargeMissionWidget.swift
//  RocketeerWidgetExtension
//
//  Created by Noah Wilder on 2020-08-05.
//

import SwiftUI
import WidgetKit

struct DividerAndSpacer: View {
    var body: some View {
        Spacer(minLength: 7.5)
        Divider()
        Spacer(minLength: 7.5)
    }
}
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
            
            VStack() {
                ForEach(0...3, id: \.self) { i in
					if missions.count > i {
						Link(destination:missions[i].url){
							MissionWidgetRow(mission: missions[i])
						}
					} else {
						MissionWidgetRow.Placeholder()
					}
                    if i < 3 {
                        Spacer(minLength: 7.5)
                        Divider()
                        Spacer(minLength: 7.5)
                    }
                }
            }
            .padding(15)
        }
    }
}

extension LargeMissionWidget {
    struct Placeholder: View {
        var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                VStack() {
                    ForEach(0...3, id: \.self) { i in
                        MissionWidgetRow.Placeholder()
                        if i < 3 {
                            Spacer(minLength: 7.5)
                            Divider()
                            Spacer(minLength: 7.5)
                        }
                    }
                }
                .padding(15)
            }
        }
    }
}

struct LargeMissionWidget_Previews: PreviewProvider {
    static let missions = Array(repeating: Mission.placeholder, count: 4)
    
    static var previews: some View {
        Group {
            LargeMissionWidget(missions: missions)
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.light)
            
            LargeMissionWidget(missions: missions)
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.dark)
            
            LargeMissionWidget(missions: missions)
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.light)
            
            LargeMissionWidget(missions: missions)
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.dark)
            
            LargeMissionWidget.Placeholder()
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.light)
            
            LargeMissionWidget.Placeholder()
                .previewDevice("iPhone 11")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.dark)
            
            LargeMissionWidget.Placeholder()
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.light)
            
            LargeMissionWidget.Placeholder()
                .previewDevice("iPhone 8")
                .previewContext(WidgetPreviewContext(family: .systemLarge))
                .colorScheme(.dark)
        }
    }
}
