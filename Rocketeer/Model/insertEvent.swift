//
//  insertEvent.swift
//  Rocketeer
//
//  Created by Jacob Tepperman on 2020-08-18.
//

import Foundation
import EventKit
import UIKit

func insertEvent(mission: Mission, store: EKEventStore) -> [String] {
	
	let calendars = store.calendars(for: .event)
	var calendar = calendars[0]
	var changed = false
	for c in calendars {
		if c.title == "Rocketeer" {
			calendar = c
			changed = true
		}
	}
	if !changed {
		calendar = EKCalendar(for: .event, eventStore: store)

				calendar.title = "Rocketeer"
		calendar.cgColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
		calendar.source = store.defaultCalendarForNewEvents!.source
		do{
			try store.saveCalendar(calendar, commit: true) }
		catch {
			
		}
	}
	
	var d = ""
	var r: Date
	let df = DateFormatter()
	df.dateFormat = "eee MMM dd yyyy"
	let md = mission.date.split(separator: " ").joined(separator: "+")
	let url = URL(string: "https://allpurpose.netlify.app/.netlify/functions/dateParse?a=\(md)")
	do {
		d = try String(contentsOf: url!)
		if d == "TBD" {
				return ["TBD"]
		} else {
		r = df.date(from: d)!
		}
	} catch {
		r = Date()
	}
	
	var start = r
	
	if(mission.exactTime.contains("a.m.")){
		let t = Double(mission.exactTime.split(separator: ":")[0]) ?? 0
		start = start.addingTimeInterval(t == 12 ? 0 : t * 60 * 60)
	} else if(mission.exactTime.contains("p.m.")){
		let t = Double(mission.exactTime.split(separator: ":")[0]) ?? 0
		start = start.addingTimeInterval(((t == 12 ? 0 : t) + 12) * 60 * 60 )
	}
	
	let end = start.addingTimeInterval(2 * 60 * 60)
	
	let event = EKEvent(eventStore: store)
	event.calendar = calendar
	event.title = mission.rocket + " Launch"
	event.startDate = start
	event.endDate = end
	let alarm = EKAlarm(absoluteDate: start.addingTimeInterval(-60*60))
	event.addAlarm(alarm)
	
	do {
		try store.save(event, span: .thisEvent)
	} catch {
		
	}
	df.dateFormat = "eeee',' MMMM dd',' yyyy', at' hh:mm a"
	return [calendar.title, df.string(from: start)]
	
}
