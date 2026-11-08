//
//  ListingsViewModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation
import Combine

@MainActor
final class ListingsViewModel: ObservableObject {
    
    // MARK: - States
    
    enum CategoriesState {
        case idle
        case loading
        case loaded([CategoryModel])
        case failed(String)
    }
    
    enum ListingsState: Equatable {
        case idle
        case loading
        case loaded
        case failed(String)
    }
    
    @Published private(set) var listingsHasMore: Bool = false
    @Published private(set) var listingsItems: [ListingModel] = []
    @Published private(set) var categories: [CategoryModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var selectedCategory: CategoryModel? = nil
    
    @Published private(set) var categoriesState: CategoriesState = .idle
    @Published private(set) var listingsState: ListingsState = .idle
    
    // MARK: - Dependencies
    private let listingService: ListingServiceProtocol
    private let categoryService: CategoryServiceProtocol
    private let connectivityManager: ConnectivityManager
   
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Pagination & Cancellation
    
    private var currentPage = 1
    private let pageLimit = 10
    private var currentQuery: String?
    
    private var loadTask: Task<Void, Never>?
    
    private var hasPerformedInitialLoad = false
    
    // MARK: - Init
    
    init(
        listingService: ListingServiceProtocol,
        categoryService: CategoryServiceProtocol,
        connectivityManager: ConnectivityManager
    ) {
        self.listingService = listingService
        self.connectivityManager = connectivityManager
        self.categoryService = categoryService
        
        connectivityManager.$isConnected
            .dropFirst()
            .sink { [weak self] isConnected in
                if isConnected {
                    Task {
                        await self?.loadCategories()
                        await self?.loadListings()
                    }
                } else {
                    self?.errorMessage = "No internet connection"
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Load Initials
    
    func loadInitialData() async {
            guard !hasPerformedInitialLoad else { return }
            hasPerformedInitialLoad = true
            
            await loadListings(reset: true)
            await loadCategories()
    }
    
    // MARK: - Fetch Listings
    

    func loadListings(page: Int = 1, limit: Int = 10, query: String? = nil, reset: Bool = false) async {
        guard !isLoading else { return }
        
        if reset {
            currentPage = 1
            currentQuery = query
            listingsItems = []
            listingsHasMore = false
            listingsState = .loading
        } else {
            guard listingsHasMore else { return }
        }
                
        guard connectivityManager.isConnected else {
            errorMessage = "No internet connection"
            listingsState = .failed("Could not load listings. Check your connection.")
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        let requestedPage = reset ? 1 : currentPage + 1
        
        do {
            let response = try await listingService.fetchListings(
                page: requestedPage,
                limit: limit,
                query: currentQuery
            )
            
            let newItems = response.items ?? []
            
            if reset {
                listingsItems = newItems
            } else {
                listingsItems.append(contentsOf: newItems)
            }
            
            currentPage = requestedPage
            listingsHasMore = response.hasMore ?? false
            
            listingsState = .loaded
            
        } catch {
            errorMessage = error.localizedDescription
            
            if reset {
                listingsState = .failed("Could not load listings.")
            }
            
            print("Listings error: \(error)")
        }
    }
    
    func loadListingsNextPage() async {
        guard !isLoading else { return }
        
        guard listingsHasMore else { return }
                
        await loadListings(reset: false)
    }
    
    func loadFilteredListings(categoryId: Int?, query: String?) async {
        guard !isLoading else { return }
        
        currentQuery = query
        
        guard connectivityManager.isConnected else {
            errorMessage = "No internet connection"
            listingsState =
                .failed("Could not load listings. Check your connection.")
            return
        }
        
        isLoading = true
        errorMessage = nil
        listingsHasMore = false
        
        defer {
            isLoading = false
        }
        
        do {
            let response = try await listingService.fetchListings(
                page: nil,
                limit: nil,
                query: currentQuery
            )
            
            var newItems = response.items ?? []
            
            if let categoryId {
                newItems.removeAll { item in
                    item.categoryId != categoryId
                }
            }
            
            listingsItems = newItems
            
            listingsState = .loaded
            
        } catch is CancellationError {
            return
            
        } catch {
            errorMessage = error.localizedDescription
            listingsState = .failed("Could not load listings. Please try again later.")
            print("Listings error: \(error)")
        }
    }
    
    // MARK: - Fetch Categories
    
    func loadCategories() async {
        categoriesState = .loading
        
        guard connectivityManager.isConnected else {
            categoriesState =
                .failed("Could not load categories. Check your connection.")
            return
        }
        
        do {
            categories = try await categoryService.fetchCategories()
            categoriesState = .loaded(categories)
        } catch {
            categoriesState = .failed("Could not load Categories.")
        }
    }
}
