//
//  ListingAPIModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct ListingModel: Sendable, Identifiable{
    let id: Int?
    let categoryId: Int?
    let title: String?
    let description: String?
    let price: Int?
    let isUrgent: Bool?
    let imagesUrl: ImagesUrlModel?
    let creationDate: String?
}

extension ListingModel: nonisolated Codable {
}
