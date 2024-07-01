import Foundation

protocol MealServiceProtocol {
    func fetchMeals(category: TypeCategory) async throws -> [Meal]
    func fetchMealDetail(id: String) async throws -> MealDetail?
}

final class MealService: MealServiceProtocol {
    
    let service: NetworkProtocol
    
    init(service: NetworkProtocol = NetworkService()) {
        self.service = service
    }
    
    // MealServiceProtocol
    func fetchMeals(category: TypeCategory) async throws -> [Meal] {
        let response: MealsSelectedCategory = try await service.fetchData(.selectedCategory(selectedCategory: category))
        return response.meals
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail? {
        let response: MealDetails = try await service.fetchData(.mealDetail(id: id))
        
        return response.detail.first
    }
}
