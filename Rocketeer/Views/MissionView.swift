//
//  MissionView.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI
import EventKit
import MapKit
import CoreLocation

let eventStore = EKEventStore()

struct MissionView: View {
	@Binding var mission: Mission
	let defaults = UserDefaults.init(suiteName: "group.com.noahwilder.Rocketeer")!
	@State var checkpoints: [Checkpoint] = []
	@State var showAlert = false
	@State var cal = "c"
	@State var st = "s"
	@Binding var favourites: Set<String>
	var body: some View {
		ZStack {

			LinearGradient(gradient: Gradient(colors: [Color("background-gradient-start"), Color("background-gradient-end")]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(.all)
			
					ScrollView {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(mission.rocket)
                                    .font(.system(size: 60, weight: .medium, design: .default))
                                    .padding(.init(top:16, leading: 16, bottom:0, trailing: 16))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                                Text(mission.payload)
                                    .font(.system(size: 32, weight: .light, design: .default))
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 20)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.1)
                            }
                            Spacer()
                        }
                        .foregroundColor(favourites.contains(mission.id) ? .white : Color("bw"))
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(
                                    favourites.contains(mission.id) ? Color("accent-orange").opacity(8) : Color("wb").opacity(0.5)
                                )
                                .animation(.easeInOut(duration:0.2))
                                .frame(width: UIScreen.main.bounds.width-40)
                            
                        )
                        .animation(.easeInOut(duration:0.2))
                        .onTapGesture(perform: {
                            
                            if !favourites.insert(mission.id).inserted {
                                favourites.remove(mission.id)
                            }
                            defaults.setValue(Array(favourites), forKey: "favouriteLaunches")
                        })
                        .padding(.init(top: -60, leading: 30, bottom: 16, trailing: 30))
                        
						Spacer(minLength: 20)
						
						HStack(alignment: .top) {
							BoxView(mission: mission, title: "Date", text: mission.date+", "+mission.exactTime)
								.contextMenu(menuItems:{
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
											Text("Add to calendar")
											Image(systemName:"calendar.badge.plus")
												.padding(6)
												.foregroundColor(.white)
										})
										.background(
											RoundedRectangle(cornerRadius: 4)
												.fill(Color.blue)
										)
									}
								})
							//					Spacer(minLength: 10)
							BoxView(mission: mission, title: "Location", text: mission.launchSite)
								.contextMenu(menuItems: {
												Link(destination: URL(string: "maps://?q="+mission.launchSite.replacingOccurrences(of: " ", with: "+"))!, label: {
													Text("Open in Maps")
													Image(systemName: "map")
												})						})
						}
						.minimumScaleFactor(0.1)
						.foregroundColor(.white)
						.alert(isPresented: $showAlert){
							Alert(title: Text("Added \(mission.rocket + " Launch") Event"), message: Text("Event added to '\(cal)' calendar, for \(st)"))
						}
						Spacer()
						ScrollView{
							HStack {
								TabView{
									BoxView(mission: mission, title:"Description", text: mission.description, full:true)
										.padding(.bottom, 40)
									MapViewAdvance(checkpoints: $checkpoints)
										.clipShape(
											RoundedRectangle(cornerRadius: 15)
										)
										.padding(.horizontal, 15)
										.padding(.bottom, 40)
								}
								.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*4/10, alignment: .top)
								.tabViewStyle(PageTabViewStyle())
							}
						}
                        
						
						//					Rectangle().fill(Color.white)
						//						.frame(minHeight: UIScreen.main.bounds.height)
					}
                    .onAppear(){
                        DispatchQueue.global().async {
                            checkpoints.append(Checkpoint(title:"Launch Site", coordinate:mission.coordinate))
                        }
                        
                    }
					
			
		}
		//		.navigationBarHidden(true)
		//		.accentColor(.white)
	}
}

