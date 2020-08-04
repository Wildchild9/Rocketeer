//
//  String+removeHtmlSpecialCharacters.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

extension String {
    func removeHtmlSpecialCharacters() -> String {
        var str = replacingOccurrences(of: "&#8217;", with: "'")
        str = str.replacingOccurrences(of: "&#038;", with: "&")
        str = str.replacingOccurrences(of: "&#8220;", with: "\"")
        str = str.replacingOccurrences(of: "&#8221;", with: "\"")
        str = str.replacingOccurrences(of: "<(.+?)>(.+?)</\\1>", with: "$2", options: .regularExpression)
        return str
    }
}
