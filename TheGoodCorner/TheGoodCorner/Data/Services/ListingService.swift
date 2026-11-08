//
//  ListingService.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

protocol ListingServiceProtocol: Sendable {
    func fetchListings(
        page: Int?,
        limit: Int?,
        query: String?,
    ) async throws -> ListingsResponseModel
}

struct ListingService: ListingServiceProtocol {
    private let client: any APIClientProtocol

    init(client: any APIClientProtocol) {
        self.client = client
    }

    func fetchListings(
        page: Int? = nil,
        limit: Int? = nil,
        query: String? = nil,
    ) async throws -> ListingsResponseModel {
        try await client.request(
            ListingEndpoint.listings(
                page: page,
                limit: limit,
                query: query
            )
        )
        
    }
}
