//
//  RoundedTextField.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct RoundedTextField: View {
    let title: String
    let icon: String?
    
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            if let icon {
                Image(icon)
                    .resizable()
                    .foregroundColor(Color(.gray72))
                    .frame(width: 14, height: 14)
            }
            TextField(title, text: $text)
                .font(.custom("Poppins-Light", size: 13, relativeTo: .body))
                .foregroundColor(Color(.gray72))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(Color(.lightBlue).opacity(0.2))
        .clipShape(.capsule)
    }
}
