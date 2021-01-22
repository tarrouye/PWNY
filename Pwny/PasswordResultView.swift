//
//  PasswordResultView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct PasswordResultView: View {
    @Binding var hashPrefix : String
    @Binding var count : Int
    @Binding var error : Error?
    
    var body: some View {
        ZStack {
            if (self.error == nil) {
                VStack {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading) {
                            Text("Password (hash prefix): ")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("\(self.hashPrefix)")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(self.count > 0 ? .red : .green)
                        }
                        Spacer()
                    }
                    .padding(.bottom)
                     
                    
                    HStack(spacing: 0) {
                        Text("Found ")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("\(self.count)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(self.count > 0 ? .red : .green)
                        
                        Text(" times!")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    if (self.count > 0) {
                        HStack(spacing: 0) {
                            Text("Please ensure that you change this password anywhere you are using it.\n\nWe highly recommend using a strong, unique password for each site/account.")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            } else {
                NetworkErrorView(error: self.$error)
            }
            
            VStack {
                Spacer()
                
                HIBPAttributionView()
            }
        }
        .navigationTitle("Results")
    }
}
