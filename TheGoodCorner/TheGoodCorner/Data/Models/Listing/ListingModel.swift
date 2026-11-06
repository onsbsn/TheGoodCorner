//
//  ListingAPIModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct ListingModel: Codable {
    let id: Int?
    let categoryId: Int?
    let title: String?
    let description: String?
    let price: Int?
    let isUrgent: Bool?
    let imagesUrl: ImagesUrlModel?
    let creationDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price
        case categoryId = "category_id"
        case isUrgent = "is_urgent"
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
    }
}
