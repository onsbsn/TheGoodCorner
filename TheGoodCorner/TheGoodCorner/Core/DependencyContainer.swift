//
//  DependencyContainer.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation
import Combine

@MainActor
final class DependencyContainer: ObservableObject {

    static let shared = DependencyContainer()

    let apiClient: APIClientProtocol
    let connectivityManager: ConnectivityManager

    init() {
        let client = APIClient()
        self.apiClient = client
        self.connectivityManager = ConnectivityManager()
    }
}
