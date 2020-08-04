//
//  String+doesMatch.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

extension String {
    func  doesMatch<Target: StringProtocol>(pattern regex: Target) -> Bool {
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
