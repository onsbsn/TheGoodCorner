//
//  ListingModelDecodingTests.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import XCTest
@testable import TheGoodCorner

final class ListingModelDecodingTests: XCTestCase {

    func testListingModelDecodesFullPayload() throws {
        let json = """
        {
            "id": 42,
            "category_id": 3,
            "title": "Vintage Bike",
            "description": "Almost new",
            "price": 150,
            "is_urgent": true,
            "images_url": {
                "thumb": "/images/ad-thumb/bike.jpg",
                "small": "/images/ad-small/bike.jpg"
            },
            "creation_date": "2026-11-01T10:00:00Z"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let listing = try decoder.decode(ListingModel.self, from: json)

        XCTAssertEqual(listing.id, 42)
        XCTAssertEqual(listing.categoryId, 3)
        XCTAssertEqual(listing.title, "Vintage Bike")
        XCTAssertEqual(listing.price, 150)
        XCTAssertEqual(listing.isUrgent, true)
        XCTAssertEqual(listing.imagesUrl?.thumb, "/images/ad-thumb/bike.jpg")
        XCTAssertEqual(listing.imagesUrl?.small, "/images/ad-small/bike.jpg")
    }

    func testListingModelHandlesMissingOptionals() throws {
        let json = """
        {
            "id": 1,
            "title": "Minimal"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let listing = try decoder.decode(ListingModel.self, from: json)

        XCTAssertEqual(listing.id, 1)
        XCTAssertEqual(listing.title, "Minimal")
        XCTAssertNil(listing.categoryId)
        XCTAssertNil(listing.price)
        XCTAssertNil(listing.isUrgent)
        XCTAssertNil(listing.imagesUrl)
    }

    func testListingsResponseModelDecodesEnvelope() throws {
        let json = """
        {
            "items": [
                { "id": 1, "title": "A" },
                { "id": 2, "title": "B" }
            ],
            "total": 2,
            "page": 1,
            "limit": 10,
            "has_more": false
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let response = try decoder.decode(ListingsResponseModel.self, from: json)

        XCTAssertEqual(response.items?.count, 2)
        XCTAssertEqual(response.total, 2)
        XCTAssertEqual(response.page, 1)
        XCTAssertEqual(response.limit, 10)
        XCTAssertEqual(response.hasMore, false)
    }
}
