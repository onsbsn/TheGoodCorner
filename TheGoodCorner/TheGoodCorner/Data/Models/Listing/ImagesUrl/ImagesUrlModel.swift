//
//  ImagesUrlAPIModel.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation

struct ImagesUrlModel: Sendable {
    var thumb: String?
    var small: String?
    
    func imageThumbURL(baseURL: URL = APIConfiguration.current.baseURL) -> URL? {
        guard let thumb, !thumb.isEmpty else { return nil }
        
        return baseURL.appendingPathComponent(thumb)
    }
    
    func imageSmallURL(baseURL: URL = APIConfiguration.current.baseURL) -> URL? {
        guard let small, !small.isEmpty else { return nil }

        return baseURL.appendingPathComponent(small)
    }
}

extension ImagesUrlModel: nonisolated Codable {
}

