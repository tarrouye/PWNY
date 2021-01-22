//
//  SwiftUIView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct HIBPAttributionView: View {
    let sourceURL = URL(string: "https://haveibeenpwned.com/")!
    
    var body: some View {
        Text("All data is sourced from Have I Been Pwned")
            .font(.caption)
            .opacity(0.5)
            .fixedSize()
            .onTapGesture {
                UIApplication.shared.open(sourceURL)
            }
    }
}
