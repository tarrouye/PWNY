//
//  RimmedRectView.swift
//  Cover Buddy
//
//  Created by Théo Arrouye on 1/20/21.
//

import SwiftUI

struct RimmedRectButton: View {
    var label : String?
    var systemImage : String?
    var backgroundCol : Color = Color(UIColor.secondarySystemGroupedBackground)
    var foregroundCol : Color = Color(UIColor.label)
    var rimCol : Color = Color(UIColor.label)
    var blurred : Bool = false
    
    var action : (() -> Void)?
    
    var body: some View {
        Button(action: { if (self.action != nil) { self.action!() } }) {
            ZStack {
                if (self.blurred) {
                    BackgroundBlurView()
                }
                
                // Rim
                self.rimCol
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .opacity(self.blurred ? 0.5 : 1.0)
                
                // Background
                self.backgroundCol
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous).inset(by: 1))
                    .padding(1)
                    .opacity(self.blurred ? 0.5 : 1.0)
                
                // Foreground
                HStack {
                    if self.systemImage != nil {
                        Image(systemName: self.systemImage!)
                            .foregroundColor(self.foregroundCol)
                            .font(.headline)
                    }
                    
                    if self.label != nil {
                        Text(self.label!)
                            .foregroundColor(self.foregroundCol)
                            .font(.headline)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
