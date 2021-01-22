//
//  HomeView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/20/21.
//

import SwiftUI

struct HomeView: View {
    @State var isShowingAllBreaches : Bool = false
    @State var isShowingHelp : Bool = false
    
    @State var error : QueryError? = nil
    
    func loadAllBreaches() {
        HIBPQueryManager.shared.getAllBreachInfo() { err in
            self.error = err
            self.isShowingAllBreaches = true
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                // empty navlink to trigger programatically
                NavigationLink(destination: AllBreachesView(error: self.$error), isActive: self.$isShowingAllBreaches) {}
                NavigationLink(destination: ExplainerView(), isActive: self.$isShowingHelp) {}
                
                VStack {
                    // Account / Email check
                    AccountHackView()
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .padding(.horizontal)
                    
                    // Password check
                    PasswordHackView()
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .padding(.horizontal)
                    
                    // Breached companies
                    Button(action: {
                        self.loadAllBreaches()
                    }) {
                        ZStack {
                            Color(UIColor.secondarySystemBackground)
      
                            HStack {
                                Text("View All Breaches")
                                    .font(.title2)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            .padding()
                            .padding(.vertical, 5)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal)
                }
                
                    
                HIBPAttributionView()
                    .padding(.top)
            }
            .navigationTitle("PWNY")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PillButton(label: "Help") {
                        self.isShowingHelp = true
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
