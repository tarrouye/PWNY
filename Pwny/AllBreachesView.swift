//
//  AllBreachesView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI



struct AllBreachesView: View {
    @State var breaches : [Breach] = []
    
    @Binding var error : Error?
    
    typealias SortDescriptor<Breach> = (Breach, Breach) -> Bool
    let breachSorter : SortDescriptor<Breach> = {
        ($0.modifiedDate ?? defaultDate) > ($1.modifiedDate ?? defaultDate)
    }
    
    func loadBreachesFromCache() {
        if let b = BreachCache.shared.get(forKey: "all") {
            self.breaches = b.sorted(by: breachSorter)
        }
    }
    
    var body: some View {
        ZStack {
            if (self.error == nil) {
                ScrollView(.vertical) {
                    LazyVStack {
                        HStack() {
                            Text("Breach count:")
                                .font(.headline)
                            
                            Text("\(self.breaches.count)")
                                .font(.title2)
                                .foregroundColor(self.breaches.count > 0 ? .red : .green)
                            
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
                        
                        
                        
                        VStack {
                            Spacer()
                            
                            HIBPAttributionView()
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                NetworkErrorView(error: self.$error)
            }
        }
        .navigationTitle("Breaches")
        .onAppear() {
            loadBreachesFromCache()
        }
    }
}

