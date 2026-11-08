//
//  ListingsResponseModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct ListingsResponseModel: Sendable {
    let items: [ListingModel]?
    let total: Int?
    let page: Int?
    let limit: Int?
    let hasMore: Bool?
}

extension ListingsResponseModel: nonisolated Codable {
}
