//
//  BreachCard.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct BreachCard : View {
    @State var breach : Breach
    
    var body : some View {
        HStack(alignment: .center) {
            // Logo
            Group {
                if (self.breach.logoPath != nil) {
                    URLImage<Image>(self.breach.logoPath!, { Image(systemName: "exclamationmark.circle.fill") })
                        .frame(width: 75, height: 75)
                        
                } else {
                    Image(systemName: "exclamationmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                }
            }
            .padding(2)
            .background(BackgroundBlurView().clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)))
            .padding(.trailing)
            
            // Info
            VStack(alignment: .leading) {
                // Name
                Text(breach.title ?? breach.name)
                    .font(.title2)
                
                // Main date
                Text(breach.prettyModifiedDate)
                    .font(.caption)
                    .padding(.vertical, 2)
                
                // Pwn count
                Text(breach.prettyPwnCount + " accounts affected")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            // See more icon
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .padding()
        .background(
            Color(UIColor.secondarySystemBackground)
        )
        .frame(maxWidth: .infinity)
    }
}

