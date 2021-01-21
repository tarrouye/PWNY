//
//  ExplainerView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct ExplainerView: View {
    @Environment(\.presentationMode) var presentationMode

    var cards : [InfoCard] = [
        InfoCard(
            title: "What is this app?",
            msg: "Pwny serves as a simple, user-friendly wrapper for the HaveIBeenPwned API.\n\nIt allows you to check your usernames and e-mails against known breaches and pastes.\n\nIt also allows you to securely check if one of your passwords has been leaked in a known breach."
        ),
        
        InfoCard(
            title: "Why should I care?",
            msg: "If one of your e-mail/password combinations is floating around out there and you are reusing those credentials for another site, you are at risk of having your data stolen.\n\nWe highly reccommend using a unique, strong password for each site.\n\nIf one of your passwords comes up in a breach, promptly change all of your accounts that make use of this password."
        ),
        
        InfoCard(
            title: "What is a breach?",
            msg: "A 'breach' occurs when data is exposed to persons or organizations that should not have been able to view it.\n\nFor example, the infamous 2013 Adobe breach where hackers obtained full records including payment details.\n\nIf a breach has been discovered and reported to HaveIBeenPwned, it will show up in this app and you will be able to check your accounts and passwords against the breach database."
        ),
        
        InfoCard(
            title: "What is a paste?",
            msg: "A 'paste' is a raw text file hosted on sites built for the express purpose of easily sharing/temporarily archiving text.\n\nExamples include Pastebin, Pastie, Slexy, Ghostbin, QuickLeak, JustPaste, AdHocUrl, and OptOut.\n\nHaveIBeenPwned keeps a database of e-mails that have been found in such pastes, and you can check your e-mail against this database.\n\nIf it returns a hit and the link is still live, you can view the paste containing your e-mail."
        ),
        
        InfoCard(
            title: "How are passwords securely checked?",
            msg: "When you hit 'Check Password,' your entered password is securely hashed (converted to an unrecognizable string of letters and numbers).\n\nThe first 5 digits of this hash are uploaded to HaveIBeenPwned, and if there are any hashes matching this prefix, they are returned.\n\nThe returned hashes are then locally compared against your hashed password to see if there is a match.\n\nAt no point does your password or its full hashed value leave your device."
        )
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(self.cards.indices) { id in
                    self.cards[id]
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .padding(.vertical, 2)
                }
                
            }
            .padding(.horizontal)
        }
        .navigationTitle("Help")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                PillButton(label: "Done") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ExplainerView_Previews: PreviewProvider {
    static var previews: some View {
        ExplainerView()
    }
}
