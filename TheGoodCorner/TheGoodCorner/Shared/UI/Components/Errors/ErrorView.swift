//
//  ErrorView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 7/11/2026.
//

import SwiftUI

struct ErrorView: View {
    let text: String?
    var body: some View {
        Image("ErrorIcon")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 120)
        Text("\(text ?? "Error")")
            .font(.custom("Poppins-SemiBold", size: 18, relativeTo: .title))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(40)
            
    }
}
