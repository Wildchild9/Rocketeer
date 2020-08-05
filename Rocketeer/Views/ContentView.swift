//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct ContentView: View {
    
	let dateFormatter = DateFormatter()
	let date = NSDate() as Date
	@State var currentMonth = ""
	
    @State var missions: [Mission] = []
    
    var body: some View {
        NavigationView {
			ZStack {
				LinearGradient(gradient: Gradient(colors: [Color("bg-grad-start"), Color("bg-grad-end")]), startPoint: .leading, endPoint: .trailing)
					.edgesIgnoringSafeArea(.all)
				ScrollView{
					Spacer(minLength:30)
					ForEach(missions.filter{$0.date.lowercased().contains("aug")}) { mission in
						MissionRow(mission: mission)
					}
				}
				.navigationBarTitle(Text("Launches"), displayMode: .large)
			}
        }
//		.accentColor(Color.black)
        .onAppear {
            loadLaunchData(to: &missions)
			
			dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
			currentMonth = dateFormatter.string(from: date).lowercased()
		}
    }
	init(){
		UINavigationBar.appearance().largeTitleTextAttributes = [
			.foregroundColor: UIColor.white]
	}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
