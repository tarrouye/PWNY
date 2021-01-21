//
//  URLImage.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct URLImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder

    init(_ url: URL, @ViewBuilder _ placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        self._loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear {
                self.loader.load()
            }
    }

    private var content: some View {
        Group {
            if self.loader.image != nil {
                Image(uiImage: self.loader.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                self.placeholder
            }
        }
    }
}
