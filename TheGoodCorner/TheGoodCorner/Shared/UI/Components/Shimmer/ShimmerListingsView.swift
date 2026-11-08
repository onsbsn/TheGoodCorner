//
//  ShimmerListingsView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct ShimmerListingsView: View {
    
    var body: some View {
        LazyVStack(spacing: 10) {
            ForEach(0..<4, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.lightBlue).opacity(0.4))
                    .listRowInsets(EdgeInsets())
                    .frame(height: 150)
                    .modifier(Shimmer())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .padding(.bottom, 20)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
    }
}
