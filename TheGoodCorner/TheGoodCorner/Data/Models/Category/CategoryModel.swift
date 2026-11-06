//
//  CategoryAPIModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct CategoryModel: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
