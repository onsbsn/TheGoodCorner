//
//  ConnectivityManager.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

import Foundation
import Network
import Combine

@MainActor
class ConnectivityManager: ObservableObject {
    @Published private(set) var isConnected: Bool = true
        
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ConnectivityMonitor", qos: .utility)
    
    // MARK: - Init
    
    init() {
        startMonitoring()
    }
    
    deinit {
        monitor.cancel()
    }
        
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            
            let isConnected = path.status == .satisfied
            
            Task { @MainActor [weak self] in
                self?.isConnected = isConnected
            }
        }
        
        monitor.start(queue: queue)
    }
}
