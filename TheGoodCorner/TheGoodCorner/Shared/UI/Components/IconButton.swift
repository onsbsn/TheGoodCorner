//
//  IconButton.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import SwiftUI

struct IconButton: View {
    let action: () -> Void
    
    let imageName: String

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .foregroundColor(.primary)
                .frame(width: 10, height: 10)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(.background)
                .cornerRadius(8)
        }
    }
}
