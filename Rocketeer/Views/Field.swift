//
//  Field.swift
//  Rocketeer
//
//  Created by Noah Wilder on 2020-08-04.
//

import SwiftUI

struct Field: View {
    var title: String
    var contents: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title + ": ")
                .font(.headline)
                .bold() +
                Text(contents)
        }
    }
}

