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
	var modal: Bool = false
	let defaults = UserDefaults.init(suiteName: "group.com.noahwilder.Rocketeer")!
    @State var showAlert = false
    @State var cal = "c"
    @State var st = "s"
    @Binding var favourites: Set<String>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading, spacing: 15) {
				if modal {
				Text(mission.rocket)
					.font(.largeTitle)
					.bold()
					.padding(.bottom, 20)
			}
                HStack {
                    Field(title: "Date", contents: mission.date)
                    if mission.date != "TBD" && !mission.date.lowercased().contains("quarter") {
                        Button(action: {
                            switch EKEventStore.authorizationStatus(for: .event) {
                            case .authorized:
                                let e = insertEvent(mission: mission, store: eventStore)
                                cal = e[0]
                                st = e[1]
                                showAlert = true
                            case .denied:
                                eventStore.requestAccess(to: .event, completion: { _, _ in
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
                                eventStore.requestAccess(to: .event, completion: { _, _ in
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
        .navigationBarItems(trailing:
            Button(action: {
                if !favourites.insert(mission.id).inserted {
                    favourites.remove(mission.id)
                }
                defaults.setValue(Array(favourites), forKey: "favouriteLaunches")
            }, label: {
                Image(systemName: favourites.contains(mission.id) ? "star.fill" : "star")
            })
        )
        
    }
}

struct ModalMissionView: View {
	@Binding var mission: Mission
	@Binding var favourites: Set<String>
	@Binding var show: Bool
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					show.toggle()
				}, label: {
					Image(systemName: "chevron.left")
					Text("Back")
				})
				.foregroundColor(.blue)
				.padding(.horizontal, 20)
				.padding(.top, 20)
				.padding(.bottom, -20)
				Spacer()
			}
			MissionView(mission: mission, modal: true, favourites: $favourites)
		}
		
	}
}
