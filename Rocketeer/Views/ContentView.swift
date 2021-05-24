//
//  ContentView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit

struct ContentView: View {

    
	let defaults = UserDefaults.init(suiteName: "group.com.noahwilder.Rocketeer")!
    @State var missions: [Mission] = []
    @State var favourites: Set<String> = []
	@State var showAlert = false
	@State var cal = "c"
	@State var st = "s"
    var body: some View {

        
        NavigationView {
			VStack {
//                Text(favourites.count > 1 ? "Some" : "None")
                ScrollView {
                    ForEach(missions) { mission in
                        MissionRow(mission: mission, favourites: $favourites)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .contextMenu(menuItems: {
                                Button(action: {
                                    if !favourites.insert(mission.id).inserted {
                                        favourites.remove(mission.id)
                                    }
                                    defaults.setValue(Array(favourites), forKey: "favouriteLaunches")
                                }) {
                                    if favourites.contains(mission.id) {
                                        Text("Unfavourite")
                                        Image(systemName: "star.fill")
                                    } else {
                                        Text("Favourite")
                                        Image(systemName: "star")
                                    }
                                    
                                }
                                    
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
                                        }) {
                                            Text("Add to Calendar")
                                            Image(systemName: "calendar.badge.plus")
                                        }
                                    }
                                })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Added \(mission.rocket + " Launch") Event"), message: Text("Event added to '\(cal)' calendar, for \(st)"))
                            }
                    }
                    .padding(.top, 20)
                    .navigationTitle("Launches")
                }
                .background(
                                LinearGradient(gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]), startPoint: .top, endPoint: .bottom)
                                    .edgesIgnoringSafeArea(.all)
                            )
            }
            
        }
        .onAppear {
            loadLaunchData(to: &missions)
            favourites = Set<String>(defaults.stringArray(forKey: "favouriteLaunches") ?? [])
            if !missions.isEmpty {
                favourites = favourites.intersection(missions.map(\.id))
            }
        }
//        .accentColor(Color("accent-orange"))
        .accentColor(.white)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//func checkStorage(key: String) -> Bool {
//    let u = UserDefaults.standard.value(forKey: "favouriteLaunches") as? Set<Mission>
//	return u.contains(key)
//}
