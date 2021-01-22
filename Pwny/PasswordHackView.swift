//
//  AccountHackView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/20/21.
//

import SwiftUI

struct PasswordHackView: View {
    @State var fullSize : Bool = false
    @State var textFieldInput : String = ""
    
    @State var fieldSecured: Bool = true
    
    @State var showingSecureExplainer = false
    let passwordSecureExplain : String = "We will securely hash your password locally on your device, then compare the hashed password to the list of leaked passwords. Your password will never leave your device."
    
    @State var foundNumber : Int = 0
    @State var foundHashPrefix : String = ""
    @State var foundError : Error? = nil
    
    @State var isShowingResults : Bool = false
    
    func checkPassword() {
        HIBPQueryManager.shared.checkPwnedPassword(self.textFieldInput) { error, hash, result in
            self.foundError = error
            self.foundNumber = result
            self.foundHashPrefix = hash
            
            self.isShowingResults = true
        }
    }
    
    func expand() {
        withAnimation {
            self.fullSize.toggle()
        }
    }
    
    var body: some View {
        VStack {
            //Empty navlink to trigger programatically
            NavigationLink(destination: PasswordResultView(hashPrefix: self.$foundHashPrefix, count: self.$foundNumber, error: self.$foundError), isActive: self.$isShowingResults) {}.frame(width: 0, height: 0)
            
            // Header
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: "lock.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.purple)
                        .frame(width: 50, height: 50)
                    
                    Spacer()
                    
                    Text("Password Check")
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
            
                Text("Securely check if your password has been leaked in any known breaches. Your password will never leave your device.")
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
                        Text("Password:")
                            .font(.headline)
                        
                        VStack(alignment: .leading) {
                            SecureField("password", text: self.$textFieldInput)
                            
                            if (!self.fieldSecured) {
                                Text(self.textFieldInput)
                                    .kerning(1.2)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.tertiarySystemBackground).clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous).inset(by: 1)).padding(1).background(Color.purple))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .overlay(
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        self.fieldSecured.toggle()
                                    }
                                }) {
                                    Image(systemName: self.fieldSecured ? "eye.fill" : "eye.slash")
                                        .foregroundColor(.purple)
                                        .frame(width: 20, height: 20)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .offset(x: -15)
                            }
                        )
                    }
                    .transition(.move(edge: .bottom))
                    
                    // Check button
                    RimmedRectButton(label: "Check Password", backgroundCol: .purple) {
                        self.checkPassword()
                    }
                    .transition(.move(edge: .bottom))
                    
                    // Info button
                    RimmedRectButton(label: "How is my password kept secure?", foregroundCol: .purple, rimCol: .purple) {
                        self.showingSecureExplainer.toggle()
                    }
                    .transition(.move(edge: .bottom))
                    .alert(isPresented: self.$showingSecureExplainer) {
                        Alert(title: Text("How is your password kept secure?"), message: Text(self.passwordSecureExplain), dismissButton: .default(Text("OK")))
                    }
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

