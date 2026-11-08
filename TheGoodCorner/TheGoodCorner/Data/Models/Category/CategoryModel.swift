//
//  CategoryAPIModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct CategoryModel: Sendable, Identifiable {
    let id: Int?
    let name: String?
}

extension CategoryModel: nonisolated Codable {
    static let empty = CategoryModel(id: nil, name: nil)
}
