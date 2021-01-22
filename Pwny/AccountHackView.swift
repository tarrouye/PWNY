//
//  AccountHackView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/20/21.
//

import SwiftUI

struct AccountHackView: View {
    @State var fullSize : Bool = false
    
    @State var usernameFieldInput : String = ""
    
    @State var showingBreachResults : Bool = false
    @State var showingPasteResults : Bool = false
    
    @State var error : Error? = nil
    
    func checkBreaches() {
        QueryManager.shared.getAllBreachesForAccount(self.usernameFieldInput) { err in
            // on success, show results
            self.error = err
            self.showingBreachResults = true
        }
    }
    
    func checkPastes() {
        QueryManager.shared.getAllPastesForAccount(self.usernameFieldInput) { err in
            // on success, show results
            self.error = err
            self.showingPasteResults = true
        }
    }
    
    func expand() {
        withAnimation {
            self.fullSize.toggle()
        }
    }
    
    var body: some View {
        VStack {
            // Empty navlink to trigger programatically
            NavigationLink(destination: FoundBreachesView(key: usernameFieldInput, error: self.$error), isActive: self.$showingBreachResults) {}
            
            NavigationLink(destination: FoundPastesView(key: usernameFieldInput, error: self.$error), isActive: self.$showingPasteResults) {}
            
            // Header
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 50, height: 50)
                    
                    Spacer()
                    
                    Text("Account Check")
                        .font(.title).fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 2)
                    
                    Spacer()
                        
                    Image(systemName: self.fullSize ? "chevron.down" : "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            self.expand()
                        }
                }
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity)
            
                Text("Check if any accounts associated with your e-mail or username were leaked in known breaches or found on any paste sites.")
                    .font(.headline)
                    //.fontWeight(.regular)
                    .lineLimit(5)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 2)
            }
            
            if (self.fullSize) {
                VStack {
                    // Email input field
                    VStack(alignment: .leading) {
                        Text("E-mail / Username:")
                            .font(.headline)
                        TextField("identifier", text: self.$usernameFieldInput)
                            .padding()
                            .background(Color(UIColor.tertiarySystemBackground).clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous).inset(by: 1)).padding(1).background(Color.green))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    .transition(.move(edge: .bottom))
                    
                    // Check button
                    RimmedRectButton(label: "Check Breaches", backgroundCol: .green) {
                        self.checkBreaches()
                    }
                    .transition(.move(edge: .bottom))
                    
                    Text("Note: Pastes are only checked for emails and as such will not return any results for usernames.")
                        .font(.headline)
                        .fontWeight(.regular)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top)
                    
                    // Check paste button
                    RimmedRectButton(label: "Check Pastes", backgroundCol: .blue) {
                        self.checkPastes()
                    }
                    .transition(.move(edge: .bottom))
                }
                .padding(.top)
            }
        }
        .padding()
        .background(
            Color(UIColor.secondarySystemBackground)
        )
        .onTapGesture {
            if !self.fullSize {
                self.expand()
            }
        }
    }
}

struct AccountHackView_Previews: PreviewProvider {
    static var previews: some View {
        AccountHackView()
    }
}
