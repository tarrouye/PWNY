//
//  FoundPastesView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct FoundPastesView: View {
    var key : String
    
    @Binding var error : QueryError?
    
    @State var pastes : [Paste] = []
    
    func loadPastesFromCache() {
        if let p = PasteCache.shared.get(forKey: key) {
            self.pastes = p
        }
    }
    
    var body: some View {
        ZStack {
            if (self.error == nil) {
                ScrollView(.vertical) {
                    VStack {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                Text("Your e-mail: ")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("\(self.key)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(self.pastes.count > 0 ? .red : .green)
                            }
                            Spacer()
                        }
                         
                        
                        HStack(spacing: 0) {
                            Text("Found in ")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("\(self.pastes.count)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(self.pastes.count > 0 ? .red : .green)
                            
                            Text(" pastes" + (self.pastes.count > 0 ? ":" : ""))
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        
                        
                        if (self.pastes.count > 0) {
                            ForEach(self.pastes.indices) { id in
                                Button(action: {
                                    // Link to paste url if exists
                                    if (self.pastes[id].resolvedURLString != nil) {
                                        if let url = URL(string: self.pastes[id].resolvedURLString!) {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                }) {
                                    PasteCard(paste: self.pastes[id])
                                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        HIBPAttributionView()
                            .padding(.top)
                    }
                    .padding(.horizontal)
                }
            } else {
                NetworkErrorView(error: self.$error)
            }
        }
        .navigationTitle("Results")
        .onAppear() {
            loadPastesFromCache()
        }
    }
}

