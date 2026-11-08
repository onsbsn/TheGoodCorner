//
//  MockConnectivityManager.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import Foundation
import Combine
@testable import TheGoodCorner

@MainActor
final class MockConnectivityManager: ConnectivityManager {

    private var _isConnected: Bool = true

    override var isConnected: Bool {
        get { _isConnected }
        set { _isConnected = newValue }
    }

    override func startMonitoring() { /* no-op */ }
}
