//
//  EndPoint.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 5/11/2026.
//

import Foundation

protocol Endpoint: Sendable {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }

    func makeURLRequest(configuration: APIConfiguration) throws -> URLRequest {
        let url = configuration.baseURL.appendingPathComponent(path)

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkError.invalidURL
        }

        components.queryItems = queryItems

        guard let finalURL = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = configuration.timeoutInterval
        request.httpBody = body

        configuration.defaultHeaders.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
