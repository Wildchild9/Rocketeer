//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct ContentView: View, Identifiable {
	let id = UUID()
	let dateFormatter = DateFormatter()
	let date = NSDate() as Date
	@State var currentMonth = ""
	@State private var allOrgs: [String] = ["all"]
	@State private var allOrgsPics: [String] = ["all"]
	@State var currentOrg = "all"
    @State var missions: [Mission] = []
	@State var newMissions: [Mission] = []
	@State var labelShow = true
    var body: some View {
		NavigationView {
			ZStack {
				//				LinearGradient(gradient: Gradient(colors: [Color("fancy-start"), Color("fancy-end")]), startPoint: .top, endPoint: .bottom)
				//					.edgesIgnoringSafeArea(.all)
				LinearGradient(gradient: Gradient(colors: [.black, .black]), startPoint: .top, endPoint: .bottom)
					.edgesIgnoringSafeArea(.all)
				
				VStack {
					HStack(alignment: .bottom){
						Spacer()
						if labelShow {
							Text("Scroll for more")
								.font(.caption)
								.aspectRatio(contentMode: .fill)
								.frame(height: 12, alignment: .center)
							Image(systemName: "arrow.right")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 12, height: 12, alignment: .center)
								.padding(.horizontal, 10)
						} else {
							Text(" ")
								.font(.caption)
								.aspectRatio(contentMode: .fill)
								.frame(height: 12, alignment: .center)
						}
						
					}
					
					.foregroundColor(.gray)
					
					ScrollView(.horizontal, showsIndicators: false){
						
						VStack {
							
							
							HStack(alignment: .top, spacing: 18) {
								
								
								ForEach(allOrgs, id: \.self){ a in
									
									FilterButton(full:allOrgs, item: a, isText: a == "all", tapped: a == "all")
										
									
									//									.foregroundColor(.white)
									
									Spacer(minLength: 15)
									
								}
								
								
							}.padding(30)
						}
					}
					.gesture(
						DragGesture().onChanged { value in
							withAnimation {
								labelShow = false
							}
							
						}
					)
					.transition(
						.opacity
					)
					
					ScrollView{
						VStack(alignment:.leading) {
							Text("This Month")
								.font(.title)
								.bold()
								.padding(.horizontal, 30)
								.padding(.top, 30)
								.padding(.bottom, 20)
								.foregroundColor(.white)
								.onTapGesture(perform:{
									switch currentOrg {
									case "all":
										currentOrg = "SpaceX"
										break
									default:
										currentOrg = "all"
										
									}
								})
							
							ForEach(newMissions.filter{$0.date.lowercased().contains(currentMonth) && ($0.org == currentOrg || currentOrg == "all")}) { mission in
								MissionRow(mission: mission, full:allOrgs)
									.padding(.horizontal, 35)
									.padding(.vertical, 10)
							}
							Text("Later")
								.font(.title)
								.bold()
								.padding(.horizontal, 30)
								.padding(.top, 30)
								.padding(.bottom, 20)
								.foregroundColor(.white)
							ForEach(newMissions.filter{!$0.date.lowercased().contains(currentMonth) && !$0.date.lowercased().contains("tbd")  && ($0.org == currentOrg || currentOrg == "all")}) { mission in
								MissionRow(mission: mission, full:allOrgs)
									.padding(.horizontal, 35)
									.padding(.vertical, 10)
							}
							Text("TBD")
								.font(.title)
								.bold()
								.padding(.horizontal, 30)
								.padding(.top, 30)
								.padding(.bottom, 20)
								.foregroundColor(.white)
							ForEach(missions.filter{$0.date.lowercased().contains("tbd")  && ($0.org == currentOrg || currentOrg == "all")}) { mission in
								MissionRow(mission: mission, full:allOrgs)
									.padding(.horizontal, 35)
									.padding(.vertical, 10)
							}
						}
						
					}
					.navigationBarTitle(Text("Launches"), displayMode: .large)
				}
			}
		}
		//		.accentColor(Color.black)
		.onAppear {
			loadLaunchData(to: &missions)
			newMissions = missions
			dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
			currentMonth = dateFormatter.string(from: date).lowercased()
			missions.forEach { m in
				let x = m.rocket.lowercased()
				if !allOrgs.contains(orgNameFromRocket(rocket: x))
				{allOrgs.append(orgNameFromRocket(rocket: x))
					allOrgsPics.append(orgPicFromRocket(rocket: x))}
			}
			
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
			.previewDevice("iPhone 11")
    }
}
