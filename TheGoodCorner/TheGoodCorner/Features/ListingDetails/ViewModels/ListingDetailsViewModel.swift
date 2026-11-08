//
//  ListingDetailsViewModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 7/11/2026.
//

import Foundation
import Combine

@MainActor
final class ListingDetailsViewModel: ObservableObject {
    
    // MARK: - States
    
    enum State {
        case idle
        case loading
        case loaded(CategoryModel)
        case failed(String)
    }
    
    @Published private(set) var state: State = .idle
    @Published private(set) var category: CategoryModel?
    @Published private(set) var errorMessage: String?
    
    private var categoryId: Int?
    
    // MARK: - Dependencies
    
    private let categoryService: CategoryServiceProtocol
    private let connectivityManager: ConnectivityManager
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Init
    
    init(
        categoryService: CategoryServiceProtocol,
        connectivityManager: ConnectivityManager
    ) {
        self.connectivityManager = connectivityManager
        self.categoryService = categoryService
        
        connectivityManager.$isConnected
            .dropFirst()
            .sink { [weak self] isConnected in
                if isConnected {
                    if let categoryId = self?.categoryId {
                        Task {
                            await self?.loadCategory(id: categoryId)
                        }
                    }
                } else {
                    self?.errorMessage = "No internet connection"
                }
            }
            .store(in: &cancellables)
        
    }
    
    // MARK: - Fetch Categories
    
    func loadCategory(id: Int) async {
        categoryId = id
        
        state = .loading
        
        guard connectivityManager.isConnected else {
            state =
                .failed("Could not load categories. Check your connection.")
            return
        }
        
        do {
            let categories = try await categoryService.fetchCategories()
            
            if let found = categories.first(where: { $0.id == id }) {
                category = found
                state = .loaded(found)
            } else {
                let message = "Category not found."
                errorMessage = message
                state = .failed(message)
            }
        } catch {
            state = .failed("Could not load Categories.")
        }
    }
}
