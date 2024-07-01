import SwiftUI

enum DI {
    static let networkManager: NetworkProtocol = NetworkService()
    static let categoryService: CategoryServiceProtocol = CategoryService(service: networkManager)
    static let mealManager: MealServiceProtocol = MealService(service: networkManager)
    
    enum Preview {
        // TODO : mocks implementation
        static let networkManager: NetworkProtocol = NetworkService()
        static let categoryService: CategoryServiceProtocol = CategoryService(service: networkManager)
        static let mealManager: MealServiceProtocol = MealService(service: networkManager)
    }
}

@main
struct CookBookAdvicerApp: App {

    let service = CategoryService()

    var body: some Scene {
        WindowGroup {
         CategoriesView(service: service)
        }
    }
}