struct BoxView: View {
	var mission:Mission
	var title:String
	var text:String
	var full:Bool = false
	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .center) {
				titleToSystemImage(title: title)
					.opacity(0.6)
				Text(title.lowercased())
					.font(Font.title3.lowercaseSmallCaps().bold())
					.opacity(0.6)
			}
			.padding(.bottom, -5)
			//			Spacer(minLength: 0)
			Divider()
				.background(Color("bw").opacity(0.5))
			Text(text)
				.font(.system(size: 16, weight: .regular, design: .default))
				.minimumScaleFactor(0.1)
			//			Spacer(minLength: 0)
			Spacer(minLength: 0)
		}
		.foregroundColor(Color("bw"))
		.padding(.vertical, 6)
		.padding(.horizontal, 10)
		.background(
			RoundedRectangle(cornerRadius: 15)
				.fill(
					Color("wb").opacity(0.5)
				)
		)
		.frame(width: UIScreen.main.bounds.width/(full ? 1: 2)-(full ? 30: 20), height: full ? nil : 120)
	}
}

struct MissionView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ZStack {
				//
				BoxView(mission: Mission.placeholder, title: "Date", text: "Aug. 29, 3:00 a.m.")
					.background(
						Color("bw")
							.padding(-20)
					)
					.padding(20)
			}
			.previewLayout(/*@START_MENU_TOKEN@*/.sizeThatFits/*@END_MENU_TOKEN@*/)
			.preferredColorScheme(.dark)
			ZStack {
				//
				BoxView(mission: Mission.placeholder, title: "Location", text: "Cape Canaveral Air Force Station, Florida")
					.background(
						Color("bw")
							.padding(-20)
					)
					.padding(20)
			}
			.previewLayout(/*@START_MENU_TOKEN@*/.sizeThatFits/*@END_MENU_TOKEN@*/)
			.preferredColorScheme(.light)
			ZStack {
				//
				BoxView(mission: Mission.placeholder, title: "Description", text: "dsafasd dasd g ds dfd fd asfgdgadsf sdf dsf sdfdsf e sagsdagds afasddgasdfg dsafds gasdfasd fdasgdasf sdfdas gdasf,df sdaf;sdaf.sdf dsf.dsaf sdagasdfifgdfd.f dsfgdasg.dasg df.asd fasd.", full: true)
					.background(
						Color("bw")
							.padding(-20)
					)
					.padding(20)
			}
			.previewLayout(/*@START_MENU_TOKEN@*/.sizeThatFits/*@END_MENU_TOKEN@*/)
			.preferredColorScheme(.light)
		}
		
		
	}
}

func titleToSystemImage(title:String) -> Image {
	switch title.lowercased() {
		case "date":
			return Image(systemName: "calendar")
		case "location":
			return Image(systemName: "mappin.and.ellipse")
		case "description":
			return Image(systemName: "note.text")
		default:
			return Image(systemName: "ellipsis.circle")
	}
}

struct MapView: UIViewRepresentable {
	
	var locationManager = CLLocationManager()
	func setupManager() {
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestAlwaysAuthorization()
	}
	
	func makeUIView(context: Context) -> MKMapView {
		setupManager()
		let mapView = MKMapView()
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
	}
}

final class Checkpoint: NSObject, MKAnnotation {
	let title: String?
	let coordinate: CLLocationCoordinate2D
	
	init(title: String?, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.coordinate = coordinate
	}
}

struct MapViewAdvance: UIViewRepresentable {
	@Binding var checkpoints: [Checkpoint]
	
	func makeUIView(context: Context) -> MKMapView {
		let x = MKMapView()
		if !checkpoints.isEmpty {
			x.centerCoordinate = checkpoints[0].coordinate
		}
		x.mapType = .satelliteFlyover
		return x
	}
	func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
		if !checkpoints.isEmpty {
			mapView.centerCoordinate = checkpoints[0].coordinate
		}
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {
		uiView.addAnnotations(checkpoints)
		if !checkpoints.isEmpty {
			uiView.centerCoordinate = checkpoints[0].coordinate
		}
	}
}
