//
//  APIClient.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 5/11/2026.
//

import Foundation

protocol APIClientProtocol: Sendable {
    func request<T: Decodable & Sendable>(_ endpoint: any Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol, Sendable {

    private let configuration: APIConfiguration
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        configuration: APIConfiguration = .current,
        session: URLSession = .shared
    ) {
        self.configuration = configuration
        self.session = session

        let decoder = JSONDecoder()
        self.decoder = decoder
    }

    func request<T: Decodable & Sendable>(_ endpoint: any Endpoint) async throws -> T {
        let request = try endpoint.makeURLRequest(configuration: configuration)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
