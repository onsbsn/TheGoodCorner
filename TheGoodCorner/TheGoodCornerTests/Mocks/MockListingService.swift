//
//  MockListingService.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import Foundation
@testable import TheGoodCorner

final class MockListingService: ListingServiceProtocol, @unchecked Sendable {
    var fetchListingsResult: Result<ListingsResponseModel, Error> = .success(
        ListingsResponseModel(items: [], total: 0, page: 1, limit: 10, hasMore: false)
    )
    var fetchListingsCallCount = 0
    var lastPage: Int?
    var lastLimit: Int?
    var lastQuery: String?

    func fetchListings(
        page: Int? = nil,
        limit: Int? = nil,
        query: String? = nil
    ) async throws -> ListingsResponseModel {
        fetchListingsCallCount += 1
        lastPage = page
        lastLimit = limit
        lastQuery = query
        return try fetchListingsResult.get()
    }
}
