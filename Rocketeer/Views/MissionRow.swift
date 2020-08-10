//
//  MissionRow.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct MissionRow: View {
    var mission: Mission
	var full: [String]
	var accent: Color {
		var inn: Int = 0
		if(full.contains(mission.org)) {
			inn = full.firstIndex(where: {$0 == mission.org}) ?? 0
		}
		if accents.count > inn {
			return accents[inn]
			
		}
		return accents[accents.count-1]
		
	}
	let space: CGFloat = 30
    var body: some View {
		NavigationLink(destination: MissionView(mission: mission)) {
		VStack {
			
			
			HStack {
					HStack {
						RoundedRectangle(cornerRadius: 50)
							.fill(accent)
							.frame(maxWidth: 8)
						
						//padding left
						Spacer(minLength: space)
						
						VStack(alignment: .leading){
							//padding top
							Spacer(minLength: space)
							
							HStack(alignment: .top){
								VStack (alignment:.leading){
									Text(mission.payload)
										.foregroundColor(.white)
										.font(
											Font.custom("SanFranciscoText-Light", size: 28)
										)
										.minimumScaleFactor(0.01)
										.lineLimit(2)
									Text(mission.rocket)
										.foregroundColor(.gray)
										.font(
											Font.custom("SanFranciscoText-Light", size: 18)
										)
										.minimumScaleFactor(0.01)
										.lineLimit(1)
								}
								Spacer()
								mission.logo
									.resizable()
									.renderingMode(.template)
									.foregroundColor(.white)
									.aspectRatio(contentMode: .fit)
									.frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
									.padding(5)
									.background(
										RoundedRectangle(cornerRadius: 4)
											.fill(Color.black)
									)
							}
							Spacer()
							HStack(alignment: .bottom){
								Text(mission.date)
									.foregroundColor(.yellow)
	//								.bold()
									.font(
										Font.custom("SanFranciscoText-Light", size: 20)
									)
									.padding(4)
									.background(
										Color.black
									)
									.cornerRadius(6)
							}
							//padding bottom
							Spacer(minLength: space)
							
						}
						//padding right
						Spacer(minLength: space/2)
						VStack {
							Image(systemName: "chevron.right")
								.foregroundColor(.white)
						}
					}
	
				}
				
				
				
			
			
			}
		}
		.contentShape(
			Rectangle()
		)
		.buttonStyle(PlainButtonStyle())
		.padding(.trailing, 20)
//		.padding(.vertical, 20)
		.background(
			RoundedCorners(tl: 5, tr: 20, bl: 5, br: 20)
				.fill(Color("off-black"))
		)
		
	
    }
}

struct MissionRow_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ZStack {
				LinearGradient(gradient: Gradient(colors: [.black, .black]), startPoint: .top, endPoint: .bottom)
					.edgesIgnoringSafeArea(.all)
				ScrollView {
					ForEach([Mission(date: "TBD", rocket: "Falcon 9", payload: "Starlink 9", launchTime: "", launchSite: "Cape Canaveral", description: "DLFHE:j;djfasio aosfijej;faksdjf;asdfjds;", org:"SpaceX"),Mission(date: "TBD", rocket: "Electron", payload: "BlackSky Global", launchTime: "", launchSite: "Cape Canaveral", description: "DLFHE:j;djfasio aosfijej;faksdjf;asdfjds;", org:"Rocketlab"),Mission(date: "TBD", rocket: "Atlas-V", payload: "Mars Perserverance rover", launchTime: "", launchSite: "Cape Canaveral", description: "DLFHE:j;djfasio aosfijej;faksdjf;asdfjds;", org:"ULA"),Mission(date: "TBD", rocket: "Falcon 9", payload: "Starlink 10/ BlackSky Global", launchTime: "", launchSite: "Cape Canaveral", description: "DLFHE:j;djfasio aosfijej;faksdjf;asdfjds;", org:"SpaceX")]) {
						m in
						MissionRow(mission: m, full: ["SpaceX", "Rocketlab", "ULA"])
					.padding(.horizontal, 35)
							.padding(.vertical, 10)
					}
				}
					
			}
			
		}
		
	}
}


struct RoundedCorners: Shape {
	var tl: CGFloat = 0.0
	var tr: CGFloat = 0.0
	var bl: CGFloat = 0.0
	var br: CGFloat = 0.0

	func path(in rect: CGRect) -> Path {
		var path = Path()

		let w = rect.size.width
		let h = rect.size.height

		// Make sure we do not exceed the size of the rectangle
		let tr = min(min(self.tr, h/2), w/2)
		let tl = min(min(self.tl, h/2), w/2)
		let bl = min(min(self.bl, h/2), w/2)
		let br = min(min(self.br, h/2), w/2)

		path.move(to: CGPoint(x: w / 2.0, y: 0))
		path.addLine(to: CGPoint(x: w - tr, y: 0))
		path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
					startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

		path.addLine(to: CGPoint(x: w, y: h - br))
		path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
					startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

		path.addLine(to: CGPoint(x: bl, y: h))
		path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
					startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

		path.addLine(to: CGPoint(x: 0, y: tl))
		path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
					startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

		return path
	}
}
