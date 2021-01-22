//
//  FoundBreachesView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct FoundBreachesView: View {
    var key : String
    
    @Binding var error: QueryError?
    
    @State var breaches : [Breach] = []
    
    func loadBreachesFromCache() {
        if let b = BreachCache.shared.get(forKey: key) {
            self.breaches = b
        }
    }
    
    var body: some View {
        ZStack {
            if (self.error == nil) {
                ScrollView(.vertical) {
                    VStack {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                Text("Account identifier: ")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("\(self.key)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(self.breaches.count > 0 ? .red : .green)
                            }
                            Spacer()
                        }
                         
                        
                        HStack(spacing: 0) {
                            Text("Found in ")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("\(self.breaches.count)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(self.breaches.count > 0 ? .red : .green)
                            
                            Text(" breaches" + (self.breaches.count > 0 ? ":" : ""))
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        
                        
                        if (self.breaches.count > 0) {
                            ForEach(self.breaches.indices) { id in
                                NavigationLink(destination: BreachView(breach: self.breaches[id])) {
                                    BreachCard(breach: self.breaches[id])
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
            loadBreachesFromCache()
        }
    }
}
