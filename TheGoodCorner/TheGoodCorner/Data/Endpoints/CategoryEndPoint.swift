//
//  CategoryEndPoint.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

enum CategoryEndPoint: Endpoint {
    case categories
    
    var path: String {
        switch self {
        case .categories:
            return "categories"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .categories:
            return nil
        }
    }
}
