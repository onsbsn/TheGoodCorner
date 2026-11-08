//
//  ListingsRouter.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import SwiftUI
import Combine

@MainActor
final class ListingsRouter: ObservableObject {
    
    @Published var path: [Route] = []
    func push(_ route: Route) {
        path.append(route)
    }
    func pop() {
        _ = path.popLast()
    }
    func popToRoot() {
        path.removeAll()
    }
    func setPath(_ newPath: [Route]) {
        path = newPath
    }
}
