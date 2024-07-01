import Foundation

protocol CategoryServiceProtocol {

    func fetchCategory() async throws -> [Category]
    func fetchCategoryV2() async throws -> [CategoryV2]
}

final class CategoryService: CategoryServiceProtocol {

    let service: NetworkProtocol

    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }

    func fetchCategory() async throws -> [Category] {
        let response: Categories = try await service.fetchData(.categories)
        return response.categories
    }
    
    func fetchCategoryV2() async throws -> [CategoryV2] {
        let response: CategoriesV2 = try await service.fetchData(.categoriesV2)
        return response.categories
    }
}
