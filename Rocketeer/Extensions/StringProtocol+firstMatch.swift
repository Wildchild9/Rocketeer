//
//  String+firstMatch.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

extension StringProtocol where Index == String.Index {
    func firstMatch<Pattern: StringProtocol>(of pattern: Pattern) -> SubSequence? {
        if let matchRange = range(of: pattern, options: .regularExpression, range: nil, locale: nil) {
            return self[matchRange]
        } else {
            return nil
        }
    }
}
