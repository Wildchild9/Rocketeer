//
//  FilterButton.swift
//  Rocketeer
//
//  Created by Jacob Tepperman on 2020-08-09.
//

import SwiftUI


struct FilterButton: View {
	var full: [String]
	var item: String
	var isText: Bool = false
	var accent: Color {
		var inn: Int = 0
		if(full.contains(item)) {
			inn = full.firstIndex(where: {$0 == item}) ?? 0
		}
		if accents.count > inn {
			return accents[inn]
			
		}
		return accents[accents.count-1]
		
	}
	
	@State var tapped = false
	var body: some View {
		if(isText)
		{
			Text(item)
				.foregroundColor(tapped ? .black : .white)
				.aspectRatio(contentMode: .fit)
				.frame(width: 40, height: 40, alignment: .center)
				.font(
					Font.system(.largeTitle)
						.smallCaps()
						.bold()
				)
				.minimumScaleFactor(0.01)
				.background(
					ZStack {
						Circle()
							.stroke(accent, lineWidth:5 )
							.frame(width:60, height:60)
							.padding(5)
						Circle()
							.fill(tapped ? accent : Color.clear)
							.frame(width:52, height:52)
							.padding(5)
					}
						
				)
				.onTapGesture(perform: {
					tapped.toggle()
				})
		}
		else
		{
		Image(orgPicFromName(name: item))
			.resizable()
			.renderingMode(.template)
			.foregroundColor(.white)
			.aspectRatio(contentMode: .fill)
			.frame(width: 40, height: 40, alignment: .center)
			.background(
				ZStack {
					Circle()
						.stroke(accent, lineWidth:5 )
						.frame(width:60, height:60)
						.padding(5)
					Circle()
						.fill(tapped ? accent : Color.clear)
						.frame(width:52, height:52)
						.padding(5)
				}
					
			)
			.onTapGesture(perform: {
				tapped.toggle()
			})
			
		}
		
	}
}

struct FilterButton_Previews: PreviewProvider {

	static var previews: some View {
		Group {
			ZStack {
				Rectangle()
					.fill(Color.black)
					.frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				FilterButton(full: that, item: "all", isText: true)
				
			}
			.previewLayout(.sizeThatFits)
			ZStack {
				Rectangle()
					.fill(Color.black)
					.frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				FilterButton(full: that, item: "Arianespace")
				
			}
			.previewLayout(.sizeThatFits)
			ZStack {
				Rectangle()
					.fill(Color.black)
					.frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				FilterButton(full: that, item: "SpaceX")
				
			}
			.previewLayout(.sizeThatFits)
			
			
		}
	}
}
let that = ["all","Arianespace","SpaceX"]
