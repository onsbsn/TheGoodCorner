//
//  ListingsViewModelTests.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import XCTest
import Combine
@testable import TheGoodCorner

@MainActor
final class ListingsViewModelTests: XCTestCase {

    private var listingService: MockListingService!
    private var categoryService: MockCategoryService!
    private var connectivity: MockConnectivityManager!
    private var listingsViewModel: ListingsViewModel!

    override func setUp() async throws {
        listingService = MockListingService()
        categoryService = MockCategoryService()
        connectivity = MockConnectivityManager()
        connectivity.isConnected = true

        listingsViewModel = ListingsViewModel(
            listingService: listingService,
            categoryService: categoryService,
            connectivityManager: connectivity
        )
    }

    // MARK: - Success

    func testLoadListingsSuccessSetsLoadedStateAndItems() async {
        let sample = ListingModel(
            id: 10,
            categoryId: 1,
            title: "Test Listing",
            description: nil,
            price: 99,
            isUrgent: false,
            imagesUrl: nil,
            creationDate: nil
        )

        listingService.fetchListingsResult = .success(
            ListingsResponseModel(
                items: [sample],
                total: 1,
                page: 1,
                limit: 10,
                hasMore: false
            )
        )

        await listingsViewModel.loadListings(reset: true)

        XCTAssertEqual(listingsViewModel.listingsState, .loaded)
        XCTAssertEqual(listingsViewModel.listingsItems.count, 1)
        XCTAssertEqual(listingsViewModel.listingsItems.first?.id, 10)
        XCTAssertFalse(listingsViewModel.listingsHasMore)
        XCTAssertNil(listingsViewModel.errorMessage)
        XCTAssertEqual(listingService.fetchListingsCallCount, 1)
    }

    // MARK: - Error

    func testLoadListingsFailureSetsFailedState() async {
        enum TestError: Error { case network }
        listingService.fetchListingsResult = .failure(TestError.network)

        await listingsViewModel.loadListings(reset: true)

        if case .failed(let message) = listingsViewModel.listingsState {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Expected .failed state")
        }
        XCTAssertNotNil(listingsViewModel.errorMessage)
        XCTAssertTrue(listingsViewModel.listingsItems.isEmpty)
    }

    // MARK: - Offline guard

    func testLoadListingsWhenOfflineDoesNotCallService() async {
        connectivity.isConnected = false

        await listingsViewModel.loadListings(reset: true)

        XCTAssertEqual(listingService.fetchListingsCallCount, 0)
        if case .failed = listingsViewModel.listingsState {
        } else {
            XCTFail("Expected failed state when offline")
        }
        XCTAssertEqual(listingsViewModel.errorMessage, "No internet connection")
    }

    // MARK: - Filtering

    func testLoadFilteredListingsFiltersByCategoryId() async {
        let matching = ListingModel(
            id: 1, categoryId: 5, title: "Match", description: nil,
            price: 10, isUrgent: false, imagesUrl: nil, creationDate: nil
        )
        let other = ListingModel(
            id: 2, categoryId: 9, title: "Other", description: nil,
            price: 20, isUrgent: false, imagesUrl: nil, creationDate: nil
        )

        listingService.fetchListingsResult = .success(
            ListingsResponseModel(
                items: [matching, other],
                total: 2,
                page: 1,
                limit: 10,
                hasMore: false
            )
        )

        await listingsViewModel.loadFilteredListings(categoryId: 5, query: nil)

        XCTAssertEqual(listingsViewModel.listingsItems.count, 1)
        XCTAssertEqual(listingsViewModel.listingsItems.first?.id, 1)
        XCTAssertEqual(listingsViewModel.listingsState, .loaded)
        
        await listingsViewModel.loadFilteredListings(categoryId: 1, query: nil)
        
        XCTAssertEqual(listingsViewModel.listingsItems.count, 0)
        XCTAssertEqual(listingsViewModel.listingsState, .loaded)
    }

    // MARK: - Categories

    func testLoadCategoriesSuccess() async {
        let cats = [
            CategoryModel(id: 1, name: "Vehicles"),
            CategoryModel(id: 2, name: "Furniture")
        ]
        categoryService.fetchCategoriesResult = .success(cats)

        await listingsViewModel.loadCategories()

        XCTAssertEqual(listingsViewModel.categories.count, 2)
        if case .loaded(let loaded) = listingsViewModel.categoriesState {
            XCTAssertEqual(loaded.count, 2)
        } else {
            XCTFail("Expected .loaded categories state")
        }
    }
}
