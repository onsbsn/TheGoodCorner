//
//  CategoryService.swift
//  TheGoodCorner
//
//  Created by Ons Ben Slimen on 6/11/2026.
//

protocol CategoryServiceProtocol: Sendable {
    func fetchCategories(
    ) async throws -> [CategoryModel]
}

struct CategoryService: CategoryServiceProtocol {
    private let client: any APIClientProtocol
    
    init(client: any APIClientProtocol) {
        self.client = client
    }
    
    func fetchCategories() async throws -> [CategoryModel] {
        try await client.request(CategoryEndPoint.categories)
    }
}

