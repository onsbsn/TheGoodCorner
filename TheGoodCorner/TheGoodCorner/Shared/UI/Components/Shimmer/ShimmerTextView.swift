//
//  ShimmerTextView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import SwiftUI

struct ShimmerTextView:View {
    var body: some View {
        Text("Text Loading")
            .font(.custom("Poppins-regular", size: 16, relativeTo: .body))
            .clipped()
            .modifier(Shimmer())
    }
}
