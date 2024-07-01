import Foundation

protocol FetchMealsOfCategoryProtocol {
    func fetchMeals(category: TypeCategory) async
}

@MainActor
final class CategoryListViewModel: ObservableObject, FetchMealsOfCategoryProtocol {
    
    @Published var meals: [Meal] = []
    @Published var error: Error?
    @Published var showError: Bool = false
    
    private let mealService: MealServiceProtocol
    
    init(mealService: MealServiceProtocol = MealService()) {
        self.mealService = mealService
    }
    
    deinit {
        print("❌  \(self)")
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
