//
//  NetworkErrorView.swift
//  Pwny
//
//  Created by Théo Arrouye on 1/21/21.
//

import SwiftUI

struct NetworkErrorView: View {
    @Binding var error: QueryError?
    
    func message() -> String {
        if (error != nil) {
            switch(error!) {
            case .input:
                return "Your input was not properly formatted.\n\nPlease try again."
            case .input_need_email:
                    return "Your input was not properly formatted.\n\nThis function requires that you input an e-mail address.\n\nPlease try again."
            case .network:
                return "An error occured while communicating with the server.\n\nPlease check your internet connection and try again later."
            case .decode:
                return "An error occured while decoding the data from the server.\n\nPlease try again and contact the developer if the problem persists."
            default:
                return "An unexpected error has occured.\n\nPlease try again and contact the developer if the problem persists."
            }
        }
        
        return ""
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(message())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
