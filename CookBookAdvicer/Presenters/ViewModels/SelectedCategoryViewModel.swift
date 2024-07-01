import Foundation

protocol SelectedCategoryMealsProtocol {
    func fetchMeals(category: TypeCategory) async
}

@MainActor
final class SelectedCategoryViewModel: ObservableObject, SelectedCategoryMealsProtocol {
    
    @Published var meals: [Meal] = []
    @Published var error: Error?
    @Published var showError: Bool = false
    
    private let mealService: MealServiceProtocol
    
    init(mealService: MealServiceProtocol = MealService()) {
        self.mealService = mealService
    }
    
    func fetchMeals(category: TypeCategory) async {
        do {
            let response = try await mealService.fetchMeals(category: category)
            try Task.checkCancellation()
            self.meals = response
        } catch {
            self.error = error
            self.showError = true
            print(error.localizedDescription)
        }
    }
    
}
