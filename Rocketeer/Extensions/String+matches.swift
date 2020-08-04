//
//  String+matches.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import Foundation

extension String {
    func matches<Target: StringProtocol>(for pattern: Target, options: NSRegularExpression.MatchingOptions = []) -> [Substring] {
        return matches(for: pattern, options: options, in: startIndex..<endIndex)
    }
    
    func matches<Target: StringProtocol, Region: RangeExpression>(for pattern: Target, options: NSRegularExpression.MatchingOptions = [], in region: Region) -> [Substring] where Region.Bound == Index {
        do {
            let regex = try NSRegularExpression(pattern: String(pattern))
            
            let results = regex.matches(in: self, options: options, range: NSRange(region.relative(to: self), in: self))
            
            let finalResult = results.map { self[Range($0.range, in: self)!] }
            return finalResult
        } catch let error {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
