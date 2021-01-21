//
//  NetworkErrorView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct NetworkErrorView: View {
    @Binding var error: Error?
    
    var body: some View {
        VStack {
            HStack {
                Text("An error occured while communicating with the server.\n\nPlease check your internet connection and try again later.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                // Say something about specific error
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
