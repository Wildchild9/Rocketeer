//
//  b64Encode.swift
//  Rocketeer
//
//  Created by Jacob Tepperman on 2020-08-18.
//

import Foundation
func b64Encode(input: String) -> String {
	let str = input.data(using: .utf8)
	return str!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
}
