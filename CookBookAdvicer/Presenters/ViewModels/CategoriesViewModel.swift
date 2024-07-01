import Foundation
import Combine

protocol GetCategoriesProtocol {
    func fetchCategories() async
}

@MainActor
final class CategoriesViewModel: ObservableObject, GetCategoriesProtocol {

    @Published var categories: [Category] = []
    @Published var error: Error?
    @Published var showError: Bool = false
//    @Published var selectedCategory: Category?
    
    @Published var categoriesV2: [CategoryV2] = []

    private let service: CategoryServiceProtocol

    init(service: CategoryServiceProtocol = CategoryService()) {
        self.service = service
    }

    // GetCategoriesProtocol
    func fetchCategories() async {
        do {
            let response = try await service.fetchCategory()
            try Task.checkCancellation()
            self.categories = response

        } catch {
            self.error = error
            self.showError = true
            print(error.localizedDescription)
        }
    }
    
    func fetchCategoriesV2() async {
        do {
            let response = try await service.fetchCategoryV2()
            try Task.checkCancellation()
            self.categoriesV2 = response
        } catch {
            self.error = error
            self.showError = true
            print(error.localizedDescription)
        }
    }
}
