//
//  Regex.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

struct Regex {
    var pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
    }
}

func ~=(lhs: Regex, rhs: String) -> Bool {
    return rhs.doesMatch(pattern: lhs.pattern)
}

extension String {
    var asRegex: Regex {
        return Regex(self)
    }
}
