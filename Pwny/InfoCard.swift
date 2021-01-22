//
//  InfoCard.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct InfoCard : View {
    var title : String
    var msg : String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.title).fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 5)
                
                Text(self.msg)
                    .font(.headline).fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding()
        .background(
            Color(UIColor.secondarySystemBackground)
        )
        .frame(maxWidth: .infinity)
    }
}
