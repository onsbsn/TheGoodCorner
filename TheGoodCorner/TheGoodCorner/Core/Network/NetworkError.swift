//
//  NetworkError.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 5/11/2026.
//


import Foundation

enum NetworkError: Error, LocalizedError, Sendable {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case noInternet
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code, _):
            return "Server error (\(code))"
        case .decodingError:
            return "Failed to process server response"
        case .noInternet:
            return "No internet connection"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
