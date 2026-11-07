//
//  CategoriesView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct CategoriesView: View {
    
    @StateObject var viewModel: ListingsViewModel
    
    @Binding var selectedCategory: Int?

    var body: some View {
        switch viewModel.categoriesState {
        case .idle, .loading:
            ShimmerCategoriesView()
        case .loaded(let categories):
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    CategoryItemView(
                        text: "All",
                        isSelected: selectedCategory == nil,
                        action: {
                            selectedCategory = nil
                        }
                    )
                    
                    ForEach(categories) { item in
                        CategoryItemView(
                            text: item.name ?? "Unknown",
                            isSelected: item.id == selectedCategory,
                            action: {
                                selectedCategory = item.id
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
            }.frame(height: 58)
        case .failed(let message):
            Text(message)
        }
    }
}
