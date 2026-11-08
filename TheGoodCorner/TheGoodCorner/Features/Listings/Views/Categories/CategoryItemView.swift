//
//  CategoryItemView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct CategoryItemView: View {
    let text: String
    let isSelected: Bool
    
    let action: () -> Void

    var body: some View {
        Button(action: action){
            Text(text)
                .font(.custom("Poppins-SemiBold", size: 14, relativeTo: .title3))
                .foregroundColor(isSelected ? Color(.darkBlue) : Color(.gray72))
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(isSelected ? Color(.lightBlue).opacity(0.2) : Color.clear)
                .clipShape(.capsule)
        }
    }
}
