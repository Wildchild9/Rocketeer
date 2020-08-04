//
//  Mission.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

struct Mission: Identifiable, Codable {
    var id = UUID()
    var date: String
    var rocket: String
    var payload: String
    var launchTime: String
    var launchSite: String
    var description: String
}

