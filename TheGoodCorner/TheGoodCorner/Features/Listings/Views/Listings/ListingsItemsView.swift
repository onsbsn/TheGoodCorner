//
//  ListingsItemsView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 7/11/2026.
//

import SwiftUI

struct ListingsItemsView: View {
    @ObservedObject var viewModel: ListingsViewModel
    
    @ObservedObject var router: ListingsRouter
    
    var body: some View {
        switch viewModel.listingsState {
        case .idle, .loading:
            ShimmerListingsView()
                .padding(.horizontal)
            
        case .loaded:
            LazyVStack(spacing: 0) {
                ForEach(viewModel.listingsItems) { item in
                    ListingItemView(
                        imageUrl: item.imagesUrl?.imageThumbURL(),
                        title: item.title,
                        price: item.price,
                        dateAgo: try? Date(
                            item.creationDate ?? "2026-11-07T14:30:00Z",
                            strategy: .iso8601
                        ),
                        isUrgent: item.isUrgent
                    ).onTapGesture(perform: {
                        router.push(
                            .details(
                                imageUrl: item.imagesUrl?.imageThumbURL(),
                                title: item.title,
                                price: item.price,
                                dateAgo: try? Date(
                                    item.creationDate ?? "2026-11-07T14:30:00Z",
                                    strategy: .iso8601
                                ),
                                isUrgent: item.isUrgent,
                                description: item.description,
                                categoryId: item.categoryId
                            )
                        )
                    })
                    .padding(.bottom, 20)
                    .padding(.horizontal)
                    .id(item.id)
                }
                
                if viewModel.listingsHasMore == true {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .task {
                            await viewModel.loadListingsNextPage()
                        }
                }
                
            }
            
        case .failed(let message):
            VStack {
                ErrorView(text: message)
            }
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.6)
            .padding(.horizontal)
        }
    }
}
