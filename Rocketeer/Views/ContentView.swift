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
			ZStack {
				LinearGradient(gradient: Gradient(colors: [Color("bg-grad-start"), Color("bg-grad-end")]), startPoint: .leading, endPoint: .trailing)
					.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
				ScrollView{
					ForEach(missions) { mission in
						MissionRow(mission: mission)
					}
				}
				.navigationTitle("Launches")
			}
        }
		.accentColor(Color.white)
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
