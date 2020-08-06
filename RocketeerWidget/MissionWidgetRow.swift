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
        HStack(spacing: 15) {
            mission.logo
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 50, height: 50)
                .background(
                    ContainerRelativeShape()
                        .fill(Color.white)
                        .shadow(radius: 3)
                )
            
            VStack(alignment: .leading) {
                HStack {
                    Text(mission.rocket)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.5)
                        .fixedSize()
                    
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
                
                Text(mission.payload)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
                    .fixedSize()
            }
        }
    }
}

struct MissionWidgetRow_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
