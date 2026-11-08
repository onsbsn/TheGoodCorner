//
//  ErrorTextView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import SwiftUI

struct ErrorTextView: View {
    let message: String
    
    var body: some View {
        HStack(spacing: 15){
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.warning)
            Text(message)
                .font(.custom("Poppins-Medium", size: 16, relativeTo: .body))
                .foregroundStyle(.warning)
        }
    }
}
