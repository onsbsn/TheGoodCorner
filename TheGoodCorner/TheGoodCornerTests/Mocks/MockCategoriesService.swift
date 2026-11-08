//
//  MockCategoriesService.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 8/11/2026.
//

import Foundation
@testable import TheGoodCorner

final class MockCategoryService: CategoryServiceProtocol, @unchecked Sendable {
    var fetchCategoriesResult: Result<[CategoryModel], Error> = .success([])
    var fetchCategoriesCallCount = 0

    func fetchCategories() async throws -> [CategoryModel] {
        fetchCategoriesCallCount += 1
        return try fetchCategoriesResult.get()
    }
}
