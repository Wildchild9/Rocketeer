//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct ContentView: View {
    
    @State var missions: [Mission] = []
    
    var body: some View {
        NavigationView {
            ScrollView{
				ForEach(missions) { mission in
					MissionRow(mission: mission)
				}
			}
            .navigationTitle("Launches")
        }
		.accentColor(Color.black)
        .onAppear {
            loadLaunchData(to: &missions)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
