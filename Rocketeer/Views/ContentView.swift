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
					VStack(alignment:.leading) {
						Text("This Month")
							.font(.title)
							.bold()
							.padding(.horizontal, 30)
							.padding(.top, 30)
							.padding(.bottom, 20)
						ForEach(missions.filter{$0.date.lowercased().contains(currentMonth)}) { mission in
							MissionRow(mission: mission)
						}
						Text("Later")
							.font(.title)
							.bold()
							.padding(.horizontal, 30)
							.padding(.top, 30)
							.padding(.bottom, 20)
						ForEach(missions.filter{!$0.date.lowercased().contains(currentMonth) && !$0.date.lowercased().contains("tbd")}) { mission in
							MissionRow(mission: mission)
						}
						Text("TBD")
							.font(.title)
							.bold()
							.padding(.horizontal, 30)
							.padding(.top, 30)
							.padding(.bottom, 20)
						ForEach(missions.filter{$0.date.lowercased().contains("tbd")}) { mission in
							MissionRow(mission: mission)
						}
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
