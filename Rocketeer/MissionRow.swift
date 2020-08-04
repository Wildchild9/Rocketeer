//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionRow: View {
    var mission: Mission
    
    var body: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                VStack(alignment: .leading) {
                    Text(mission.rocket)
                    
                    Text(mission.payload)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
                Spacer()
                Text(mission.date)
            }
        }
    }
}
