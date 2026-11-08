//
//  APIConfiguration.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 5/11/2026.
//

import Foundation

struct APIConfiguration: Sendable {
    let baseURL: URL
    let timeoutInterval: TimeInterval
    let defaultHeaders: [String: String]

    static let local = APIConfiguration(
        baseURL: URL(string: "http://127.0.0.1:8080")!,
        timeoutInterval: 15,
        defaultHeaders: [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    )

    static var current: APIConfiguration {
        .local
    }
}
