//
//  ListingsView.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import SwiftUI

struct ListingsView: View {
    @EnvironmentObject var container: DependencyContainer
    
    @StateObject var viewModel: ListingsViewModel
    
    @State private var searchText: String = ""
    @State private var selectedCategory: Int? = nil
    
    @State private var searchTask: Task<Void, Never>?
    
    @StateObject var router = ListingsRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(
                        alignment: .leading,
                        spacing: 0,
                        pinnedViews: [.sectionHeaders]
                    ) {
                        Section {
                            Text("Explore")
                                .font(.custom("Poppins-Light", size: 18, relativeTo: .title3))
                            
                            Text("The Good Corner")
                                .font(.custom("Poppins-SemiBold", size: 22, relativeTo: .title))
                                .padding(.bottom, 20)
                            
                            RoundedTextField(
                                title: "Search",
                                icon: "SearchIcon",
                                text: $searchText
                            )
                            .padding(.bottom, 20)
                            .onChange(of: searchText) { value in
                                searchTask?.cancel()
                                
                                let query = value.trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                searchTask = Task {
                                    try? await Task.sleep(for: .milliseconds(500))
                                    
                                    guard !Task.isCancelled else { return }
                                    
                                    await viewModel.loadListings(query: query, reset: true)                              }
                            }
                        }
                        .padding(.horizontal)
                        
                        Section {
                            ListingsItemsView(viewModel: viewModel, router: router)
                        } header: {
                            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                CategoriesItemsView(
                                    viewModel: viewModel,
                                    selectedCategory: $selectedCategory
                                )
                                .padding(.bottom, 10)
                                .background(Color(uiColor: .systemBackground))
                                .zIndex(1)
                                .id("categories")
                            }
                        }
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .scrollIndicators(.hidden)
                .onChange(of: selectedCategory) { state in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        proxy.scrollTo("categories", anchor: .top)
                    }
                }
                .clipped()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .simultaneousGesture(
                    TapGesture().onEnded {
                        endEditing()
                    }
                )
            }
            .task {
                await viewModel.loadInitialData()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .details(
                    let imageUrl,
                    let title,
                    let price,
                    let dateAgo,
                    let isUrgent,
                    let description,
                    let categoryId
                ):
                    ListingDetailsView(
                        viewModel: container.makeListingDetailsViewModel(),
                        imageUrl: imageUrl,
                        title: title,
                        price: price,
                        dateAgo: dateAgo,
                        isUrgent: isUrgent,
                        description: description,
                        categoryId: categoryId
                    )
                }
            }
        }
    }
}
