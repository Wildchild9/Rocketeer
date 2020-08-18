//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit

struct MissionRow: View {
    var mission: Mission
	@State var showAlert = false
	@State var cal = "c"
	@State var st = "s"
    var body: some View {
        NavigationLink(destination: MissionView(mission: mission)) {
            HStack {
				mission.logo
					.resizable()
					.scaledToFit()
					.frame(width: 45, height: 45)
					.padding(2)
					.background(
						RoundedRectangle(cornerRadius: 5)
							.fill(Color.white)
							.shadow(color: Color.black.opacity(0.3), radius: 2)
					)

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
		.contextMenu(menuItems:{
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
				Text("Add to Calendar")
				Image(systemName: "calendar.badge.plus")
			})
			}}).alert(isPresented: $showAlert){
			Alert(title: Text("Added \(mission.rocket + " Launch") Event"), message: Text("Event added to '\(cal)' calendar, for \(st)"))
		   }
    }
}
