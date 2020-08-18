//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit

struct ContentView: View {
    
    @State var missions: [Mission] = []
	@State var favs: [String] = []
	@State var showAlert = false
	@State var cal = "c"
	@State var st = "s"
    var body: some View {
        NavigationView {
			VStack {
				Text(favs.count>0 ? favs[favs.count-1] : "NONE")
				List(missions) { mission in
                    MissionRow(mission: mission, favourites: $favs)
							.contextMenu(menuItems:{
                                            Button(action: {
                                                var o = UserDefaults.standard.stringArray(forKey: "favouriteLaunches") ?? []
                                                if o.contains(mission.key) {
                                                    o = o.filter {$0 != mission.key}
                                                } else {
                                                    o.append(mission.key)
                                                }
                                                UserDefaults.standard.setValue(o, forKey: "favouriteLaunches")
                                                favs = o
                                            }, label: {
                                                Text(checkStorage(key: mission.key) ? "Unfavourite" : "Favourite" )
                                                Image(systemName: checkStorage(key: mission.key) ? "star" : "star.fill" )
                                            })
                                            
                                            
                                            
                                            
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
                                                    Text("Add to Calendar")
                                                    Image(systemName: "calendar.badge.plus")
                                                })
                                            }})
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Added \(mission.rocket + " Launch") Event"), message: Text("Event added to '\(cal)' calendar, for \(st)"))
                            }
                }
                .navigationTitle("Launches")
            }
        }
        .onAppear {
            loadLaunchData(to: &missions)
            favs = UserDefaults.standard.stringArray(forKey: "favouriteLaunches") ?? []
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func checkStorage(key: String) -> Bool {
	let u = UserDefaults.standard.stringArray(forKey: "favouriteLaunches") ?? []
	return u.contains(key)
}
