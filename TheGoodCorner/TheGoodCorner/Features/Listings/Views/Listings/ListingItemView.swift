//
//  ListingItemView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct ListingItemView: View {
    let imageUrl: URL?
    let title: String?
    let price: Int?
    let dateAgo: Date?
    let isUrgent: Bool?
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
            } placeholder: {
                Image("placeholder")
                    .resizable()
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()
            .scaledToFill()
            .clipShape(.rect(topLeadingRadius: 14, topTrailingRadius: 14))
            
            
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(Double(price ?? 0), format: .currency(code: "EUR"))
                        .font(.custom("Poppins-SemiBold", size: 20, relativeTo: Font.TextStyle.title2))
                    Text(title ?? "Unknown Title")
                        .font(.custom("Poppins-Medium", size: 14, relativeTo: .title3))
                    Text(dateAgo ?? Date.now, format: .relative(presentation: .numeric))
                        .font(.custom("Poppins-Thin", size: 12, relativeTo: .footnote))
                        .padding(.bottom, 12)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                isUrgent == true ?
                Image("Urgent")
                    .resizable()
                    .foregroundStyle(.warning)
                    .frame(width: 70, height: 70)
                    .padding()
                : nil
            }
        }
        .clipShape(.rect(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(.gray72), lineWidth: 0.5)
        }
    }
}
