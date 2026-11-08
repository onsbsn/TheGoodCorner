//
//  DependencyContainer.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation
import Combine

@MainActor
final class DependencyContainer: ObservableObject {

    static let shared = DependencyContainer()

    let apiClient: APIClientProtocol
    let connectivityManager: ConnectivityManager
    let listingService: ListingServiceProtocol
    let categoryService: CategoryServiceProtocol

    init() {
        let client = APIClient()
        self.apiClient = client
        self.listingService = ListingService(client: client)
        self.categoryService = CategoryService(client: client)
        self.connectivityManager = ConnectivityManager()
    }
    
    func makeListingsViewModel() -> ListingsViewModel {
        ListingsViewModel(
            listingService: listingService,
            categoryService: categoryService,
            connectivityManager: connectivityManager
        )
    }
    
    func makeListingDetailsViewModel() -> ListingDetailsViewModel {
        ListingDetailsViewModel(categoryService: categoryService, connectivityManager: connectivityManager)
    }
}
