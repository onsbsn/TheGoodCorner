//
//  ShimmerV.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct ShimmerView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(0..<4, id: \.self) { _ in
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 100, height: 58)
                        .modifier(Shimmer())
                }
            }
        }.frame(height: 58, alignment: .top)
        
        
    }
}
