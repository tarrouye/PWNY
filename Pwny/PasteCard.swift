//
//  PasteCard.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct PasteCard : View {
    var paste : Paste
    
    var body : some View {
        HStack(alignment: .center) {
            // Info
            VStack(alignment: .leading) {
                // Source
                Text("Source: \(paste.source)")
                    .font(.title2)
                    .fontWeight(.regular)
                    .lineLimit(1)
                
                // Source
                if (paste.title != nil) {
                    Text("Title: \(paste.title!)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .lineLimit(1)
                        .padding(.vertical, 2)
                }
            
                
                if (paste.resolvedURLString != nil) {
                    HStack {
                        Image(systemName: "link.circle")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text(paste.resolvedURLString!)
                            .font(.headline)
                            .lineLimit(1)
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
                }
                
                // Main date
                if (paste.prettyDate != nil) {
                    Text("Date: \(paste.prettyDate!)")
                        .font(.caption)
                        .lineLimit(1)
                        .padding(.vertical, 2)
                }
        
                
                // Email count
                Text(paste.prettyEmailCount + " e-mails found in paste.")
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundColor(.red)
            }
        
            
            Spacer()
            
            
            // See more icon
            if (paste.resolvedURLString != nil) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .background(
            Color(UIColor.secondarySystemBackground)
        )
        .frame(maxWidth: .infinity)
    }
}

