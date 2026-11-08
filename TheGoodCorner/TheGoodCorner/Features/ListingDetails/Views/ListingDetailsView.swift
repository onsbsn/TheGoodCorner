//
//  ListingDetailsView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 7/11/2026.
//

import SwiftUI

struct ListingDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel: ListingDetailsViewModel
    
    let imageUrl: URL?
    let title: String?
    let price: Int?
    let dateAgo: Date?
    let isUrgent: Bool?
    let description: String?
    let categoryId: Int?
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    Section {
                        ZStack(alignment: .topLeading){
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                
                            } placeholder: {
                                Image("placeholder")
                                    .resizable()
                                
                            }
                            .frame(width: max(0, geometry.size.width - 32), height: 300)
                            .scaledToFill()
                            .clipped()
                            .clipShape(.rect(cornerRadius: 20))
                            IconButton(
                                action: {
                                    dismiss()
                                },
                                imageName: "chevron.left"
                            )
                            .frame(width: 40, height: 40, alignment: .topLeading)
                            .padding()
                            if isUrgent == true {
                                Color.clear
                                    .frame(width: max(0, geometry.size.width - 32), height: 300)
                                    .overlay(
                                        Circle()
                                            .fill(.warning)
                                            .frame(width: 60, height: 60)
                                            .overlay(
                                                Image("Urgent")
                                                    .resizable()
                                                    .foregroundStyle(.white)
                                                    .frame(width: 50, height: 50)
                                                    .font(.title2)
                                            ).padding(.trailing, 20)
                                            .shadow(
                                                color: colorScheme == .light ? .black.opacity(0.15) : .white.opacity(0.15),
                                                radius: 8, x: 3, y: 6
                                            )
                                            .offset(x: 0, y: 30),
                                        alignment: .bottomTrailing
                                    )
                            }
                        }.padding(.bottom, isUrgent == true ? 30 : 0)
                    }
                    Section {
                        Text(title ?? "Title")
                            .font(.custom("Poppins-SemiBold", size: 22, relativeTo: .title))
                            .foregroundStyle(.carbon)
                        
                        if let dateAgo {
                            Text(dateAgo, format: .relative(presentation: .numeric))
                                .font(.custom("Poppins-Thin", size: 12, relativeTo: .footnote))
                                .padding(.bottom, 12)
                        }
                        if let description {
                            Text(description)
                                .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                                .foregroundStyle(.nightWatch)
                                .padding(.bottom, 10)
                        }
                    }
                    Section {
                        Text("Category")
                            .font(.custom("Poppins-SemiBold", size: 18, relativeTo: .title2))
                            .foregroundStyle(.carbon)
                        switch viewModel.state{
                        case .idle, .loading:
                            ShimmerTextView()
                        case .loaded(let category):
                            Text(category.name ?? "Unknown")
                        case .failed(let message):
                            ErrorTextView(message: message)
                        }
                    }
                }
                .padding(.bottom, 20)
                
            }
            .scrollIndicators(.hidden)
            .conditionalScrollBounceBehavior()
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price")
                        .font(.custom("Poppins-Medium", size: 12, relativeTo: .subheadline))
                        .foregroundStyle(.carbon)
                    
                    Text(Double(price ?? 0), format: .currency(code: "EUR"))
                        .font(.custom("Poppins-Bold", size: 22))
                        .foregroundStyle(.lightBlue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.background)
                
            }
            .navigationBarBackButtonHidden(true)
            .padding()
        }.task {
            if let categoryId {
                await viewModel.loadCategory(id: categoryId)
            }
        }
    }
}
