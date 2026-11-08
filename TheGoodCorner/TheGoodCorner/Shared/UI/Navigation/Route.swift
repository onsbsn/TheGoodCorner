//
//  Route.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 7/11/2026.
//

import SwiftUI

enum Route: Hashable {
    case details(imageUrl: URL?, title: String?, price: Int?, dateAgo: Date?, isUrgent: Bool?, description: String?, categoryId: Int?)
}
