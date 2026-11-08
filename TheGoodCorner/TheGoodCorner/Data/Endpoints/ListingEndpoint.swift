//
//  ListingEndpoint.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

enum ListingEndpoint: Endpoint {
    case listings(page: Int? = nil, limit: Int? = nil, query: String? = nil)
    
    var path: String {
        switch self {
        case .listings:
            return "listings"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .listings(let page, let limit, let query):
            var items: [URLQueryItem] = []
            
            if let page {
                items.append(URLQueryItem(name: "page", value: String(page)))
            }
            
            if let limit {
                items.append(URLQueryItem(name: "limit", value: String(limit)))
            }
            
            if let query, !query.isEmpty {
                items.append(URLQueryItem(name: "query", value: query))
            }
            
            return items
        }
    }
}
