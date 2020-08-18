//
//  MissionView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit

let eventStore = EKEventStore()

struct MissionView: View {
    var mission: Mission
	@State var showAlert = false
	@State var cal = "c"
	@State var st = "s"
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
				HStack {
					Field(title: "Date", contents: mission.date)
					if mission.date != "TBD" && !mission.date.lowercased().contains("quarter")
					{Button(action: {
						switch EKEventStore.authorizationStatus(for: .event) {
				  case .authorized:
					let e = insertEvent(mission: mission, store: eventStore)
					cal = e[0]
					st = e[1]
					showAlert = true
					  case .denied:
						eventStore.requestAccess(to: .event, completion:
													{_,_ in
														switch EKEventStore.authorizationStatus(for: .event) {
														case .authorized:
														  let e = insertEvent(mission: mission, store: eventStore)
														  cal = e[0]
														  st = e[1]
														  showAlert = true
														case .denied:
															print(true)
														case .notDetermined:
															print(true)
														case .restricted:
															print(true)
														default:
															print(true)
														}
						})
					  case .notDetermined:
					  // 3
						  eventStore.requestAccess(to: .event, completion:
													  {_,_ in
														  switch EKEventStore.authorizationStatus(for: .event) {
														  case .authorized:
															let e = insertEvent(mission: mission, store: eventStore)
															cal = e[0]
															st = e[1]
															showAlert = true
														  case .denied:
															  print(true)
														  case .notDetermined:
															  print(true)
														  case .restricted:
															  print(true)
														  default:
															  print(true)
														  }
						  })
						  default:
							  print("Case default")
				  }
			  }, label: {
//				Label("Add to Calendar", systemImage: "calendar.badge.plus")
				Image(systemName:"calendar.badge.plus")
					.padding(6)
					.foregroundColor(.white)
			})
					.background(
						RoundedRectangle(cornerRadius: 4)
							.fill(Color.blue)
					)
					.alert(isPresented: $showAlert){
				Alert(title: Text("Added \(mission.rocket + " Launch") Event"), message: Text("Event added to '\(cal) calendar', for \(st)"))
			}}
				}
                Field(title: "Launch Time", contents: mission.launchTime)
                Field(title: "Launch Site", contents: mission.launchSite)
                Field(title: "Payload", contents: mission.payload)
                Field(title: "Description", contents: mission.description)
                
                Spacer()
            }
        }
        .padding(20)
        .navigationTitle(mission.rocket)
		
    }
}


struct MissionView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView
		{MissionView(mission: Mission(date: "Aug 11", rocket: "Falcon 9", payload: "Starlink 11", launchTime: "4 pm", launchSite: "Florida or something", description: "sdkl;alfsdajfklafs;afsfjkj"))}
		.colorScheme(.dark)
	}
}
