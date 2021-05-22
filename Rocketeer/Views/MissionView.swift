//
//  MissionView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionView: View {
    var mission: Mission
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("fancy-start"), Color("fancy-end")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                Field(title: "Date", contents: mission.date)
                Field(title: "Launch Time", contents: mission.launchTime)
                Field(title: "Launch Site", contents: mission.launchSite)
                Field(title: "Payload", contents: mission.payload)
                Field(title: "Description", contents: mission.description)
                
                Spacer()
            }
            .foregroundColor(.white)
        }
        .padding(20)
        .navigationTitle(mission.rocket)
        }
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
            MissionView(mission: Mission(date: "", rocket: "", payload: "", launchTime: "", launchSite: "", description: ""))
                .previewDevice("iPhone 11")
                .preferredColorScheme(.dark)
    }
}
