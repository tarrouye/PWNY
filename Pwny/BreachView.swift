//
//  BreachView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct BreachView: View {
    @State var breach : Breach
    
    var body: some View {
        VStack {
            // domain
            HStack {
                if (breach.domain != nil) {
                    HStack {
                        Image(systemName: "link.circle")
                            .font(.headline)
                        
                        Text(breach.domain!)
                            .font(.headline)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                // Logo
                Group {
                    if (self.breach.logoPath != nil) {
                        URLImage<Image>(self.breach.logoPath!, { Image(systemName: "exclamationmark.circle.fill") })
                            .frame(width: 35, height: 35)
                            
                    } else {
                        Image(systemName: "exclamationmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                    }
                }
                .padding(2)
                .background(BackgroundBlurView().clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)))
            }
            
            // Date / Num card
            HStack {
                VStack(alignment: .leading) {
                    Text("BREACH DATE")
                        .foregroundColor(.red)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(breach.prettyBreachDate)
                        .padding(.bottom)
                    
                    Text("ADDED TO DATABASE")
                        .foregroundColor(.red)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(breach.prettyAddedDate)
                        .padding(.bottom)
                    
                    Text("INFO LAST UPDATED")
                        .foregroundColor(.red)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(breach.prettyModifiedDate)
                        .padding(.bottom)
                    
                    Text("ACCOUNTS COMPROMISED")
                        .foregroundColor(.red)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(breach.prettyPwnCount)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            
            VStack(alignment: .center) {
                // Details
                HStack(spacing: 0) {
                    Text("What happened?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                AttributedLabelWrapper(html: breach.description ?? "No description available for this breach.")
                
                
                HIBPAttributionView()
                    .padding(.top)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            Spacer()
            
        }
        .padding(.horizontal)
        .navigationTitle(breach.title ?? breach.name)
    }
}
